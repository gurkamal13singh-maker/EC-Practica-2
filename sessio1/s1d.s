# PRACTICA 1 #######################

	.data
    dada: .half 3
    pdada: .word dada


	.text
	.globl main
main:
	jr $ra		# main retorna al codi de startup

