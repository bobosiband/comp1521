# Read a number n and print the first n tetrahedral numbers
# https://en.wikipedia.org/wiki/Tetrahedral_number
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# BONGANI SIBANDA, 23/09/2025
#![tabsize(8)]

main:				# int main(void) {

	la	$a0, prompt	# printf("Enter how many: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number); #t0 == howmany 
	syscall
	move $t0, $v0

loop_main_init:
	li  $t1, 1 # set n to 1
loop_main_conditon:
	bgt	$t1, $t0, loop_main_end
loop_main_body:
	li	$t2, 0 # total = 0
loop_1_init:
	li	$t3, 1 # j = 1
loop_1_condition:
	bgt	$t3, $t1, loop_1_end
loop_1_body:
loop_2_init:
	li	$t4, 1 # i = 1
loop_2_condition:
	bgt	$t4, $t3, loop_2_end
loop_2_body:
	add $t2, $t2, $t4
loop_2_step:
	addi $t4, $t4, 1
	b	loop_2_condition
loop_2_end:

loop_1_step:
	addi $t3, $t3, 1
	b 	loop_1_condition
loop_1_end:
loop_main_step:
	move $a0, $t2		# printf("%d", total);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
	addi	$t1, $t1, 1
	b	loop_main_conditon
loop_main_end:
	
end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt:
	.asciiz "Enter how many: "
