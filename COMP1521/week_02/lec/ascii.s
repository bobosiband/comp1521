PRINT_CHAR=11

	.data
letter:
	.byte 'B'  #char char = 'B'

	.text
main:
	lb	$t0, letter
	sub	$t0, $t0, 1
	sb	$t0, letter  #letter--

	li	$v0, PRINT_CHAR
	move	$a0, $t0
	syscall

	li	$v0, 0
	jr	$ra 	#return 0
