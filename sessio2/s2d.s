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
   addiu $sp, $sp, -4       
   sw    $ra, 0($sp)        # save ra
   la    $s0, count         # s0 = @count
   la    $a0, w1            # a0 = w1
   la    $a1, w2            # a1 = w2
   jal   codifica           # v0 = codifica(w1, w2)
   sw    $v0, 0($s0)        # count = v0
   la    $a0, w2            # a0 = w2
   la    $a1, w3            # a1 = w3
   jal   codifica           # v0 = codifica(w2, w3)
   lw    $s1, 0($s0)        # s1 = count
   addu  $s1, $s1, $v0      # s1 = count + v0
   sw    $s1, 0($s0)        # count = s1
   li    $v0, 4             
   la    $a0, w2            
   syscall                  # print_string(w2)
   la    $a0, w3            
   syscall                  # print_string(w3)
   lw    $ra, 0($sp)        
   addiu $sp, $sp, 4        
   jr    $ra                # return

g:
   lb    $t0, 0($a1)        # t0 = *pfrase
   li    $t1, 'A'           
   addiu $t1, $t1, 25       # t1 = 'Z'
   sub   $t1, $t1, $t0      # offset = 25 - (*pfrase - 'A')
   add   $t0, $a0, $t1      # t0 = &alfa[offset]
   lb    $v0, 0($t0)        # return alfa[offset]

   jr $ra                   # return

codifica:
   addiu $sp, $sp, -16      
   sw    $ra, 0($sp)        # save ra
   sw    $s0, 4($sp)      
   sw    $s1, 8($sp)       
   sw    $s2, 12($sp)       
   move  $s2, $zero         # i = 0
   move  $s0, $a0           # pfrasein = a0
   move  $s1, $a1           # pfraseout = a1
while:
   lb    $t0, 0($s0)        # t0 = *pfrasein
   beq   $t0, $zero, fi_while # while (*pfrasein != 0)
   la    $a0, alfabet       
   move  $a1, $s0           
   jal   g                  # v0 = g(alfabet, pfrasein)
   sb    $v0, 0($s1)        # *pfraseout = v0
   addiu $s0, $s0, 1        # pfrasein++
   addiu $s1, $s1, 1        # pfraseout++
   addiu $s2, $s2, 1        # i++
   b     while              # goto while
 fi_while:
   sb    $zero, 0($s1)      # *pfraseout = 0
   move  $v0, $s2           # return i
   lw    $ra, 0($sp)        
   lw    $s0, 4($sp)        
   lw    $s1, 8($sp)        
   lw    $s2, 12($sp)       
   addiu $sp, $sp, 16       
   jr    $ra                # return
