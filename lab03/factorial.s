.globl factorial

.data
n: .word 8

.text
main:
    la t0, n
    lw a0, 0(t0)
    jal ra, factorial

    addi a1, a0, 0
    addi a0, x0, 1
    ecall # Print Result

    addi a1, x0, '\n'
    addi a0, x0, 11
    ecall # Print newline

    addi a0, x0, 10
    ecall # Exit

factorial:
# USE RECURSION
    add s1, a0, x0
    addi t1, x0, 1
    beq a0, t1, exit
    addi a0, a0, -1
    addi sp, sp, -8
    sw s1, 0(sp)
    sw ra, 4(sp)
    jal ra, factorial
    lw s1, 0(sp)
    lw ra, 4(sp)
    addi sp, sp, 8
    mul a0, a0, s1
exit:
    jr ra
# USE LOOP
    #add t1, a0, x0
    #addi a0, x0, 1
#loop:
    #beq t1, x0, exit
    #mul a0, a0, t1
    #addi t1, t1, -1
    #jal x0, loop