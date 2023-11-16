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


    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    

	# =====================================
    # LOAD MATRICES
    # =====================================

    # s0: argc | s1, s2: address of mat0, mat1 | s3, s4: address of row/column of mat0, mat1
    mv s0, a0
    lw s1, 0(a1)
    lw s2, 4(a1)
    beq s1, x0, wrong_argument
    beq s2, x0, wrong_argument
    lw t0, 8(a1)
    bne t0, x0, wrong_argument

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






    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)













    


    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix





    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax




    # Print classification
    



    # Print newline afterwards for clarity




    ret
    
malloc_error:
    li a1, 88
    jal exit2

wrong_argument:
    li a1, 89
    jal exit2