.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # Exceptions:
    # - If there are an incorrect number of command line args,
    #   this function terminates the program with exit code 89.
    # - If malloc fails, this function terminats the program with exit code 88.
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>


    addi sp, sp, -44
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)
    sw s8, 36(sp)
    sw s9, 40(sp)

	# =====================================
    # LOAD MATRICES
    # =====================================

    # s0: print_classification | s1, s2: address of mat0, mat1 
    # s3, s4: address of row/column of mat0, mat1
    # s5: address of input mat | s6: address of row/column of input mat
    # s7: output name, later store the classfication
    # s8: address of hidden_layer mat | s9: address of score mat
    
    li t0, 5
    bne a0, t0, wrong_argument
    mv s0, a2
    lw s1, 4(a1)
    lw s2, 8(a1)
    lw s5, 12(a1)
    lw s7, 16(a1)

    # Load pretrained m0
    li a0, 8
    jal malloc
    beq a0, x0, malloc_error
    mv s3, a0
    mv a1, s3
    addi a2, a1, 4
    mv a0, s1
    jal read_matrix
    mv s1, a0

    # Load pretrained m1
    li a0, 8
    jal malloc
    beq a0, x0, malloc_error
    mv s4, a0
    mv a1, s4
    addi a2, a1, 4
    mv a0, s2
    jal read_matrix
    mv s2, a0

    # Load input matrix
    li a0, 8
    jal malloc
    beq a0, x0, malloc_error
    mv s6, a0
    mv a1, s6
    addi a2, a1, 4
    mv a0, s5
    jal read_matrix
    mv s5, a0

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)

    # hidden_layer = matmul(m0, input)
    # We alloc extra 4bytes at the start of mat to store #elements.
    lw a0, 0(s3)
    lw t1, 4(s6)
    mul a0, a0, t1
    slli a0, a0, 2
    addi a0, a0, 4
    jal malloc
    beq a0, x0, malloc_error
    mv s8, a0
    
    mv a0, s1
    lw a1, 0(s3)
    lw a2, 4(s3)
    mv a3, s5
    lw a4, 0(s6)
    lw a5, 4(s6)
    
    mul t0, a1, a5
    sw t0, 0(s8)
    
    mv a6, s8
    addi a6, a6, 4
    jal matmul
    
    # relu(hidden_layer)
    mv a0, s8
    addi a0, a0, 4
    lw a1, 0(s8)
    jal relu
    
    # scores = matmul(m1, hidden_layer)
    lw a0, 0(s4)
    lw t1, 4(s6)
    mul a0, a0, t1
    slli a0, a0, 2
    addi a0, a0, 4
    jal malloc
    beq a0, x0, malloc_error
    mv s9, a0
    
    mv a0, s2
    lw a1, 0(s4)
    lw a2, 4(s4)
    mv a3, s8
    addi a3, a3, 4
    lw a4, 0(s3)
    lw a5, 4(s6)
    
    mul t0, a1, a5
    sw t0, 0(s9)
    
    mv a6, s9
    addi a6, a6, 4
    jal matmul

    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    mv a0, s7
    mv a1, s9
    addi a1, a1, 4
    lw a2, 0(s4)
    lw a3, 4(s6)
    jal write_matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    mv a0, s9
    addi a0, a0, 4
    lw a1, 0(s9)
    jal argmax
    mv s7, a0

    # Print classification
    bne s0, x0, skip_print 
    mv a1, s7
    jal print_int

    # Print newline afterwards for clarity
    li    a1, '\n'
    jal print_char

skip_print:
    mv a0, s1
    jal free
    mv a0, s2
    jal free
    mv a0, s3
    jal free
    mv a0, s4
    jal free
    mv a0, s5
    jal free
    mv a0, s6
    jal free
    mv a0, s8
    jal free
    mv a0, s9
    jal free
    # Return print_classification
    mv a0, s7
    
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9, 40(sp)
    addi sp, sp, 44
    
    ret
    
malloc_error:
    li a1, 88
    jal exit2

wrong_argument:
    li a1, 89
    jal exit2