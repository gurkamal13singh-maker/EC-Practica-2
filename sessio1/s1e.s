# PRACTICA 1 #######################

	.data
    A: .word 3 5 7	
    punter: .word 0

	.text
	.globl main
main:
	la $t0, punter # t0 = punter
	la $t1, A # t1 = A
	addiu $t2,$t1, 8 # t2 = A + 2*4
	sw $t2, 0($t0) # punter = t2

	lw $s0, 0($t2) # s0 = *punter
	addiu $s0, $s0, 2 # s0 += 2

	lw $t2, -8($t2) # t2 = *(t2 - 2)
	addu $s0, $s0, $t2 # s0 += t2

	sw $s0, 4($t1) # *(punter + sizeof(int)) = s0

	addiu $v0, $zero, 1 # v0 = 1
	addu $a0, $zero, $s0 # a0 = s0
	syscall
	jr $ra		# main retorna al codi de startup

