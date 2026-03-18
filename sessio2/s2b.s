.data
result: .word 0
num:    .byte '7'

    .text
    .globl main
main:

    la $t0, num
    lb $t0, 0($t0)      # t0 = num

if:
    li $t1, 'a'
    blt $t0, $t1, cond2 # if (t0 < 'a') goto cond2
    li $t1, 'z'
    bgt $t0, $t1, cond2 # if (t0 > 'z') goto cond2
    
cond2: 
    li $t1, 'A'
    blt $t0, $t1, else  # if (t0 < 'A') goto else
    li $t1, 'Z'
    bgt $t0, $t1, else  # if (t0 > 'Z') goto else
    
exec:
    la $t1, result
    sw $t0, 0($t1)      # result = t0
    j fi
    
else: 
    li $t1, '0'
    blt $t0, $t1, else2 # if (t0 < '0') goto else2
    li $t1, '9'
    bgt $t0, $t1, else2 # if (t0 > '9') goto else2
    
exec2:
    li $t1, '0'
    sub $t1, $t0, $t1   # t1 = t0 - '0'
    la $t2, result
    sw $t1, 0($t2)      # result = t1
    j fi

else2:
    li $t1, -1          # t1 = -1
    la $t2, result      
    sw $t1, 0($t2)      # result = -1

fi:
    la $t0, result
    lw $a0, 0($t0)      # a0 = result
    addiu $v0, $zero, 1 # v0 = 1 (print_int)
    syscall             # print_int(result)

    jr $ra              # return
