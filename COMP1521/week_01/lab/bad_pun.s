PRINT_STR=4

    .text 

main:
    la  $a0, message
    li  $v0, PRINT_STR
    syscall
    li  $v0, 0 #return 0
    jr	$ra

    .data
message:
    .asciiz "Well, this was a MIPStake!\n"
