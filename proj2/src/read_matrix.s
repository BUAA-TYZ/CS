.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
# - If malloc returns an error,
#   this function terminates the program with error code 88.
# - If you receive an fopen error or eof, 
#   this function terminates the program with error code 90.
# - If you receive an fread error or eof,
#   this function terminates the program with error code 91.
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 92.
# ==============================================================================
read_matrix:

    # Prologue
    addi sp, sp, -20
    # s3: file handle
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)
    mv s0, a0
    mv s1, a1
    mv s2, a2
    
    # open the file
	addi sp, sp, -4
    sw ra, 0(sp)
    mv a1, s0
    mv a2, x0
    jal fopen
    ble a0, x0, exception2
    mv s3, a0
    lw ra, 0(sp)
    addi sp, sp, 4
    
    # read row 
    addi sp, sp, -4
    sw ra, 0(sp)
    mv a1, s3
    mv a2, s1
    li a3, 4
    addi sp, sp, -4
    sw a3, 0(sp)
    jal fread
    lw a3, 0(sp)
    addi sp, sp, 4
    bne a0, a3, exception3
    lw ra, 0(sp)
    addi sp, sp, 4
    
    # read column
    addi sp, sp, -4
    sw ra, 0(sp)   
    mv a1, s3
    mv a2, s1
    li a3, 4
    addi sp, sp, -4
    sw a3, 0(sp)
    jal fread
    lw a3, 0(sp)
    addi sp, sp, 4
    bne a0, a3, exception3
    lw ra, 0(sp)
    addi sp, sp, 4
    

    # Epilogue
    lw s0, 0(sp)
    addi sp, sp, 4

    ret

exception1:
    li a1, 88
    jal exit2

exception2:
    li a1, 90
    jal exit2
    
exception3:
    li a1, 91
    jal exit2

exception4:
    li a1, 92
    jal exit2