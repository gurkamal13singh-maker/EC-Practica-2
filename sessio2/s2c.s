.data
w:        .asciiz "8754830094826456674949263746929"
resultat: .byte 0

    .text
    .globl main
main:
    addiu    $sp, $sp, -4   
    sw    $ra, 0($sp)       # save ra
    la    $a0, w            # a0 = w
    li    $a1, 31           # a1 = 31
    jal    moda             # v0 = moda(w, 31)
    la    $s0, resultat     
    sb    $v0, 0($s0)       # resultat = v0
    move    $a0, $v0        
    li    $v0, 11           # v0 = 11 (print_character)
    syscall                 # print_character(resultat)
    lw    $ra, 0($sp)       
    addiu    $sp, $sp, 4    
    jr     $ra              # return


nofares:
    li    $t0, 0x12345678
    move    $t1, $t0
    move    $t2, $t0
    move    $t3, $t0
    move    $t4, $t0
    move     $t5, $t0
    move    $t6, $t0
    move     $t7, $t0
    move     $t8, $t0
    move     $t9, $t0
    move    $a0, $t0
    move    $a1, $t0
    move    $a2, $t0
    move    $a3, $t0
    jr    $ra               # return


moda:
    addiu $sp, $sp, -60     
    sw $s0, 40($sp)         
    sw $s1, 44($sp)         
    sw $s2, 48($sp)         
    sw $s3, 52($sp)         
    sw $ra, 56($sp)         # save ra

    move $s0, $a0           # s0 = vec
    move $s1, $a1           # s1 = num
    li $s2, 0               # k = 0
    li $s3, '0'             # max = '0'

    li $t0, 10
	
for1:
    bge $s2, $t0, etq1      # if (k >= 10) goto etq1
    sll $t1, $s2, 2         
    addu $t1, $t1, $sp      # t1 = &histo[k]
    sw $zero, 0($t1)        # histo[k] = 0
    addiu $s2, $s2, 1       # k++
    b for1                  # goto for1

etq1:
    li $s2, 0               # k = 0

for2:
    bge $s2, $s1, etq2      # if (k >= num) goto etq2
    move $a0, $sp           # a0 = histo
    addu $a1, $s0, $s2      # a1 = &vec[k]
    lb $a1, 0($a1)          # a1 = vec[k]
    li $t0, '0'             
    subu $a1, $a1, $t0      # i = vec[k] - '0'
    subu $a2, $s3, $t0      # imax = max - '0'
    jal update              # v0 = update(histo, i, imax)
    li $t0, '0'             

    addu $s3, $t0, $v0      # max = '0' + v0
    addiu $s2, $s2, 1       # k++
    b for2                  # goto for2

etq2:
    move $v0, $s3           # return max
    lw $s0, 40($sp)         
    lw $s1, 44($sp)         
    lw $s2, 48($sp)         
    lw $s3, 52($sp)         
    lw $ra, 56($sp)         
    addiu $sp, $sp, 60      
    jr $ra                  # return



update:
    addiu $sp, $sp, -16     
    sw $a0, 0($sp)          # h
    sw $a1, 4($sp)          # i
    sw $a2, 8($sp)          # imax
    sw $ra, 12($sp)         # save ra
    jal nofares             # nofares()
    lw $a0, 0($sp)          # a0 = h
    lw $a1, 4($sp)          # a1 = i
    lw $a2, 8($sp)          # a2 = imax
    lw $ra, 12($sp)         
    sll $t0, $a1, 2         
    addu $t0, $a0, $t0      # t0 = &h[i]
    lw $t1, 0($t0)          # t1 = h[i]
    addiu $t1, $t1, 1       # h[i]++
    sw $t1, 0($t0)          # h[i] = t1
    sll $t2, $a2, 2         
    addu $t2, $a0, $t2      # t2 = &h[imax]
    lw $t2, 0($t2)          # t2 = h[imax]

    ble $t1, $t2, else      # if (h[i] <= h[imax]) goto else
    move $v0, $a1           # return i
    b fi                    # goto fi

else:
    move $v0, $a2           # return imax

fi:
    addiu $sp, $sp, 16      
    jr $ra                  # return
