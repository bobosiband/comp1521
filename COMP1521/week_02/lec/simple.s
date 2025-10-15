PRINT_INT = 1
PRINT_STR = 4
    .text
main:

# sum will be stored in $t0 i in $t1
    move    $t0, $zero
loop_init:
    li      $t1, 1
loop_conditon:
    bgt     $t1, 100, loop_end
loop_body:
    mul     $t2, $t1, $t1
    add	    $t0, $t0, $t2
    move    $t4, $t0
    move    $a0, $t4
    li	    $v0, PRINT_INT
    syscall
    #print new line character 
    la      $a0, newline
    li      $v0, PRINT_STR
    syscall
loop_step:
    addi	$t1, $t1, 1
    b	    loop_conditon

loop_end:
    li      $v0, 0 #return 0
    jr	    $ra

    .data
newline:
    .asciiz "\n"
