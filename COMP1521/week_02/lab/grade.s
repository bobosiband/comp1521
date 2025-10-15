# read a mark and print the corresponding UNSW grade
#
# Before starting work on this task, make sure you set your tab-width to 8!
# It is also suggested to indent with tabs only.
#
# 23/09/2025
# Bongani Sibanda (z5684226) 
#![tabsize(8)]

main:
	la	$a0, prompt	# printf("Enter a mark: ");
	li	$v0, 4
	syscall

	li	$v0, 5		# scanf("%d", mark);
	syscall

	move $t0, $v0  # store mark
	
	blt	$t0, 50, FL
	blt $t0, 65, PS
	blt $t0, 75, CR
	blt $t0, 85, DN
	b	HD

	

FL:
	la	$a0, fl		# printf("FL\n");
	li	$v0, 4
	syscall
	b	END
PS:
	la	$a0, ps		# printf("PS\n");
	li	$v0, 4
	syscall
	b	END
CR:
 	la	$a0, cr		# printf("CR\n");
	li	$v0, 4
	syscall
	b	END
DN: 
	la	$a0, dn		# printf("DN\n");
	li	$v0, 4
	syscall
	b	END
HD:
	la	$a0, hd		# printf("HD\n");
	li	$v0, 4
	syscall
	b	END
END:
	li	$v0, 0
	jr	$ra		# return 0

	.data
prompt:
	.asciiz "Enter a mark: "
fl:
	.asciiz "FL\n"
ps:
	.asciiz "PS\n"
cr:
	.asciiz "CR\n"
dn:
	.asciiz "DN\n"
hd:
	.asciiz "HD\n"
