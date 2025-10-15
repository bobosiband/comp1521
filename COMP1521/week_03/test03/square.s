main:
	li	$v0, 5		# scanf("%d", &x);
	syscall			#
	move	$t0, $v0
i_l_init:
	li	$t1, 0			# int i = 0;
i_l_cond:
	bge	$t1, $t0, i_l_end	# while (i < x) 
i_l_body:

###################
j_l_init:
	li	$t2, 0		# int j = 0;
j_l_cond:
	bge	$t2, $t0, j_l_end	# while (j < x) 
j_l_body:
	li	$a0, '*'		# printf("*");
	li	$v0, 11
	syscall
j_l_step:
	addi $t2, $t2, 1	# j = j + 1;
	b	j_l_cond
j_l_end:

	li	$a0, '\n'	# printf("%c", '\n');
	li	$v0, 11
	syscall	

###################
i_l_step:
	addi $t1, $t1, 1	# i = i + 1;
	b	i_l_cond
i_l_end:

end:
	li	$v0, 0		# return 0
	jr	$ra
