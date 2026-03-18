		.data
result: .word 0
num:	.byte '7'

	.text
	.globl main
main:

# COPIA EL TEU CODI AQUI

	la $t0, num
	lb $t0, 0($t0)   # $t0 <- num

if:
	li $t1, 'a'
	blt $t0, $t1, cond2
	li $t1, 'z'
	ble $t0, $t0, exec
	
cond2: 
	li $t1, 'A'
	blt $t0, $t1, else
	li $t1, 'Z'
	bgt $t0, $t0, else
	
exec:
	la $t1, result
	sw $t0, 0($t1)   # result = num
	j fi
	
else: 
	li $t1, '0'
	blt $t0, $t1, else2
	li $t1, '9'
	bgt $t0, $t1, else2
	
exec2:
	li $t1, '0'
	sub $t1, $t0, $t1   # $t1 = num - '0'
	la $t2, result
	sw $t1, 0($t2)      # result = num
	j fi

else2:
	li $t1, -1     # t1 = -1
	la $t2, result    #t2 = @result
	sw $t1, 0($t2)      #result = -1

fi:
	jr $ra


