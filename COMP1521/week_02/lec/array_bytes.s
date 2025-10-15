BYTE_SIZE = 1 
A_LEN = 5
A_SIZE =  A_LEN * BYTE_SIZE

PRINT_CHAR = 11

    .data
a:
    .byte 'a', 'b', 'c','d', 'e'

    .text 

main:


loop_init:
    li      $t0, 0      # i = 0;
loop_cond:
    bge     $t0, A_SIZE, loop_end   # if (i >= sizeof(a)) goto loop_end;
loop_body:
    li      $v0, PRINT_CHAR     # printf(" %c ",a[i]);
    lb      $a0, a($t0)  # load form a[i]
    syscall

    
loop_step:

    # i++;
    # goto loop_cond;
loop_end: