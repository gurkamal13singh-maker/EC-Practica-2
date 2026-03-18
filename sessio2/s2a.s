	.data

	.text
	.globl main

main:
	li $s1, 23 # Y
	li $s0, 8  # X

	addiu $t0, $zero, 1     # $t0 = 1
	sllv  $t0, $t0, $s0     # $t0 = (1 << X)
	addiu $t0, $t0, -1      # $t0 = (1 << X) - 1
	xor   $s1, $s1, $t0     # $s1 = Y ^ ((1 << X) - 1)

	addu  $a0, $zero, $s1   # $a0 = $s1
	addiu $v0, $zero, 1     # $v0 = 1 (print_int)
	syscall                 # print_int($s1)

	jr $ra
