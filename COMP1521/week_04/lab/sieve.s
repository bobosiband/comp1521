# Sieve of Eratosthenes
# https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
# Bongani Sibanda, 7/10/2025

# Constants
ARRAY_LEN = 1000

main:

	# TODO: add your code here
i_loop_init:
	li	$t0, 2		# int i = 2
i_loop_cond:
	bge	$t0, ARRAY_LEN, i_loop_end
i_loop_body:
	la	$t1, prime
	add $t1, $t1, $t0
	lb	$t4, ($t1)
	beqz	$t4, i_loop_step			# if (prime[i] != 0)
	move	$a0, $t0
	li	$v0, 1
	syscall
	li	$v0, 11				#   syscall 11: print_char
	li	$a0, '\n'
	syscall
j_loop_init:
	li	$t2, 2				# int j = 2
	mul	$t2, $t2, $t0		# j *= i
j_loop_cond:
	bge	$t2, ARRAY_LEN, j_loop_end
j_loop_body:
	la	$t1, prime
	add	$t1, $t1, $t2
	lb	$t3, ($t1)
	move $t3, $0
	sb	$t3, ($t1) 
j_loop_step:
	add	$t2, $t2, $t0
	b	j_loop_cond
j_loop_end:

i_loop_step:
	addi	$t0, $t0, 1
	b	i_loop_cond
i_loop_end:

	li	$v0, 0
	jr	$ra			# return 0;

	.data
prime:
	.byte	1:ARRAY_LEN		# uint8_t prime[ARRAY_LEN] = {1, 1, ...};
