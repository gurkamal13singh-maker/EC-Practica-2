# PRACTICA 1 #######################

	.data
    cadena: .byte -1, -1, -1, -1, -1, -1
    vec: .word 5, 6, 8, 9, 1	

	.text
	.globl main
main:
	xor $s0, $s0, $s0 # i = 0
while:	
	addiu $t0, $zero, 5 # t0 = 5
	bge $s0, $t0, fi # i >= 5
	
	la $t1, cadena # t1 = @cadena
	la $t2, vec # t2 = @vec
	addiu $t3, $zero, 4 # t3 = 4
	subu $t3, $t3, $s0 # t3 = 4 - i
	sll $t3, $t3, 2 # t3 *= 4
	addu $t3, $t2, $t3 # t3 = vec + t3
	lw $t3, 0($t3) # t3 = vec[4-i]
	addiu $t3, $t3, '0' # t3 += '0'
	addu $t1, $t1, $s0 # t1 = cadena + i
	sb $t3, 0($t1) # cadena[i] = t3
	addiu $s0, $s0, 1 #i++
	b while
fi:
	la $t0, cadena 
	sb $zero, 5($t0)
	addiu $v0, $zero, 4
	addu $a0, $zero, $t0
	syscall
	jr $ra		# main retorna al codi de startup

