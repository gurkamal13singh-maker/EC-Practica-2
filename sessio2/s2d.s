.data
alfabet: .asciiz "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
w1:      .asciiz "ARQUITECTURA"
         .space 3
w2:      .space 16
w3:      .space 16
count:   .word 0

.text
.globl main
main:
   addiu $sp, $sp, -4       # reserve stack
   sw    $ra, 0($sp)        # save ra
   la    $s0, count         # s0 = @count
   la    $a0, w1            # a0 = @w1
   la    $a1, w2            # a1 = @w2
   jal   codifica           # v0 = codifica(w1, w2)
   sw    $v0, 0($s0)        # count = v0
   la    $a0, w2            # a0 = @w2
   la    $a1, w3            # a1 = @w3
   jal   codifica           # v0 = codifica(w2, w3)
   lw    $s1, 0($s0)        # s1 = count
   addu  $s1, $s1, $v0      # s1 = count + v0
   sw    $s1, 0($s0)        # count = s1
   li    $v0, 4             # v0 = 4 (print_string)
   la    $a0, w2            # a0 = @w2
   syscall                  # print_string(w2)
   la    $a0, w3            # a0 = @w3
   syscall                  # print_string(w3)
   lw    $ra, 0($sp)        # restore ra
   addiu $sp, $sp, 4        # release stack
   jr    $ra                # return

g:
   lb    $t0, 0($a1)        # t0 = *char
   li    $t1, 'A'           # t1 = 'A'
   addiu $t1, $t1, 25       # t1 = 'Z'
   sub   $t1, $t1, $t0      # t1 = 'Z' - *char
   add   $t0, $a0, $t1      # t0 = @alfabet + offset
   lb    $v0, 0($t0)        # v0 = alfabet[offset]

   jr $ra                   # return


codifica:
   addiu $sp, $sp, -16      # reserve stack
   sw    $ra, 0($sp)        # save ra
   sw    $s0, 4($sp)        # save s0
   sw    $s1, 8($sp)        # save s1
   sw    $s2, 12($sp)       # save s2
   move  $s2, $zero         # s2 = i = 0
   move  $s0, $a0           # s0 = @src
   move  $s1, $a1           # s1 = @dest
while:
   lb    $t0, 0($s0)        # t0 = src[i]
   beq   $t0, $zero, fi_while # if (t0 == '\0') goto fi_while
   la    $a0, alfabet       # a0 = @alfabet
   move  $a1, $s0           # a1 = @src[i]
   jal   g                  # v0 = g(alfabet, &src[i])
   sb    $v0, 0($s1)        # dest[i] = v0
   addiu $s0, $s0, 1        # src++
   addiu $s1, $s1, 1        # dest++
   addiu $s2, $s2, 1        # i++
   b     while              # goto while
 fi_while:
   sb    $zero, 0($s1)      # dest[i] = '\0'
   move  $v0, $s2           # return i
   lw    $ra, 0($sp)        # restore ra
   lw    $s0, 4($sp)        # restore s0
   lw    $s1, 8($sp)        # restore s1
   lw    $s2, 12($sp)       # restore s2
   addiu $sp, $sp, 16       # release stack
   jr    $ra                # return
