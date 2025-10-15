# read a number n and print the integers 1..n one per line
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# YOUR-NAME-HERE, DD/MM/YYYY

#![tabsize(8)]

main:                 		# int main(void)
	la	$a0, prompt	# printf("Enter a number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall
	move $t0, $v0
loop_init:
	li	$t1, 1
loop_condition:
	bgt	$t1, $t0, end
loop_body:
	move $a0, $t1		# printf("%d", count);
	li	$v0, 1
	syscall
	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
loop_step:
	addi $t1, $t1, 1
	b	loop_condition
	
end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt:
	.asciiz "Enter a number: "
