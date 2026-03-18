# PRACTICA 1 #######################

	.data
    vec: .word 9, 8, 7, 6, 5, 4, 3, 2, 1, 0	

	.text
	.globl main
main:
	addiu $s2, $zero, 5
	
	la $t0, vec # t0 = vec
	sll $t1, $s2, 2 # t1 = s2 * 4
	addu $t0, $t0, $t1 # t0 += t1
	lw $s1, 0($t0) # s1 = t0

	addiu $v0, $zero, 1 # v0 = 1
	addu $a0, $zero, $s1 # a0 = s1
	syscall
	jr $ra		# main retorna al codi de startup

