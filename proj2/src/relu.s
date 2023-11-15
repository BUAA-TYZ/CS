.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    li t0, 1
    blt a1, t0, exception
    li t0, 0
loop:
    beq t0, a1, end 
    slli t1, t0, 2
    add t1, t1, a0
    lw t2, 0(t1)
    bgt t2, x0, skip
    sw x0, 0(t1)
skip:
    addi t0, t0, 1
    j loop
end:
	ret
 
exception:
    li a0, 17
    li a1, 78
    ecall