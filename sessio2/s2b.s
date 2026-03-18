.data
result: .word 0
num:    .byte '7'

    .text
    .globl main
main:

    la $t0, num
    lb $t0, 0($t0)      # num = '7'

if:
    li $t1, 'a'
    blt $t0, $t1, cond2 # if (num < 'a') goto cond2
    li $t1, 'z'
    bgt $t0, $t1, cond2 # if (num > 'z') goto cond2
    j exec              # goto exec

cond2:
    li $t1, 'A'
    blt $t0, $t1, else  # if (num < 'A') goto else
    li $t1, 'Z'
    bgt $t0, $t1, else  # if (num > 'Z') goto else

exec:
    la $t1, result
    sw $t0, 0($t1)      # result = num
    j fi                # goto fi

else:
    li $t1, '0'
    blt $t0, $t1, else2 # if (num < '0') goto else2
    li $t1, '9'
    bgt $t0, $t1, else2 # if (num > '9') goto else2

exec2:
    li $t1, '0'
    sub $t1, $t0, $t1   # t1 = num - '0'
    la $t2, result
    sw $t1, 0($t2)      # result = t1
    j fi                # goto fi

else2:
    li $t1, -1          # t1 = -1
    la $t2, result
    sw $t1, 0($t2)      # result = -1

fi:
    la $t0, result
    lw $a0, 0($t0)      # a0 = result
    addiu $v0, $zero, 1 
    syscall             # print_int(result)

    jr $ra              # return
