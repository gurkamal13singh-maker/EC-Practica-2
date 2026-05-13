.data
vector: .space 400

    .text
    .globl main
main:
        move    $t1, $zero          # sum = 0
        la      $t2, vector         # $t2 = &vector[0]
        
        addiu   $t2, $t2, 396       # $t2 = &vector[99] (base + 99*4)
        
        li      $t0, 99             # i = 99
        li      $t3, 0              
for:
        bltz    $t0, fi             # if (i < 0) goto fi
        
        lw      $t4, 0($t2)         # $t4 = vector[i]
        addu    $t1, $t1, $t4       # sum += vector[i]
        
        addiu   $t2, $t2, -4        # $t2 = $t2 - 4
        addiu   $t0, $t0, -1        # i = i - 1
        
        b       for
fi:
        jr      $ra                 # return

