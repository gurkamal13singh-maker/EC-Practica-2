    # Sessio 3

    .data
mat:    .word 0,0,2,0,0,0
        .word 0,0,4,0,0,0
        .word 0,0,6,0,0,0
        .word 0,0,8,0,0,0
resultat: .word 0

    .text
    .globl main
main:
    addiu $sp, $sp, -4
    sw    $ra, 0($sp)

    # resultat = suma_col(mat);
    la    $a0, mat
    jal   suma_col
    
    la    $t0, resultat
    sw    $v0, 0($t0)

    lw    $ra, 0($sp)
    addiu $sp, $sp, 4
    jr    $ra


suma_col:
    # int suma = 0; int i = 0;
    li    $v0, 0            
    li    $t0, 0            
    
    # p = &m[0][2];
    addiu $t1, $a0, 8       

loop:
    # for(i = 0; i < 4; i++) {
    li    $t2, 4
    beq   $t0, $t2, fi_loop 
    
    # suma += *p;
    lw    $t3, 0($t1)       
    addu  $v0, $v0, $t3     
    
    # p += 6; (6 * sizeof(int) = 24 bytes)
    addiu $t1, $t1, 24      
    
    # i++; }
    addiu $t0, $t0, 1       
    j     loop              

fi_loop:
    # return suma;
    jr    $ra
