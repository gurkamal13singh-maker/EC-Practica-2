.data    
vec:    .space   256             # Reserva espacio para 64 enteros

    .text
    .globl main
main:
        li      $t0, 0          # i = 0
        la      $t4, vec        # $t4 = &vec[0]
fori:
        li      $t7, 63         # i < 63
        bge     $t0, $t7, end_fori

        move    $t3, $t0        # max = i
        addiu   $t1, $t0, 1     # j = i + 1
forj:
        li      $t7, 64         # j < 64
        bge     $t1, $t7, end_forj    
        
        # Acceso a vec[j]
        sll     $t5, $t1, 2
        addu    $t5, $t5, $t4    
        lw      $t5, 0($t5)     # $t5 = vec[j]
        
        # Acceso a vec[max]
        sll     $t6, $t3, 2
        addu    $t6, $t6, $t4
        lw      $t6, 0($t6)     # $t6 = vec[max]
        
        # if (vec[j] <= vec[max])
        ble     $t5, $t6, end_if
        move    $t3, $t1        # max = j
end_if:
        addiu   $t1, $t1, 1     # j++
        b       forj
end_forj:
        sll     $t5, $t0, 2
        addu    $t5, $t5, $t4   # $t5 = &vec[i]
        lw      $t2, 0($t5)     # aux = vec[i]
        
        sll     $t6, $t3, 2
        addu    $t6, $t6, $t4   # $t6 = &vec[max]
        lw      $t7, 0($t6)     # $t7 = vec[max]
        
        sw      $t7, 0($t5)     # vec[i] = vec[max]
        sw      $t2, 0($t6)     # vec[max] = aux
        
        addiu   $t0, $t0, 1     # i++
        b       fori
end_fori:
        jr    $ra               # return
