.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:
    li t0, 1
    blt a1, t0, exception
    # t0 <- counter | t2 <- max value | t3 <- index of t2
    lw t2, 0(a0)
    li t3, 0
loop:
    beq t0, a1, end
    slli t1, t0, 2
    add t1, t1, a0
    lw t1, 0(t1)
    ble t1, t2, skip
    mv t2, t1
    mv t3, t0
skip:
    addi t0, t0, 1
    j loop
end:
    mv a0, t3
    ret

exception:
    li a0, 17
    li a1, 77
    ecall