.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks
    ble a1, x0, exception1
    ble a2, x0, exception1
    ble a4, x0, exception2
    ble a5, x0, exception2
    bne a2, a4, exception3
    # Prologue
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    li s0, 0
    
outer_loop_start:
    beq s0, a1, outer_loop_end
    li s1, 0
    
inner_loop_start:
    beq s1, a5, inner_loop_end
    mul s2, s0, a5
    add s2, s2, s1
    slli s2, s2, 2
    add s2, s2, a6
    
    # Prologue
    addi sp, sp, -32
    sw ra, 0(sp)
    sw a0, 4(sp)
    sw a1, 8(sp)
    sw a2, 12(sp)
    sw a3, 16(sp)
    sw a4, 20(sp)
    sw a5, 24(sp)
    sw a6, 28(sp)

    mul t0, s0, a2
    slli t0, t0, 2
    add a0, a0, t0
    slli t0, s1, 2
    add a1, a3, t0
    # mv a2, a2
    li a3, 1
    mv a4, a5
    jal dot
    sw a0, 0(s2)
    
    # Epilogue
    lw ra, 0(sp)
    lw a0, 4(sp)
    lw a1, 8(sp)
    lw a2, 12(sp)
    lw a3, 16(sp)
    lw a4, 20(sp)
    lw a5, 24(sp)
    lw a6, 28(sp)
    addi sp, sp, 32
    
    addi s1, s1, 1
    j inner_loop_start
    
inner_loop_end:
    addi s0, s0, 1
    j outer_loop_start
    
outer_loop_end:
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12
    ret

exception1:
    li a0, 17
    li a1, 72
    ecall
exception2:
    li a0, 17
    li a1, 73
    ecall
exception3:
    li a0, 17
    li a1, 74
    ecall