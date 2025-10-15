main:
	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t0, $v0

	li	$v0, 5		# scanf("%d", &y);
	syscall			#
	move	$t1, $v0
l_init:
	add	$t2, $t0, 1      # int i = x + 1;
l_cond:
	bge	$t2, $t1, l_end  # if (x >= y) 
l_body:
	beq	$t2, 13, l_step

	move $a0, $t2		# printf("%d\n", i);
	li	$v0, 1
	syscall

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall	
l_step:
	addi $t2, $t2, 1
	b	l_cond
l_end:

end:
	li	$v0, 0         # return 0
	jr	$ra
