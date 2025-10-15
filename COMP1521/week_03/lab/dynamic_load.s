    .text
main:
    li      $v0, 4
    la      $a0, msg_first          # printf("Enter mips instructions as integers, -1 to finish:");
    syscall  

scan_loop__init:
    la      $t2, instruction        # pointer to buffer
    li      $t4, 0                  # holds last read value

scan_loop__cond:
    li      $v0, 5                  # syscall 5: read_int
    syscall
    move    $t4, $v0                # t4 = input
    li      $t5, -1
    beq     $t5, $t4, scan_loop__end # while (instruction != -1) {

scan_loop__body:
    sw      $t4, ($t2)              #   store instruction[i]

scan_loop__step:
    addi    $t2, $t2, 4             #   i++
    j       scan_loop__cond          #   repeat
scan_loop__end:                      # }

################################################################################
    li      $v0, 4
    la      $a0, msg_sec
    syscall

    la      $t3, instruction
    jalr    $t3                     # now it’s executable

    li      $v0, 4
    la      $a0, msg_third
    syscall

    li      $v0, 10                 # syscall: exit
    syscall

    .data
msg_first:
    .asciiz "Enter mips instructions as integers, -1 to finish:\n"
msg_sec:
    .asciiz "Starting executing instructions\n"
msg_third:
    .asciiz "Finished executing instructions\n"

	.text
    .align 2    
instruction:
    .space 4096
