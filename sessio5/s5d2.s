.data
V1:     .space  64
M:      .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0
        .word   0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
V2:     .word   -5,-4,-3,-2,-1,0,1,2,3,4,5,6,7,8,9,10

        .text
        .globl main
main:   move    $t0, $zero      # k
        li      $t1, 4

for_k:  bge     $t0, $t1, end_for_k
        move    $t2, $zero      # i
        li      $t3, 16

for_i:  bge     $t2, $t3, end_for_i
        move    $t7, $zero      # temp
        move    $t4, $zero      # j

for_j:  bge     $t4, $t1, end_for_j
        sll     $t6, $t2, 2     # 4*i
        sll     $t5, $t0, 2
        addu    $t5, $t5, $t4   # 4*k+j
        sll     $t5, $t5, 2
        sll     $t6, $t6, 4     # 4*i*16
        la      $s0, M
        addu    $s0, $s0, $t5
        addu    $s0, $s0, $t6   # @M[i][4k+j]
        lw      $s1, 0($s0)
        la      $s0, V2
        addu    $s0, $s0, $t5   # @V2[4k+j]
        lw      $s2, 0($s0)
        mult    $s1, $s2
        mflo    $s1
        add     $t7, $t7, $s1   # tmp+= M[]*V[]
        addiu   $t4, $t4, 1
        b       for_j

end_for_j:
        la      $t6, V1
        sll     $t5, $t2, 2
        addu    $t6, $t6, $t5   # @V1[i]
        lw      $s0, 0($t6)
        addu    $s0, $s0, $t7
        sw      $s0, 0($t6)
        addiu   $t2, $t2, 1
        b       for_i

end_for_i:
        addiu   $t0, $t0, 1
        b       for_k

end_for_k:
        jr      $ra
