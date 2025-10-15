#  Bongani Sibanda, 7/10/2025

########################################################################
# .DATA
# Here are some handy strings for use in your code.

	.data
prompt_str:
	.asciiz "Enter a random seed: "
result_str:
	.asciiz "The random result is: "

########################################################################
# .TEXT <main>
	.text
main:

	# Args: void
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - main
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

main__prologue:
	begin
	push $ra

	# TODO: add code to set up your stack frame here 

main__body:
	# TODO: complete your function body here
	la	$a0, prompt_str
	li	$v0, 4
	syscall
	li	$v0, 5		# scanf("%d", &random_seed)
	syscall
	move $a0, $v0	# $a0 == random_seed
	jal	seed_rand
	# int value = rand(100)
	li	$a0, 100
	jal	rand
	move $t1, $v0
	# value = add_rand(value)
	move $a0, $t1
	jal	add_rand
	move $t1, $v0
	# value = sub_rand(value)
	move $a0, $t1
	jal	sub_rand
	move $t1, $v0
	# value = seq_rand(value)
	move $a0, $t1
	jal	seq_rand
	move $t1, $v0

	la   $a0, result_str    # printf("The random result is: ")
    li   $v0, 4
    syscall

    move $a0, $t1           # printf("%d\n", value)
    li   $v0, 1
    syscall

    li   $a0, '\n'            # newline
    li   $v0, 11
    syscall


main__epilogue:
	# TODO: add code to clean up stack frame here
	pop $ra
	end
	li	$v0, 0
	jr	$ra				# return 0;

########################################################################
# .TEXT <add_rand>
	.text
add_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - add_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

add_rand__prologue:
	begin
	push	$ra
	push	$s0
	# TODO: add code to set up your stack frame here

add_rand__body:

	# TODO: complete your function body here
	move $s0, $a0       # save input value

    li   $a0, 0xFFFF    # call rand(0xFFFF)
    jal  rand
    move $t0, $v0       # rand result in $t0

    add  $v0, $s0, $t0  # return value + rand result
add_rand__epilogue:
	
	# TODO: add code to clean up stack frame here
	pop $s0
	pop $ra
	end

	jr	$ra


########################################################################
# .TEXT <sub_rand>
	.text
sub_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - sub_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

sub_rand__prologue:
	begin
	push $ra
	push $s0


	# TODO: add code to set up your stack frame here

sub_rand__body:
	move $s0, $a0

	move $a0, $s0
	jal  rand
	move $t0, $v0

	sub	$v0, $s0, $t0
	

	# TODO: complete your function body here

sub_rand__epilogue:
	
	# TODO: add code to clean up stack frame here
	pop $s0
    pop $ra
	end

	jr	$ra

########################################################################
# .TEXT <seq_rand>
	.text
seq_rand:
	# Args:
	#   - $a0: int value
	# Returns: int
	#
	# Frame:	[...]
	# Uses: 	[...]
	# Clobbers:	[...]
	#
	# Locals:
	#   - ...
	#
	# Structure:
	#   - seq_rand
	#     -> [prologue]
	#     -> [body]
	#     -> [epilogue]

seq_rand__prologue:
	begin
	push $ra
    push $s0
    push $s1
    push $s2

	# TODO: add code to set up your stack frame here

seq_rand__body:
	move $s0, $a0 			#s0 = value 

	li	$a0, 100 		# rand(100)
	jal	rand 
	move $s1, $v0		# s1 = limit
s_loop_init:
	li	$s2, 0		# i = 0
s_loop_cond:
	bge  $s2, $s1, s_loop_end  # if i >= limit break
s_loop_body:
	move $a0, $s0          # arg = value
    jal  add_rand
    move $s0, $v0          # value = add_rand(value)

s_loop_step:
	addi $s2, $s2, 1       # i++
    j    s_loop_cond
s_loop_end:
	move $v0, $s0

	# TODO: complete your function body here

seq_rand__epilogue:
	
	# TODO: add code to clean up stack frame here
	pop $s2
    pop $s1
    pop $s0
    pop $ra
	end
	
	jr	$ra



##
## The following are two utility functions, provided for you.
##
## You don't need to modify any of the following,
## but you may find it useful to read through.
## You'll be calling these functions from your code.
##

OFFLINE_SEED = 0x7F10FB5B

########################################################################
# .DATA
	.data
	
# int random_seed;
	.align 2
random_seed:
	.space 4


########################################################################
# .TEXT <seed_rand>
	.text
seed_rand:
# DO NOT CHANGE THIS FUNCTION

	# Args:
	#   - $a0: unsigned int seed
	# Returns: void
	#
	# Frame:	[]
	# Uses:		[$a0, $t0]
	# Clobbers:	[$t0]
	#
	# Locals:
	#   - $t0: offline_seed
	#
	# Structure:
	#   - seed_rand

	li	$t0, OFFLINE_SEED		# const unsigned int offline_seed = OFFLINE_SEED;
	xor	$t0, $a0			# random_seed = seed ^ offline_seed;
	sw	$t0, random_seed

	jr	$ra				# return;

########################################################################
# .TEXT <rand>
	.text
rand:
# DO NOT CHANGE THIS FUNCTION

	# Args:
	#   - $a0: unsigned int n
	# Returns:
	#   - $v0: int
	#
	# Frame:    []
	# Uses:     [$a0, $v0, $t0]
	# Clobbers: [$v0, $t0]
	#
	# Locals:
	#   - $t0: int rand
	#
	# Structure:
	#   - rand

	lw	$t0, random_seed 		# unsigned int rand = random_seed;
	multu	$t0, 0x5bd1e995  		# rand *= 0x5bd1e995;
	mflo	$t0
	addiu	$t0, 12345       		# rand += 12345;
	sw	$t0, random_seed 		# random_seed = rand;

	remu	$v0, $t0, $a0    
	jr	$ra              		# return rand % n;
