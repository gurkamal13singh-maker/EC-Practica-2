	# Sessio 3

	.data 
# Declara aqui les variables mat1, mat4 i col
mat1:	.space 120
mat4: 	.word 2,3,1,2,4,3
col:	.word 2

	.text 
	.globl main
main:
# Escriu aqui el programa principal
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $a0, mat4		#a0 = mat4
	lw $a1, 4($a0)		#a1 = mat[0][4]
	la $t0, col		#a2 = @col
	lw $a2, 0($t0)		#a2 = col
	jal subr
	
	la $t0, mat1		
	sw $v0, 108($t0)	#mat1[4][3] = subr
	
	la $a0, mat1		#a0 = mat1
	li $a1, 1		#a1 = 1
	li $a2, 1		#a2 = 2
	jal subr
	
	la $t0, mat1		
	sw $v0, 0($t0)		#mat1[0][0] = subr
	
	lw $ra, 0($sp)		#recuperem $ra
	addiu $sp, $sp, 4	#desmontem pila
	
	jr $ra


subr:
# Escriu aqui el codi de la subrutina
	la $t0, mat1		#t0 = @mat1
	li $t1, 24
	mult $a2, $t1
	mflo $t2		#t2 = j*6*4
	addiu $t2, $t2, 20	#t2 = j*6*4 + 5*4
	addu $t2, $t0, $t2	#t2 = @mat1[j][5]
	
	li $t0, 3
	mult $a1, $t0
	mflo $t1		#t1 = i*3
	addu $t1, $t1, $a2	#t1 = i*3 + j
	sll $t1, $t1, 2		#t1 = (i*3 + j) * 2
	addu $t1, $t1, $a0	#t1 = @x[i][j]
	lw $t1, 0($t1)		#t1 = x[i][j]
	
	sw $t1, 0($t2)
	
	move $v0, $a1
	
	jr $ra

