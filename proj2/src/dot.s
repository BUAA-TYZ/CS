.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    # t0: counter | t1: res
    li t0, 0
    li t1, 0
    ble a2, t0, exception1
    ble a3, t0, exception2
    ble a4, t0, exception2
loop:   
    beq t0, a2, end
    slli t2, t0, 2
    mul t3, t2, a3
    add t3, t3, a0
    mul t4, t2, a4
    add t4, t4, a1
    lw t3, 0(t3)
    lw t4, 0(t4)
    mul t3, t3, t4
    add t1, t1, t3
    addi t0, t0, 1
    j loop
end:
    mv a0, t1
    ret

exception1:
    li a0, 17
    li a1, 75
    ecall
exception2:
    li a0, 17
    li a1, 76
    ecall