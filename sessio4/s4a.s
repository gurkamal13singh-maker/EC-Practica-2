	.data
signe:		.word 0
exponent:	.word 0
mantissa:	.word 0
cfixa:		.word 0x87D18A00
cflotant:	.float 0.0

	.text
	.globl main
main:
	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$t0, cfixa
	lw	$a0, 0($t0)
	la	$a1, signe
	la	$a2, exponent
	la	$a3, mantissa
	jal	descompon

	la	$a0, signe
	lw	$a0,0($a0)
	la	$a1, exponent
	lw	$a1,0($a1)
	la	$a2, mantissa
	lw	$a2,0($a2)
	jal	compon

	la	$t0, cflotant
	swc1	$f0, 0($t0)

	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra


# void descompon(int cf, int *s, int *e, int *m)
descompon:

# float compon(int signo, int exponent, int mantissa)
compon:
    sll  $a0, $a0, 31           # signo = signo << 31;
    sll  $a1, $a1, 23           # exponent = exponent << 23;
    or   $v0, $a0, $a1          # float result = signo | exponent;
    or   $v0, $v0, $a2          # result = result | mantissa;
    jr   $ra                    # return result;
