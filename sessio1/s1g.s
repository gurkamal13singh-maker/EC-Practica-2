# PRACTICA 1 #######################

	.data
    fib: .space 40	

	.text
	.globl main
main:
	addiu $s0, $zero, 2 # i = 2
	la $t1, fib # t1 = @fib
	sw $zero, 0($t1) # fib[0] = 0
	addiu $t2, $zero, 1 # t2 = 1
	sw $t2, 4($t1) # *(fib + 1*4) = 1
	
while:	
	slti $t0, $s0, 10 # t0 = s0 < 10
	beq $t0, $zero, fi # t0 == 0 ???? me voy a fi
	sll $t2, $s0, 2 # t2 = i*4
	addu $t0, $t1, $t2 # t0 = fib + i
	lw $t2, -4($t0) # t2 = fib[i-1]
	lw $t3, -8($t0) # t3 = fib[i-2]
	addu $t2, $t2, $t3 # t2 = t2 + t3
	sw $t2, 0($t0) # fib[i] = t2
	addiu $s0, $s0, 1 # i++
	b while
fi:
	jr $ra		# main retorna al codi de startup

