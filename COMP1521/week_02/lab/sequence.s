# Read three numbers `start`, `stop`, `step`
# Print the integers bwtween `start` and `stop` moving in increments of size `step`
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# BONGANI SIBANDA, 14/05/2025
#![tabsize(8)]

main:				# int main(void)
	la	$a0, prompt1	# printf("Enter the starting number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall
	move $t0, $v0 # initialse start 

	######### stop
	la	$a0, prompt2	# printf("Enter the stopping number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall
	move $t1, $v0 # initialse start  

	######### step
	la	$a0, prompt3	# printf("Enter the starting number: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", number);
	syscall
	move $t2, $v0 # initialse step 

	blt	$t1, $t0, Stop_L_Start
	bgt $t1, $t0, Stop_G_Start
	b	end

Stop_L_Start:
	blt	$t2, 0, For_UPP
	b	end 

Stop_G_Start:
	bgt	$t2, 0, For_Down
	b	end

For_UPP:
loop_init:
	move $t3, $t0
loop_condtion:
	ble	$t3, $t1, loop_end
loop_body:
	move $a0, $t3		# print ;
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
loop_step:
	add $t3, $t2
	b	loop_condtion
loop_end:
	b	end

For_Down:
loop1_init:
	move $t3, $t0
loop1_condtion:
	bge	$t3, $t1, loop1_end
loop1_body:
	move $a0, $t3		# print ;
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall
loop1_step:
	add $t3, $t2
	b	loop1_condtion
loop1_end:
	b	end
	
	
end:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt1:
	.asciiz "Enter the starting number: "
prompt2:
	.asciiz "Enter the stopping number: "
prompt3:
	.asciiz "Enter the step size: "
