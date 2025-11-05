# Reads a line and prints whether it is a palindrome or not

LINE_LEN = 256

########################################################################
# .TEXT <main>
main:
	# Locals:
	#   - ...

	li	$v0, 4				# syscall 4: print_string
	la	$a0, line_prompt_str		#
	syscall					# printf("Enter a line of input: ");

	li	$v0, 8				# syscall 8: read_string
	la	$a0, line			#
	la	$a1, LINE_LEN			#
	syscall					# fgets(buffer, LINE_LEN, stdin)
init:
	li	$t0, 0
cond:
	la	$t1, line
	add 	$t1, $t1, $t0
	lb	$t1, 0($t1)
	beq	$t1, '\n', l_end
body:
step:
	addi	$t0, $t0, 1
	b cond
l_end:
	addi	$t0, $t0, 1

pali_init:
	li	$t2, 0
	sub	$t3, $t0, 2
pali_cond:
	bge	$t2, $t3, pali_end
pali_body:
	la	$t1, line
	la	$t4, line
	add	$t1, $t1, $t2
	add	$t4, $t4, $t3
	lb	$t1, 0($t1)
	lb	$t4, 0($t4)
	beq	$t1, $t4, pali_step

	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_not_palindrome_str	#
	syscall					# printf("not palindrome\n");
	b	return

pali_step:
	addi	$t2, $t2, 1
	sub	$t3, $t3, 1
	b	pali_cond
pali_end:
	
	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_palindrome_str	#
	syscall					# printf("palindrome\n");

return:
	li	$v0, 0
	jr	$ra				# return 0;


########################################################################
# .DATA
	.data
# String literals
line_prompt_str:
	.asciiz	"Enter a line of input: "
result_not_palindrome_str:
	.asciiz	"not palindrome\n"
result_palindrome_str:
	.asciiz	"palindrome\n"

# Line of input stored here
line:
	.space	LINE_LEN

