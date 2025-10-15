#######################################################################################
######################### COMP1521 25T3 ASSIGNMENT 1: Sudoku ##########################
##                                                                                   ##
## !!! IMPORTANT !!!                                                                 ##
## Before starting work on the assignment, make sure you set your tab-width to 8!    ##
## It is also suggested to indent with tabs only.                                    ##
## Instructions to configure your text editor can be found here:                     ##
##   https://cgi.cse.unsw.edu.au/~cs1521/current/resources/mips-editors.html         ##
## !!! IMPORTANT !!!                                                                 ##
##                                                                                   ##
## This program was written by Bongani Sibanda (z5684226)                            ##
## on 10/2025                                                               ##
##                                                                                   ##
## HEY! HEY YOU! Fill this header comment in RIGHT NOW!!! Don't miss out on that     ##
## precious style mark!!      >:O                                                    ##


########################################
## CONSTANTS: REQUIRED FOR GAME LOGIC ##
########################################
TRUE = 1
FALSE = 0

MAX_NUM_DIGITS = 16
MAX_BOARD_LEN = 16
NUM_BOARD_SIZE_OPTS = 3

MIN_FILL_LEN = 9

DIFF_EASY = 1
DIFF_MEDIUM = 2
DIFF_HARD = 3
DIFF_EXTREME = 4

HIDDEN_FACTOR = 5
DIFF_GRADIENT = 10

NUM_DIFFICULTY_OPTS = 4

HINT_KEY = 'i'
HELP_KEY = 'h'
EXIT_KEY = 'q'
SOLUTION_KEY = 's'
ENTER_KEY = 'e'

BOARD_VERTICAL_SEPERATOR = '|'
BOARD_CROSS_SEPERATOR = '+'
BOARD_HORIZONTAL_SEPERATOR = '-'
BOARD_SPACE_SEPERATOR = ' '

MAX_MISTAKES = 10
MAX_HINTS = 10

INVALID = 12
ALREADY_FILLED = 13
MISTAKE =  14
SUCCESS = 15

GAME_STATE_PLAYING = 0
GAME_STATE_OVER = 1
GAME_STATE_WON = 2

UNSET = '#'

#################################################
## CONSTANTS: PLEASE USE THESE FOR YOUR SANITY ##
#################################################

SIZEOF_INT = 4
SIZEOF_PTR = 4
SIZEOF_CHAR = 1

##########################################################
# struct board_tracker {				 #
#     int is_filled_row[MAX_BOARD_LEN][MAX_NUM_DIGITS];  #
#     int is_filled_col[MAX_BOARD_LEN][MAX_NUM_DIGITS];  #
#     int is_filled_box[MAX_NUM_DIGITS][MAX_NUM_DIGITS]; #
#     char board[MAX_BOARD_LEN][MAX_BOARD_LEN];		 #
# };							 #
##########################################################

SIZEOF_BOARD = SIZEOF_CHAR * MAX_BOARD_LEN * MAX_BOARD_LEN
SIZE_OF_IS_FILLED = SIZEOF_INT * MAX_BOARD_LEN * MAX_BOARD_LEN

IS_FILLED_ROW_OFFSET = 0
IS_FILLED_COL_OFFSET = SIZE_OF_IS_FILLED
IS_FILLED_BOX_OFFSET = IS_FILLED_COL_OFFSET + SIZE_OF_IS_FILLED
BOARD_OFFSET = IS_FILLED_BOX_OFFSET + SIZE_OF_IS_FILLED

SIZEOF_BOARD_TRACKER = BOARD_OFFSET + SIZEOF_BOARD

###################
## END CONSTANTS ##
###################

########################################
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
########################################


######################
## GLOBAL VARIABLES ##
######################

	.data

############################################
# char digit_chars[] = "123456789ABCDEFG"; #
############################################

digit_chars:
	.asciiz "123456789ABCDEFG"

###############################
# char cmd_waiting[] = "> "; #
##############################

cmd_waiting:
	.asciiz "> "

########################################
# int board_size_opts[3] = {4, 9, 16}; #
########################################

board_size_opts:
	.word 4, 9, 16

#########################################################
# int difficulty_opts[4] = {    		        #
# 	DIFF_EASY, DIFF_MEDIUM, DIFF_HARD, DIFF_EXTREME #
# };                                                    #
#########################################################

difficulty_opts:
	.word DIFF_EASY, DIFF_MEDIUM, DIFF_HARD, DIFF_EXTREME

###################
# int board_size; #
###################

board_size:
	.align 2
	.space 4

################
# int box_len; #
################

box_len:
	.align 2
	.space 4

###################
# int difficulty; #
###################

difficulty:
	.align 2
	.space 4

####################
# int random_seed; #
####################

random_seed:
	.align 2
	.space 4

###################
# int game_state; #
###################

game_state:
	.align 2
	.space 4

#################
# int mistakes; #
#################

mistakes:
	.align 2
	.space 4

###################
# int hints_used; #
###################

hints_used:
	.align 2
	.space 4

########################
# int cells_remaining; #
########################

cells_remaining:
	.align 2
	.space 4

################################
# struct board_tracker solver; #
################################

solver:
	.align 2
	.space SIZEOF_BOARD_TRACKER

################################
# struct board_tracker puzzle; #
################################

puzzle:
	.align 2
	.space SIZEOF_BOARD_TRACKER

###########################################
## int random_digits[MAX_BOARD_LEN]; ##
###########################################
random_digits:
	.align 2
	.space SIZEOF_INT * MAX_BOARD_LEN


###########################################
## int is_digit_used[MAX_BOARD_LEN]; ##
###########################################
is_digit_used:
	.align 2
	.space SIZEOF_INT * MAX_BOARD_LEN

########################################
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
########################################

##########################
## END GLOBAL VARIABLES ##
##########################

####################
## STATIC STRINGS ##
####################

str_print_welcome_1:
        .asciiz "Welcome to Sudoku!\n"

str_print_welcome_2:
        .asciiz "To enter a number, use: "

str_print_welcome_3:
        .asciiz " <row> <col> <number>\n"

str_print_welcome_4:
        .asciiz "To get a hint, use: "

str_print_welcome_5:
        .asciiz "To see this message again, use: "

str_print_welcome_6:
        .asciiz "To exit, use: "

str_print_welcome_7:
        .asciiz "You can use up to "

str_print_welcome_8:
        .asciiz " hints.\n"

str_print_welcome_9:
        .asciiz "If you make more than "

str_print_welcome_10:
        .asciiz " mistakes, you lose :(\n\n"

str_game_loop_win:
	.asciiz "You win!\n"

str_game_loop_lose:
	.asciiz"Game over :(\n"

str_initialise_game_size_opts:
	.asciiz "Board size options: 4 => 4x4, 9 => 9x9, 16 => 16x16\n"

str_initialise_game_size_prompt:
	.asciiz "Enter a board size: "

str_initialise_game_size_err:
	.asciiz "Invalid board size, choose from  4 => 4x4, 9 => 9x9, 16 => 16x16.\n"

str_initialise_game_diff_opts:
	.asciiz "Difficulty options: 1 => easy, 2 => medium, 3 => hard, 4 => extreme\n"

str_initialise_game_diff_prompt:
	.asciiz "Enter a difficulty level: "

str_initialise_game_diff_err:
	.asciiz "Invalid difficulty, choose from 1 => easy, 2 => medium, 3 => hard, 4 => extreme.\n"

str_initialise_game_seed_prompt:
	.asciiz "Enter a random seed: "

str_process_cmd_remaining:
	.asciiz " cells remaining...\n"

str_process_command_mistakes:
	.asciiz  " mistakes before game over.\n"

str_process_command_hints:
	.asciiz " hints used.\n"

str_process_cmd_no_more_hints:
	.asciiz "No more hints :(\n"

str_process_cmd_unknown:
	.asciiz "Unknown command: "

str_hint_msg_1:
	.asciiz "HINT: "

str_hint_msg_2:
	.asciiz " at ("

str_hint_msg_3:
	.asciiz ", "

str_hint_msg_4:
	.asciiz ")\n"

str_hint_msg_5:
	.asciiz " hints used, "

str_hint_msg_6:
	.asciiz " left.\n"

str_do_enter_invalid:
	.asciiz "Invalid row, column or digit.\n"

str_do_enter_filled:
	.asciiz "Cell is already filled.\n"

str_do_enter_mistake:
	.asciiz "Mistake!\n"

str_do_enter_success:
	.asciiz "Success!!\n"


########################################
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
## DO NOT MODIFY THE .DATA SECTION!!! ##
########################################

########################
## END STATIC STRINGS ##
########################

	.text

############################################################
####                                                    ####
####   Your journey begins here, intrepid adventurer!   ####
####                                                    ####
############################################################

##############
## SUBSET 0 ##
##############

#####################
## int main(void); ##
#####################

################################################################################
# .TEXT <main>
	.text
main:
	# Subset:   0
	#
	# Frame:    [$ra]   
	# Uses:     [$ra, $v0]
	# Clobbers: [all calls handle their own temps]
	#
	# Locals:         
	#   - no
	#
	# Structure:       
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

main__prologue:
	begin
	push $ra 
main__body:
	jal	print_welcome				# print_welcome();

    jal	initialise_game				# initialise_game();

    jal	generate_puzzle				# generate_puzzle();

    jal	game_loop					# game_loop();

main__epilogue:
	pop $ra
	end
	li 	$v0, 0						# return 0
	jr	$ra

###########################
## void print_welcome(); ##
###########################

################################################################################
# .TEXT <print_welcome>
	.text
print_welcome:
	# Subset:   0
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

print_welcome__prologue:
	begin
	push $ra
print_welcome__body:
	la	$a0, str_print_welcome_1 	# "Welcome to Sudoku!\n"
	li	$v0, 4
	syscall						

	la	$a0, str_print_welcome_2 	# "To enter a number, use: "
	li	$v0, 4
	syscall	

	la	$a0, ENTER_KEY 	# " %c "
	li	$v0, 11
	syscall	

	la	$a0, str_print_welcome_3 	# "<row> <col> <number>\n"
	li	$v0, 4
	syscall	

	la	$a0, str_print_welcome_4 	# "To get a hint, use:"
	li	$v0, 4
	syscall	

	la	$a0, HINT_KEY 	# " %c "
	li	$v0, 11
	syscall	

	la	$a0, '\n' 	# "\n"
	li	$v0, 11
	syscall	

	la	$a0, str_print_welcome_5 	# "To see this message again, use:"
	li	$v0, 4
	syscall	

	la	$a0, HELP_KEY 	# " %c "
	li	$v0, 11
	syscall	

	la	$a0, '\n' 	# "\n"
	li	$v0, 11
	syscall	

	la	$a0, str_print_welcome_6 	# "To exit, use :"
	li	$v0, 4
	syscall	
	
	la	$a0, EXIT_KEY 	# " %c "
	li	$v0, 11
	syscall	

	la	$a0, '\n' 	# "\n"
	li	$v0, 11
	syscall	

	la	$a0, str_print_welcome_7 	# "You can use up to "
	li	$v0, 4
	syscall	

	la	$a0, MAX_HINTS 	# " %d "
	li	$v0, 1
	syscall	

	la	$a0, str_print_welcome_8 	# " hints.\n"
	li	$v0, 4
	syscall	

	la	$a0, str_print_welcome_9 	# "If you make more than "
	li	$v0, 4
	syscall	
	
	la	$a0, MAX_MISTAKES 	# " %d "
	li	$v0, 1
	syscall	

	la	$a0, str_print_welcome_10 	# " mistakes, you lose :(\n\n"
	li	$v0, 4
	syscall	

print_welcome__epilogue:
	pop	$ra
	end
	jr	$ra

########################################
## int get_box_num(int row, int col); ##
########################################

################################################################################
# .TEXT <get_box_num>
	.text
get_box_num:
	# Subset:   0
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

get_box_num__prologue:
	begin
	push  $ra
	push  $s0
	push  $s1
get_box_num__body:
	lw    $t0, box_len        # t0 = box_len

	move  $s0, $a0            # s0 = row
	move  $s1, $a1            # s1 = col

    div   $s0, $s0, $t0       # s0 = row / box_len
    div   $s1, $s1, $t0       # s1 = col / box_len

	mul   $s1, $s1, $t0       # s1 = col * box_len
	add   $v0, $s0, $s1       # v0 = row + (col * box_len)

get_box_num__epilogue:
	pop	  $s1
	pop	  $s0
	pop	  $ra
	end 
	jr	  $ra

##############
## SUBSET 1 ##
##############

#########################################################
## int in_bounds(int num);			       ##
#########################################################

################################################################################
# .TEXT <in_bounds>
	.text
in_bounds:
	# Subset:   1
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

in_bounds__prologue:
	begin
	push 	$ra 
	push	$s0 
in_bounds__body:
	move 	$s0, $a0
	lw		$t0, board_size
	bltz	$s0, in_bounds_false
	bge		$s0, $t0, in_bounds_false
in_bounds_true:
	li		$v0, TRUE
	b		in_bounds__epilogue
in_bounds_false:
	li		$v0, FALSE
in_bounds__epilogue:
	pop		$s0
	pop		$ra
	end
	jr		$ra

######################################
## int find_box_len(int total_len); ##
######################################

################################################################################
# .TEXT <find_box_len>
	.text
find_box_len:
	# Subset:   1
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

find_box_len__prologue:
	begin
	push	$ra
	push	$s0	
find_box_len__body:
	move	$s0, $a0
f_b_l_loop_init:
	div		$t0, $s0, 2
f_b_l_loop_cond:
	bltz	$t0, f_b_l_loop_end
f_b_l_loop_body:
	mul		$t1, $t0, $t0
	beq		$t1, $s0, f_b_l_condition_true
f_b_l_loop_step:
	sub		$t0, $t0, 1
	b		f_b_l_loop_cond
f_b_l_condition_true:
	move	$v0, $t0
	b		find_box_len__epilogue
f_b_l_loop_end:
	li		$v0, FALSE

find_box_len__epilogue:
	pop 	$s0
	pop		$ra
	end 
	jr		$ra

#######################
## void game_loop(); ##
#######################

################################################################################
# .TEXT <game_loop>
	.text
game_loop:
	# Subset:   1
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

game_loop__prologue:
	begin
	push 	$ra 
	push 	$s0
	push 	$s1
	push	$s2
game_loop__body:
g_l_loop_init:
	lw		$t1, game_state          # load current game_state
	li		$s0, GAME_STATE_PLAYING
	beq		$t1, $s0, g_l_loop_set   # only set if new game
	b		g_l_loop_cond
g_l_loop_set:
	sw 		$s0, game_state           # initialize only if game_state == PLAYING

g_l_loop_cond:
	lw 		$t1, game_state
	bne		$t1, $s0, g_l_loop_end
g_l_loop_body:
	jal		process_command
g_l_loop_step:
	jal		update_game_state
	b		g_l_loop_cond
g_l_loop_end:
	li   	$s1, GAME_STATE_WON
	bne		$t1, $s1, game_loop_win_cond
	la		$a0, str_game_loop_win
	li		$v0, 4					# "You win!\n"
	syscall
game_loop_win_cond:
	li   	$s2, GAME_STATE_OVER
	bne		$t1, $s2, game_loop_lose_cond
	la		$a0, str_game_loop_lose
	li		$v0, 4					# ""Game over :(\n"
	syscall
game_loop_lose_cond:

game_loop__epilogue:
	pop		$s2
	pop		$s1
	pop 	$s0
	pop		$ra
	end
	jr		$ra


###############################
## void update_game_state(); ##
###############################

################################################################################
# .TEXT <update_game_state>
	.text
update_game_state:
	# Subset:   1
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

update_game_state__prologue:
	begin
	push 	$ra
	push	$s0
	push 	$s1
	push	$s2
update_game_state__body:
	lw 		$t1, game_state
	li		$s0, GAME_STATE_PLAYING
	bne		$t1, $s0, update_game_state__epilogue  # if (game_state != GAME_STATE_PLAYING)

	lw 		$t2, mistakes
	li		$s1, MAX_MISTAKES
	ble		$t2, $s1, mistakes_cond
	li		$s0, GAME_STATE_OVER
	sw		$s0, game_state
	b 		update_game_state__epilogue
mistakes_cond:
	lw		$t3, cells_remaining
	bnez	$t3, cells_remaining_cond
	li		$s2, GAME_STATE_WON
	sw 		$s2, game_state
cells_remaining_cond:

update_game_state__epilogue:
	pop		$s2
	pop		$s1
	pop		$s0
	pop		$ra
	end 
	jr		$ra

########################################################################
## int option_is_valid(int value, int *option_list, int num_options); ##
########################################################################

################################################################################
# .TEXT <option_is_valid>
	.text
option_is_valid:
	# Subset:   1
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

option_is_valid__prologue:
	begin
	push 	$ra
	push	$s0
	push	$s1
	push	$s2
option_is_valid__body:	
	move 	$s0, $a0		# $s0 = value 
	move 	$s1, $a1		# $s1 = option_list
	move 	$s2, $a2		# $s2 = num_option

o_v_loop_init:
	li		$t0, 0
o_v_loop_cond:
	bge		$t0, $s2, o_v_loop_end
o_v_loop_body:
	mul     $t2, $t0, 4
    add     $t3, $s1, $t2
    lw      $t1, 0($t3)
	beq		$s0, $t1, o_v_condtion_true
o_v_loop_step:
	addi 	$t0, $t0, 1
	b		o_v_loop_cond
o_v_condtion_true:
	li		$v0, TRUE
	b		option_is_valid__epilogue
o_v_loop_end:
	li		$v0, FALSE
option_is_valid__epilogue:
	pop		$s2
	pop		$s1
	pop		$s0
	pop		$ra
	end 
	jr	$ra

#############################
## void generate_puzzle(); ##
#############################

################################################################################
# .TEXT <generate_puzzle>
	.text
generate_puzzle:
	# Subset:   1
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

generate_puzzle__prologue:
	begin	
	push 	$ra
generate_puzzle__body:
	la		$a0, solver
	jal		initialise_board_tracker
	la 		$a0, random_digits
	jal 	initialise_digit_choices
	la		$a0, solver
	li		$a1, 0
	li		$a2, 0
	jal	 	solve
	jal		make_user_puzzle
generate_puzzle__epilogue:
	pop 	$ra
	end
	jr		$ra

#############################
## void initialise_game(); ##
#############################

################################################################################
# .TEXT <initialise_game>
	.text
initialise_game:
	# Subset:   1
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

initialise_game__prologue:
	begin
	push	$ra
initialise_game__body:
init_game_loop_start:
	la		$a0, str_initialise_game_size_opts   # "Board size options: 4 => 4x4, 9 => 9x9, 16 => 16x16\n"
	li		$v0, 4
	syscall

	la		$a0, str_initialise_game_size_prompt   # "Enter a board size: "
	li		$v0, 4
	syscall

	li		$v0, 5
	syscall
	sw		$v0, board_size		# board_size = user_board_size
	move 	$a0, $v0
	
	la		$a1, board_size_opts
	li		$a2, NUM_BOARD_SIZE_OPTS
	jal		option_is_valid

	bnez	$v0, board_size_is_valid
	
	la		$a0, str_initialise_game_size_err   # "Invalid board size, choose from  4 => 4x4, 9 => 9x9, 16 => 16x16.\n"
	li		$v0, 4
	syscall
	b		init_game_loop_start
board_size_is_valid:		
	la		$a0, str_initialise_game_diff_opts   # "Difficulty options: 1 => easy, 2 => medium, 3 => hard, 4 => extreme\n"
	li		$v0, 4
	syscall

	la		$a0, str_initialise_game_diff_prompt   # "Enter a difficulty level: "
	li		$v0, 4
	syscall

	li		$v0, 5
	syscall
	sw		$v0, difficulty		#  difficulty = user_difficulty
	move 	$a0, $v0
	
	la		$a1, difficulty_opts
	li		$a2, NUM_DIFFICULTY_OPTS
	jal		option_is_valid

	bnez	$v0, difficulty_is_valid
	
	la		$a0, str_initialise_game_diff_err   #  "Invalid difficulty, choose from 1 => easy, 2 => medium, 3 => hard, 4 => extreme.\n"

	li		$v0, 4
	syscall
	b		init_game_loop_start
difficulty_is_valid:		

init_game_loop_end:

	la		$a0, str_initialise_game_seed_prompt   # "Enter a random seed: "
	li		$v0, 4
	syscall

	li		$v0, 5
	syscall
	sw		$v0, random_seed
	
	lw		$a0, board_size

	jal		find_box_len
	sw		$v0, box_len
	li 		$t0, GAME_STATE_PLAYING
	sw		$t0, game_state
	sw		$0, mistakes
	sw		$0, hints_used

initialise_game__epilogue:
	pop	 	$ra 
	end
	jr		$ra

##############
## SUBSET 2 ##
##############

####################################
## char cell_display_char(int c); ##
####################################

################################################################################
# .TEXT <cell_display_char>
	.text
cell_display_char:
	# Subset:   2
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

cell_display_char__prologue:
	begin
	push 	$ra
	push	$s0
cell_display_char__body:
	move 	$s0, $a0 
	li		$t0, UNSET
	bne		$s0, $t0, not_UNSET
	li		$v0, ' '
	b		cell_display_char__epilogue
not_UNSET:
	li		$t0, '0'
	ble		$s0, $t0, not_greater
	sub		$v0, $s0, 1
	b		cell_display_char__epilogue
not_greater:
	la      $t1, digit_chars   # load the base address
	add     $t1, $t1, $s0      # t1 = digit_chars[s0]
	lb      $v0, 0($t1)        # load byte into v0
cell_display_char__epilogue:
	pop		$s0
	pop		$ra
	end
	jr		$ra

######################################################################
## void initialise_board(char board[MAX_BOARD_LEN][MAX_BOARD_LEN]); ##
######################################################################

################################################################################
# .TEXT <initialise_board>
	.text
initialise_board:
	# Subset:   2
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

initialise_board__prologue:
	begin
	push 	$ra
	push	$s0
initialise_board__body:
	move 	$s0, $a0
init_board_loop_row_init:
	li		$t0, 0         # row = $t0 = 0
init_board_loop_row_cond:
	bge		$t0, MAX_BOARD_LEN, init_board_loop_row_end
init_board_loop_row_body:

init_board_loop_col_init:
	li		$t1, 0         # row = $t0 = 0
init_board_loop_col_cond:
	bge		$t1, MAX_BOARD_LEN, init_board_loop_col_end
init_board_loop_col_body:
	li		$t2, UNSET
	move 	$t5, $s0
	mul		$t3, $t0, MAX_BOARD_LEN
	add		$t3, $t3, $t1
	add  	$t4, $t5, $t3              # t4 = address of board[row][col]
	sb   	$t2, 0($t4)                # store UNSET at that address
init_board_loop_col_step:
	addi 	$t1, $t1, 1
	b		init_board_loop_col_cond
init_board_loop_col_end:

init_board_loop_row_step:
	addi 	$t0, $t0, 1
	b		init_board_loop_row_cond
init_board_loop_row_end:

initialise_board__epilogue:
	pop 	$s0
	pop		$ra
	end
	jr		$ra

#################################################################
## void initialise_digit_choices(int digit_options[MAX_BOARD_LEN]); ##
#################################################################

################################################################################
# .TEXT <initialise_digit_choices>
	.text
initialise_digit_choices:
	# Subset:   2
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

initialise_digit_choices__prologue:
	begin
	push 	$ra
	push	$s0
	push 	$s1 
	push 	$s2
	push 	$s3
	push 	$s4
	push 	$s5
	push 	$s6
initialise_digit_choices__body:
	move 	$s0, $a0					# digits_options
	lw 		$s1, board_size				# board_size 
	la		$s3, is_digit_used			# base address of is_digit_used 

is_dig_loop_init:
	li		$s2, 0	
is_dig_loop_cond:
	bge 	$s2, $s1, is_dig_loop_end
is_dig_loop_body:
	mul	 	$s4, $s2, SIZEOF_INT
	add	 	$t0, $s3, $s4
	li   	$t1, FALSE      
	sw   	$t1, 0($t0)     
is_dig_loop_step:
	addi	$s2, $s2, 1
	b		is_dig_loop_cond
is_dig_loop_end:

# for (int i = 0; i < board_size; i++)
	la		$s3, is_digit_used			# reload base address
init_dig_cho_l_init:
	li	 	$s2, 0  
init_dig_cho_l_cond:
	bge 	$s2, $s1, init_dig_cho_l_end
init_dig_cho_l_body:

# do {
do_while_start:
do_while_body:
	li 		$a0, 0
	sub 	$a1, $s1, 1
	jal 	random_in_range  
	move 	$s4, $v0					# digit = random_in_range(0, board_size - 1)
# } while (is_digit_used[digit]);
do_while_cond:
	mul		$s5, $s4, SIZEOF_INT
	add 	$s6, $s3, $s5
	lw		$t1, 0($s6)
	bnez	$t1, do_while_start

# digit_options[i] = digit;
	move 	$t0, $s0
	mul 	$t1, $s2, SIZEOF_INT
	add 	$t0, $t0, $t1
	sw		$s4, 0($t0)

# is_digit_used[digit] = TRUE;
	li	 	$t1, TRUE
	sw		$t1, 0($s6)

init_dig_cho_l_step:
	addi	$s2, $s2, 1
	b		init_dig_cho_l_cond
init_dig_cho_l_end:

initialise_digit_choices__epilogue:
	pop		$s6
	pop		$s5
	pop		$s4
	pop		$s3
	pop		$s2
	pop 	$s1
	pop		$s0
	pop		$ra
	end 
	jr		$ra

######################################################################
## int is_cell_filled(struct board_tracker *tracker, int x, int y); ##
######################################################################

################################################################################
# .TEXT <is_cell_filled>
	.text
is_cell_filled:
	# Subset:   2
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

is_cell_filled__prologue:
	begin
	push 	$s0
	push	$s1
	push 	$s2
	push 	$ra 	
is_cell_filled__body:
	move    $s0, $a0       # tracker 
    move    $s1, $a1       # x (row)
    move    $s2, $a2       # y (col)

    # Compute base address of board
    add     $t0, $s0, BOARD_OFFSET   # $t0 = base of board in struct

    lw      $t1, board_size

    # Compute offset = row * board_size + col
    mul     $t2, $s1, MAX_BOARD_LEN
    add     $t2, $t2, $s2

    # Add offset to board base
    add     $t0, $t0, $t2

    # Load the char at board[x][y]
    lb      $t3, 0($t0)

    li      $v0, FALSE
    li      $t4, UNSET
    bne     $t3, $t4, i_c_f_Unset_true
    b       i_c_f_Unset_false

i_c_f_Unset_true:
    li      $v0, TRUE
    b       is_cell_filled__epilogue

i_c_f_Unset_false:
    li      $v0, FALSE
is_cell_filled__epilogue:
	pop		$ra
	pop 	$s2
	pop	  	$s1
	pop 	$s0
	end 
	jr		$ra

###################################################
## int handle_move(int row, int col, int digit); ##
###################################################

################################################################################
# .TEXT <handle_move>
	.text
handle_move:
	# Subset:   2
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

handle_move__prologue:
	begin
	push	$ra
	push 	$s0
	push	$s1
	push	$s2
handle_move__body:
	move 	$s0, $a0 
	move 	$s1, $a1
	move 	$s2, $a2

	move 	$a0, $s0
	jal		in_bounds
	beqz	$v0, hanlde_INVALID
	move 	$a0, $s1
	jal		in_bounds
	beqz	$v0, hanlde_INVALID
	move 	$a0, $s2
	jal		in_bounds
	beqz	$v0, hanlde_INVALID
	b		valid_handle
hanlde_INVALID:
	li		$v0, INVALID
	b		handle_move__epilogue
valid_handle:

	la		$a0, puzzle
	move 	$a1, $s0
	move	$a2, $s1
	jal		is_cell_filled
	beqz	$v0, not_Filled
handle_ALREADY_FILLED:
	li		$v0, ALREADY_FILLED
	b		handle_move__epilogue
not_Filled:
	la		$a0, puzzle
	move 	$a1, $s0
	move	$a2, $s1
	move	$a3, $s2
	jal		is_valid_digit
	beqz	$v0, valid_digit_case_else
valid_digit_case_if:
	la		$a0, puzzle
	move 	$a1, $s0
	move	$a2, $s1
	move	$a3, $s2
	jal		update_cell
	lw		$t0, cells_remaining
	addi	$t0, $t0, -1
	sw		$t0, cells_remaining
	li		$v0, SUCCESS
	b		handle_move__epilogue
valid_digit_case_else:
	lw		$t0, mistakes
	addi	$t0, $t0, 1
	sw		$t0, mistakes
	li		$v0, MISTAKE

handle_move__epilogue:
	pop 	$s2
	pop 	$s1
	pop 	$s0
	pop		$ra
	end
	jr		$ra

##############
## SUBSET 3 ##
##############

######################################################################################
## void update_cell(struct board_tracker *check, int row, int col, char new_digit); ##
######################################################################################

################################################################################
# .TEXT <update_cell>
	.text
update_cell:
	# Subset:   3
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

update_cell__prologue:
	begin
	push	$ra 
	push	$s0
	push	$s1
	push	$s2
	push 	$s3
update_cell__body:
	move 	$s0, $a0		#  struct board_tracker *check
	move 	$s1, $a1		#  row
	move 	$s2, $a2		#  col
	move 	$s3, $a3		#  char new_digit

	move 	$a0, $s1
	move 	$a1, $s2
	jal		get_box_num
	move 	$t0, $v0		#  int box = get_box_num(row, col);

	move 	$t1, $s3		#  int dig = new_digit;
	li		$t2, TRUE		#  int use_digit = TRUE;

	bne		$t1, UNSET, u_c_1_case_false
	add     $t3, $s0, BOARD_OFFSET 
	mul		$t4, $s1, MAX_BOARD_LEN
	add     $t4, $t4, $s2			# 

	add 	$t3, $t3, $t4      #  Add offset to board base to get check->board[row][col]

    lb      $t4, 0($t3)
	move 	$t1, $t4			#  dig = check->board[row][col];
	li 		$t2, FALSE			#  use_digit = FALSE;
u_c_1_case_false:
	bne 	$t1, UNSET, u_c_2_case_false
	b		update_cell__epilogue
u_c_2_case_false:
	add     $t3, $s0, BOARD_OFFSET   # start of the board struct 
	mul		$t4, $s1, MAX_BOARD_LEN
	add     $t4, $t4, $s2			# adding the col
	#	$t3 stores the address of the board
	add 	$t3, $t3, $t4      #  Add offset to board base

    sb      $s3, 0($t3)        # check->board[row][col] = new_digit;

	add		$t3, $s0, IS_FILLED_ROW_OFFSET
	mul		$t4, $s1, MAX_BOARD_LEN
	mul		$t4, $t4, SIZEOF_INT
	mul		$t5, $t1, SIZEOF_INT 	# dig X size_of_int = $t5
	add		$t4, $t4, $t5
 	add 	$t3, $t3, $t4      #  Add offset to board base
	sw      $t2, 0($t3)        # check->board[row][col] = use_digit;

	add		$t3, $s0, IS_FILLED_COL_OFFSET
	mul		$t4, $s2, MAX_BOARD_LEN
	mul		$t4, $t4, SIZEOF_INT
	mul		$t5, $t1, SIZEOF_INT
	add		$t4, $t4, $t5
 	add 	$t3, $t3, $t4      #  Add offset to board base
	sw      $t2, 0($t3)        # check->board[col][col] = use_digit;

	add		$t3, $s0, IS_FILLED_BOX_OFFSET
	mul		$t4, $t0, MAX_BOARD_LEN
	mul		$t4, $t4, SIZEOF_INT
	mul		$t5, $t1, SIZEOF_INT
	add		$t4, $t4, $t5
 	add 	$t3, $t3, $t4      #  Add offset to board base
	sw      $t2, 0($t3)        # check->board[box][dig] = use_digit;


update_cell__epilogue:
	pop		$s3
	pop		$s2
	pop		$s1
	pop		$s0
	pop		$ra
	end
	jr		$ra

#############################################################
## int solve(struct board_tracker *tracker, int x, int y); ##
#############################################################

################################################################################
# .TEXT <solve>
	.text
solve:
	# Subset:   3
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

solve__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push 	$s2 
	push 	$s3
	push 	$s4
	push 	$s5	

solve__body:
	move 	$s0, $a0
	move 	$s1, $a1
	move 	$s2, $a2

	lw		$t0, board_size
	#    if (x >= board_size)
	blt		$s1, $t0, solve_if_x_Bsize_not_true
	li		$v0, TRUE
	b		solve__epilogue
solve_if_x_Bsize_not_true:
	#    if (y == board_size)
	bne		$s2, $t0, solve_if_y_Bsize_not_true
	move 	$a0, $s0
	add		$a1, $s1, 1
	li		$a2, 0
	jal	 	solve
	b		solve__epilogue
solve_if_y_Bsize_not_true:
	#    if (is_cell_filled(tracker, x, y))
	move 	$a0, $s0
	move 	$a1, $s1
	move 	$a2, $s2
	jal		is_cell_filled
	beqz	$v0, solve_if_cell_not_fiiled
	move 	$a0, $s0
	move 	$a1, $s1
	add 	$a2, $s2, 1
	jal		solve
	b		solve__epilogue
solve_if_cell_not_fiiled:
	lw 		$s3, board_size       # $s3 = board_size

solve_loop_init:
	li	 	$s4, 0				# $s4 = i = 0
solve_loop_cond:
	bge		$s4, $s3, solve_loop_end 
solve_loop_body:
	la		$t0, random_digits
	mul		$t1, $s4, SIZEOF_INT
	add		$t0, $t0, $t1
	lw		$s5, 0($t0)                 # int dig = random_digits[i];
	
	move 	$a0, $s0
	move 	$a1, $s1
	move 	$a2, $s2
	move 	$a3, $s5
	jal		is_valid_digit
	#    if (is_valid_digit(tracker, x, y, dig))
	beqz	$v0, solve_loop_step   
	move 	$a0, $s0
	move 	$a1, $s1
	move 	$a2, $s2
	move 	$a3, $s5
	jal		update_cell

	move 	$a0, $s0
	move 	$a1, $s1
	add 	$a2, $s2, 1
	jal		solve
	beqz	$v0, solve_loop_if_solve_false
	# return TRUE
	li		$v0, TRUE
	b		solve__epilogue
solve_loop_if_solve_false:
	move 	$a0, $s0
	move 	$a1, $s1
	move 	$a2, $s2
	li	 	$a3, UNSET
	jal		update_cell

solve_loop_step:
	addi	$s4, $s4, 1
	b		solve_loop_cond
solve_loop_end:
	li		$v0, FALSE
solve__epilogue:
	pop		$s5
	pop		$s4
	pop		$s3
	pop		$s2
	pop		$s1
	pop		$s0
	pop		$ra
	end 
	jr		$ra

##############################
## void make_user_puzzle(); ##
##############################

################################################################################
# .TEXT <make_user_puzzle>
	.text
make_user_puzzle:
	# Subset:   3
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

make_user_puzzle__prologue:
	begin 	
	push 	$ra
	push 	$s0
	push 	$s1
	push	$s2
	push 	$s3
	push 	$s4
	push	$s5
	push	$s6
make_user_puzzle__body:
	la		$s0, puzzle     	#  $s0 = puzzle 
	move 	$a0, $s0
	jal		initialise_board_tracker
	lw		$s1, board_size		# $s1 = board_size
	mul		$s2, $s1, $s1		# total_cells = $s2

	div		$s3, $s2, HIDDEN_FACTOR   # int cells_to_show = total_cells / HIDDEN_FACTOR;
	lw 		$t0, difficulty
	sub 	$t0, NUM_DIFFICULTY_OPTS, $t0  # (NUM_DIFFICULTY_OPTS - difficulty)
	mul		$t0, $t0, $s2
	div		$t0, $t0, DIFF_GRADIENT
	lw		$t1, box_len
	add		$t0, $t0, $t1
	#   cells_to_show += (NUM_DIFFICULTY_OPTS - difficulty) * total_cells / DIFF_GRADIENT + box_len;
	add 	$s3, $s3, $t0

make_user_loop_init:
	li		$s4, 0		#  int num_showing = 0;
make_user_loop_cond:
	bge		$s4, $s3, make_user_loop_end
make_user_loop_body:
	li	 	$a0, 0
	sub		$a1, $s2, 1
	jal		random_in_range
	move 	$t0, $v0
	div 	$s5, $t0, $s1				#  row = n / board_size;
	rem		$s6, $t0, $s1				#  col = n % board_size;

	move 	$a0, $s0
	move 	$a1, $s5
	move 	$a2, $s6
	jal		is_cell_filled
	bnez	$v0, make_user_loop_cond
	la		$t0, solver
	add		$t0, $t0, BOARD_OFFSET
	mul		$t1, $s5, MAX_BOARD_LEN
	add		$t1, $t1, $s6
	add		$t0, $t0, $t1
	
	move 	$a0, $s0
	move 	$a1, $s5
	move 	$a2, $s6
	lb		$a3, 0($t0)
	jal		update_cell
make_user_loop_step:
	addi	$s4, $s4, 1
	b		make_user_loop_cond
make_user_loop_end:
	sub		$t0, $s2, $s4
	sw		$t0, cells_remaining

make_user_puzzle__epilogue:
	pop		$s6
	pop		$s5
	pop		$s4
	pop		$s3
	pop		$s2
	pop		$s1
	pop		$s0
	pop		$ra 
	end 	
	jr		$ra

######################
## int give_hint(); ##
######################

################################################################################
# .TEXT <give_hint>
	.text
give_hint:
	# Subset:   3
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

give_hint__prologue:
	begin
	push 	$ra
	push 	$s0 	
	push 	$s1
	push 	$s2
	push 	$s3
	push 	$s4
	push 	$s5
	push 	$s6
	push	$s7
give_hint__body:
	lw		$s0, hints_used
	bne		$s0, MAX_HINTS, give_hint_if_not_max
	li 		$v0, FALSE
	b		give_hint__epilogue
give_hint_if_not_max:
	la		$a0, puzzle
	la		$a1, solver
	li		$a2, SIZEOF_BOARD_TRACKER
	jal		copy_mem
	la 		$a0, solver 
	li		$a1, 0
	li		$a2, 0
	jal		solve

	lw		$s1, board_size				# $s1 = board_size
	mul 	$s2, $s1, $s1				# $s2 = total_cells 

	li		$a0, 0
	sub		$a1, $s2, 1
	jal		random_in_range
	move 	$s3, $v0					# start = $s3 = i

	add		$s4, $s3, $s2				# end = $s4
	
	li		$s5, 0 						# int row = 0;  $s5
	li		$s6, 0						# int col = 0;	$s6

give_hint_loop_init:
	#		$s3 = something
give_hint_loop_cond:
	bge		$s3, $s4, give_hint_loop_end
give_hint_loop_body:
	rem		$t0, $s3, $s2
	div		$s5, $t0, $s1				# row = (i % total_cells) / board_size;
	rem		$s6, $s3, $s1				# col = i % board_size;

	la		$a0, puzzle
	move 	$a1, $s5
	move 	$a2, $s6

	jal		is_cell_filled
	beqz	$v0, give_hint_loop_end
give_hint_loop_step:
	addi	$s3, $s3, 1
	b		give_hint_loop_cond
give_hint_loop_end:

	la		$t0, solver
	add		$t0, $t0, BOARD_OFFSET
	mul		$t1, $s5, MAX_BOARD_LEN
	add		$t1, $t1, $s6
	add		$t0, $t0, $t1

	move 	$s0, $t0				# ans = $s0
	la 		$a0, puzzle
	move 	$a1, $s5
	move 	$a2, $s6
	lb		$a3, 0($s0)				# solver.board[row][col]
	jal		update_cell

	lw		$t0, hints_used
	add		$t0, $t0, 1			  # hints_used++
	sw		$t0, hints_used
	lw		$t0, cells_remaining
	sub		$t0, $t0, 1
	sw		$t0, cells_remaining

	lb	 	$a0, 0($s0)
	move 	$a1, $s5
	move 	$a2, $s6
	jal		print_hint_msg

	li		$v0, TRUE
	
give_hint__epilogue:
	pop		$s7
	pop		$s6
	pop		$s5
	pop		$s4
	pop		$s3
	pop		$s2
	pop		$s1
	pop		$s0
	pop		$ra
	end
	jr		$ra


#########################################################
## void copy_mem(void *src, void *dst, int num_bytes); ##
#########################################################

################################################################################
# .TEXT <copy_mem>
	.text
copy_mem:
	# Subset:   3
	#
	# Frame:    [...]   <-- FILL THESE OUT!
	# Uses:     [...]
	# Clobbers: [...]
	#
	# Locals:           <-- FILL THIS OUT!
	#   - ...
	#
	# Structure:        <-- FILL THIS OUT!
	#   main
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

copy_mem__prologue:
	begin
	push 	$ra
	push 	$s0
	push 	$s1
	push	$s2
copy_mem__body:
	move 	$s0, $a0
	move 	$s1, $a1	
	move 	$s2, $a2

	move 	$t0, $s0			# int *src_int_ptr = (int*) src;
	move	$t1, $s1			# int *dst_int_ptr = (int*) dst;
copy_mem_loop_one_init:
	li		$t2, 0
copy_mem_loop_one_cond:
	div		$t3, $s2, SIZEOF_INT
	bge		$t2, $t3, copy_mem_loop_one_end
copy_mem_loop_one_body:
	lw		$t4, 0($t0)
	sw		$t4, 0($t1)
	add		$t0, $t0, SIZEOF_INT
	add		$t1, $t1, SIZEOF_INT
copy_mem_loop_one_step:
	addi	$t2, $t2, 1
	b		copy_mem_loop_one_cond
copy_mem_loop_one_end:
###############################################
	
	# move 	$t0, $s0			# int *src_int_ptr = (char*) src;
	# move	$t1, $s1			# int *dst_int_ptr = (char*) dst;
copy_mem_loop_two_init:
	li		$t2, 0
copy_mem_loop_two_cond:
	rem		$t3, $s2, SIZEOF_INT
	bge		$t2, $t3, copy_mem_loop_two_end
copy_mem_loop_two_body:
	lb		$t4, 0($t0)
	sb		$t4, 0($t1)
	add		$t0, $t0, SIZEOF_CHAR
	add		$t1, $t1, SIZEOF_CHAR
copy_mem_loop_two_step:
	addi	$t2, $t2, 1
	b		copy_mem_loop_two_cond
copy_mem_loop_two_end:

copy_mem__epilogue:
	pop		$s2
	pop		$s1
	pop		$s0
	pop		$ra
	end
	jr		$ra

##############
## PROVIDED ##
##############

#######################################################################
## unsigned int random_in_range(unsigned int min, unsigned int max); ##
#######################################################################

################################################################################
# .TEXT <random_in_range>
	.text
random_in_range:
	# Frame:    [None]
	# Uses:     [$v0, $a0, $a1, $t0-$t4]
	# Clobbers: [$v0, $a0, $a1, $t0-$t4]
	#
	# Locals:           
	#   - $a0 unsigned int min
	#   - $a1 unsigned int max
	#   - $t0 int a
	#   - $t1 int c
	#   - $t2 int m
	#
	# Structure:        
	#   random_in_range
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

random_in_range__prologue:
random_in_range__body:
	li	$t0, 103515245		# int a = 103515245;
	li	$t1, 12345		# int c = 12345;
	li	$t2, 2147483647		# int m = 2147483647;

	lw	$t3, random_seed	# random_seed = (a * random_seed + c) % m;
	mul	$t4, $t0, $t3		# .. a * random_seed
	add	$t4, $t4, $t1		# .. a * random_seed + c
	remu	$t4, $t4, $t2		# .. (a * random_seed + c) % m
	sw	$t4, random_seed	#

	add	$t0, $a1, 1		# random_seed % (max - min + 1)
	sub	$t0, $t0, $a0		# 
	rem	$t4, $t4, $t0		# 
	add	$v0, $t4, $a0		# return min + (random_seed % (max - min + 1));
random_in_range__epilogue:
	jr	$ra


#############################
## void process_command(); ##
#############################

################################################################################
# .TEXT <process_command>
	.text
process_command:
	# Frame:    [$ra]
	# Uses:     [$v0, $a0, $t0]
	# Clobbers: [$v0, $a0, $t0]
	#
	# Locals:           
	#   - $t0, command
	#
	# Structure:        
	#   process_command
	#   -> [prologue]
	#       -> body
	#       -> good_parsing_cond
	#       -> good_parsing_end
	#       -> enter
	#       -> help
	#       -> hint
	#       -> default
	#       -> switch_end
	#       -> reprint
	#       -> done
	#   -> [epilogue]

process_command__prologue:
	begin
	push	$ra
process_command__body:
	la	$a0, puzzle				# print_puzzle(puzzle.board);
	add	$a0, $a0, BOARD_OFFSET			#
	jal	print_puzzle				#

	lw	$a0, cells_remaining			# printf("%d cells remaining...\n", cells_remaining);
	li	$v0, 1					#
	syscall						#
							#
	la	$a0, str_process_cmd_remaining		# 
	li	$v0, 4					#
	syscall						#

	lw	$a0, mistakes				# printf("%d/%d mistakes before game over.", mistakes, MAX_MISTAKES);
	li	$v0, 1					#
	syscall						#
							#
	li	$a0, '/'				# 
	li	$v0, 11					#
	syscall						#
							#
	li	$a0, MAX_MISTAKES			# 
	li	$v0, 1					#
	syscall						#
							#
	la	$a0, str_process_command_mistakes	#
	li	$v0, 4					#
	syscall						#

	lw	$a0, hints_used				# printf("%d/%d hints used.");
	li	$v0, 1					#
	syscall						#
							#
	li	$a0, '/'				# 
	li	$v0, 11					#
	syscall						#
							#
	li	$a0, MAX_HINTS				#
	li	$v0, 1					#
	syscall						#
							#
	la	$a0, str_process_command_hints		#
	li	$v0, 4					#
	syscall						#

	la	$a0, cmd_waiting			# printf("%s", cmd_waiting);
	li	$v0, 4					#
	syscall						#

	li	$v0, 12					# char command = getchar()
	syscall						#
	move	$t0, $v0				#

process_command__good_parsing_cond:			# while (char == '\n') {
	bne	$t0, '\n', process_command__good_parsing_end
	li	$v0, 12					# 	command = getchar()
	syscall						#
	move	$t0, $v0				#
	b	process_command__good_parsing_cond	# }
process_command__good_parsing_end:

							# switch (command) {
	bne	$t0, EXIT_KEY, process_command__enter	# case EXIT_KEY:
	li	$v0, 10					# exit(0);
	syscall

process_command__enter:
	bne	$t0, ENTER_KEY, process_command__help	# case ENTER_KEY:
	jal	do_enter				# 	do_enter();
	b	process_command__switch_end		# 	break;

process_command__help:
	bne	$t0, HELP_KEY, process_command__hint	# case HELP_KEY:
	jal	print_welcome				# 	print_welcome();
	b	process_command__switch_end		# 	break;

process_command__hint:
	bne	$t0, HINT_KEY, process_command__default	# case HINT_KEY:
	jal	give_hint				# 	if (!give_hint()) {
	bnez	$v0, process_command__switch_end	#
							#
	li	$v0, 4					# 		printf("No more hints :(\n");
	la	$a0, str_process_cmd_no_more_hints	#
	syscall						#	}
	b	process_command__switch_end		# 	break;

process_command__default:				# default:
	li	$v0, 4					# 	printf("Unknown command: ");
	la	$a0, str_process_cmd_unknown		#
	syscall						#
							#
	li	$v0, 11					# 	printf("%c", command);
	move	$a0, $t0				#	
	syscall						#
							#
	li	$v0, 11					# 	printf("\n");
	li	$a0, '\n'				#
	syscall						#

process_command__switch_end:

	lw	$t0, cells_remaining			# if (!cells_remaining || mistakes > MAX_MISTAKES) {		
	beqz	$t0, process_command__reprint		# 
							#
	lw	$t0, mistakes				#
	bgt	$t0, MAX_MISTAKES, process_command__reprint
							#
	b	process_command__done			#

process_command__reprint:
	la	$a0, puzzle				#	print_puzzle(puzzle.board);
	add	$a0, $a0, BOARD_OFFSET			#
	jal	print_puzzle				# }

process_command__done:
	li	$v0, 11					# printf("\n");
	li	$a0, '\n'
	syscall

process_command__epilogue:
	pop	$ra
	end
	jr	$ra


####################################
## void cell_char_to_num(char c); ##
####################################

################################################################################
# .TEXT <cell_char_to_num>
	.text
cell_char_to_num:
	# Frame:    [None]
	# Uses:     [$v0, $a0]
	# Clobbers: [$v0, $a0]
	#
	# Locals:           
	#   - $a0, int c
	#
	# Structure:        
	#   process_command
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]
cell_char_to_num__prologue:
cell_char_to_num__body:
	sub	$v0, $a0, 'A'				# if (c >= 'A') return c - 'A';
	add	$v0, $v0, 10
	bge	$a0, 'A', cell_char_to_num__epilogue	#

	sub	$v0, $a0, '0'
cell_char_to_num__epilogue:
	jr	$ra

######################
## void do_enter(); ##
######################

################################################################################
# .TEXT <do_enter>
	.text
do_enter:
	# Frame:    [$ra, $s0 - $s2]
	# Uses:     [$v0, $a0 - $a2]
	# Clobbers: [$v0, $a0]
	#
	# Locals:           
	#   - $s0, r, row
	#   - $s0, c, col
	#   - $s0, d, digit
	#   - $v0, move_status
	#
	# Structure:        
	#   process_command
	#   -> [prologue]
	#       -> body
	#       -> filled
	#       -> mistake
	#       -> success
	#   -> [epilogue]

do_enter__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
do_enter__body:
	li	$v0, 12				# scanf(" %c", &r);
	syscall					#
	move	$a0, $v0			#
	jal	cell_char_to_num		#
	move	$s0, $v0			#

	li	$v0, 12				# scanf(" %c", &c);
	syscall					#
	move	$a0, $v0			#
	jal	cell_char_to_num		#
	move	$s1, $v0			#

	li	$v0, 12				# scanf(" %d", &dig);
	syscall					#
	move	$a0, $v0			# 
	jal	cell_char_to_num
	move	$s2, $v0

	move	$a0, $s0			# int move_status = handle_move(row, col, digit - 1);
	move	$a1, $s1			#
	sub	$a2, $s2, 1			#
	jal	handle_move			#

	bne	$v0, INVALID, do_enter__filled	# if (move_status == INVALID) {

	li	$v0, 4				# 	printf("Invalid row, column or digit.\n");
	la	$a0, str_do_enter_invalid	# 
	syscall					#
	b	do_enter__epilogue		# 
do_enter__filled:
	bne	$v0, ALREADY_FILLED, do_enter__mistake	# if (move_status == ALREADY_FILLED) {

	li	$v0, 4				# 	printf("Cell is already filled.\n");
	la	$a0, str_do_enter_filled	# 
	syscall					#
	b	do_enter__epilogue		# 
do_enter__mistake:
	bne	$v0, MISTAKE, do_enter__success	# } else if (move_status == MISTAKE) {

	li	$v0, 4				#	printf("Mistake!\n");
	la	$a0, str_do_enter_mistake	#
	syscall					#
	b	do_enter__epilogue		#
do_enter__success:
	bne	$v0, SUCCESS, do_enter__epilogue# } else if (move_status == SUCCESS) {

	li	$v0, 4				#
	la	$a0, str_do_enter_success	# 	printf("Success!!\n");
	syscall					#
	b	do_enter__epilogue		# }

do_enter__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra

#####################################################
## void print_hint_msg(int ans, int row, int col); ##
#####################################################

################################################################################
# .TEXT <print_hint_msg>
	.text
print_hint_msg:
	# Frame:    [$ra]
	# Uses:     [$v0, $a0 - $a2, $t0 - $t2]
	# Clobbers: [$v0, $a0 - $a2, $t0 - $t2]
	#
	# Locals:      
	#   - $a0 => $t0, int ans
	#   - $t1, char r     
	#   - $a1, int row
	#   - $t1, char r
	#   - $a2, int col
	#   - $t2, char c
	#
	# Structure:        
	#   print_hint_msg
	#   -> [prologue]
	#       -> body
	#       -> fix_col
	#       -> do_print
	#   -> [epilogue]

print_hint_msg__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
print_hint_msg__body:
	move	$s0, $a0
	move	$s1, $a1
	move	$s2, $a2

	lb	$s1, digit_chars($s1)	# char r = digit_chars[row] - 1;
	sub	$s1, $s1, 1		#
	bne	$s1, '@', print_hint_msg__fix_col
	li	$s1, '9'		#

print_hint_msg__fix_col:
	lb	$s2, digit_chars($s2)	# char c = digit_chars[col] - 1;
	sub	$s2, $s2, 1		#
	bne	$s2, '@', print_hint_msg__do_print
	li	$s2, '9'		#

print_hint_msg__do_print:
	
	li	$v0, 4			# printf("HINT: ")
	la	$a0, str_hint_msg_1	#
	syscall				#

	move	$a0, $s0		# printf("%c", cell_display_char(ans));
	jal	cell_display_char			#
	move	$a0, $v0		#
	li	$v0, 11			#
	syscall				#

	li	$v0, 4			# printf(" at (")
	la	$a0, str_hint_msg_2	#
	syscall				#

	li	$v0, 11			# printf("%c", row)
	move	$a0, $s1		#
	syscall				#

	li	$v0, 4			# printf(", ")
	la	$a0, str_hint_msg_3	#
	syscall				#

	li	$v0, 11			# printf("%c", col)
	move	$a0, $s2		#
	syscall				#

	li	$v0, 4			# printf(")\n")
	la	$a0, str_hint_msg_4	#
	syscall				#

	li	$v0, 1			# printf("%d", hints_used)
	lw	$a0, hints_used		#
	syscall				#

	li	$v0, 4			# printf(" hints used, ")
	la	$a0, str_hint_msg_5	#
	syscall				#

	li	$v0, 1			# printf("%d", MAX_HINTS - hints_used)
	lw	$a0, hints_used		#
	sub	$a0, MAX_HINTS, $a0	#
	syscall

	li	$v0, 4			# printf("left.\n")
	la	$a0, str_hint_msg_6	#
	syscall				#

print_hint_msg__epilogue:
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra

###################################################################
## void initialise_board_tracker(struct board_tracker *tracker); ##
###################################################################

################################################################################
# .TEXT <initialise_board_tracker>
	.text
initialise_board_tracker:
	# Frame:    [$ra, $s0]
	# Uses:     [$a0, $t0, $t1, $t2, $t3, $s0]
	# Clobbers: [$a0, $t0, $t1, $t2, $t3]
	#
	# Locals:           
	# 	$s0	struct board_tracker *tracker
	#	$t0	i
	#	$t1	j
	#
	# Structure:        
	#   initialise_board_tracker
	#   -> [prologue]
	#       -> body
	#	-> row
	#	-> col
	#	-> col_end
	#	-> row_end
	#   -> [epilogue]

initialise_board_tracker__prologue:
	begin
	push	$ra
	push	$s0

	move	$s0, $a0
initialise_board_tracker__body:
	add	$a0, $a0, BOARD_OFFSET				# initialise_board(tracker->board);
	jal	initialise_board				#

	li	$t0, 0						# int i = 0;
initialise_board_tracker__row:
	bge	$t0, MAX_BOARD_LEN, initialise_board_tracker__row_end	# while (i < MAX_BOARD_LEN) {

	li	$t1, 0						#	int j = 0;
initialise_board_tracker__col:
	bge	$t1, MAX_BOARD_LEN, initialise_board_tracker__col_end	# 	while (j < MAX_BOARD_LEN) {

	mul	$t2, $t0, MAX_BOARD_LEN				# .. $t2 = i * MAX_BOARD_LEN
	add	$t2, $t2, $t1					# .. $t2 = i * MAX_BOARD_LEN + j
	mul	$t2, $t2, SIZEOF_INT				# .. $t2 = SIZEOF_INT * (i * MAX_BOARD_LEN + j)
	add	$t2, $t2, $s0					# .. $t2 = tracker + SIZEOF_INT * (i * MAX_BOARD_LEN + j)

	li	$t3, FALSE					#
	sw	$t3, IS_FILLED_ROW_OFFSET($t2)			# 		tracker->num_used_row[i][j] = FALSE;
	sw	$t3, IS_FILLED_COL_OFFSET($t2)			# 		tracker->num_used_col[i][j] = FALSE;
	sw	$t3, IS_FILLED_BOX_OFFSET($t2)			# 		tracker->num_used_box[i][j] = FALSE;

	add	$t1, $t1, 1					#		j ++;
	b	initialise_board_tracker__col				#	}
initialise_board_tracker__col_end:

	add	$t0, $t0, 1					#	row ++;
	b	initialise_board_tracker__row				# }
initialise_board_tracker__row_end:


initialise_board_tracker__epilogue:
	pop	$s0
	pop	$ra
	end
	jr	$ra

###################################################################################
## int is_valid_digit(struct board_tracker *check, int row, int col, int digit); ##
###################################################################################

################################################################################
# .TEXT <is_valid_digit>
	.text
is_valid_digit:
	# Frame:    [$ra, $s0, $s1, $s2, $s3]
	# Uses:     [$a0, $a1, $a2, $a3, $t0, $t1, $t2, $s0, $s1, $s2, $s3]
	# Clobbers: [$a0, $a1, $t0, $t1, $t2]
	#
	# Locals:           
	# 	$t0	int box
	# 	$s0	struct board_tracker *check
	# 	$s1	int row
	# 	$s2	int col
	# 	$s3	int digit
	#
	# Structure:        
	#   is_valid_digit
	#   -> [prologue]
	#       -> body
	#   -> [epilogue]

is_valid_digit__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
	push	$s2
	push	$s3

	move	$s0, $a0			# .. $s0 = check
	move	$s1, $a1			# .. $s1 = row
	move	$s2, $a2			# .. $s2 = col
	move	$s3, $a3			# .. $s3 = digit
is_valid_digit__body:
	move	$a0, $s1			# int box = get_box_num(row, col);
	move	$a1, $s2			#
	jal	get_box_num			#
	move	$t0, $v0			# .. $t0 = box


	li	$v0, FALSE			# if (check->num_used_col[col][digit]
	mul	$t1, $s2, MAX_BOARD_LEN		#
	add	$t1, $t1, $s3			# .. $t1 = (col * MAX_BOARD_LEN + digit)
	mul	$t1, $t1, SIZEOF_INT		# .. $t1 *= SIZEOF_INT
	add	$t1, $t1, $s0			# .. $t1 += check
	lw	$t2, IS_FILLED_COL_OFFSET($t1)	#
	bnez	$t2, is_valid_digit__epilogue	#
						#
	mul	$t1, $s1, MAX_BOARD_LEN		# || check->num_used_row[row][digit]
	add	$t1, $t1, $s3			#
	mul	$t1, $t1, SIZEOF_INT		#
	add	$t1, $t1, $s0			#
	lw	$t2, IS_FILLED_ROW_OFFSET($t1)	# 
	bnez	$t2, is_valid_digit__epilogue	# 
						#
	mul	$t1, $t0, MAX_BOARD_LEN		# || check->num_used_box[box][digit])
	add	$t1, $t1, $s3			#
	mul	$t1, $t1, SIZEOF_INT		#
	add	$t1, $t1, $s0			#
	lw	$t2, IS_FILLED_BOX_OFFSET($t1)	#
	bnez	$t2, is_valid_digit__epilogue	# return FALSE;

	li	$v0, TRUE			# else return TRUE;

is_valid_digit__epilogue:
	pop	$s3
	pop	$s2
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra

##################################################################
## void print_puzzle(char board[MAX_BOARD_LEN][MAX_BOARD_LEN]); ##
##################################################################

################################################################################
# .TEXT <print_puzzle>
	.text
print_puzzle:
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$v0, $a0, $t0, $t1, $s0, $s1]
	# Clobbers: [$v0, $a0, $t0, $t1]
	#
	# Locals:      
	#   - $s0, char board[][]
	#   - $s1, int row   
	#   - $t0, char c
	#   - $t1, char r
	#   - $a2, int col
	#   - $t2, char c
	#
	# Structure:        
	#   print_hint_msg
	#   -> [prologue]
	#       -> cond
	#       -> print
	#       -> index
	#       -> end
	#   -> [epilogue]

print_puzzle__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
print_puzzle__body:
	move	$s0, $a0			# .. $s0 = board

	li	$v0, 11				# putchar(BOARD_SPACE_SEPERATOR);
	li	$a0, BOARD_SPACE_SEPERATOR	#
	syscall					#

	la	$a0, digit_chars		# print_row(digit_chars);
	jal	print_row			#

	li	$s1, 0				# row = 0;
print_puzzle__row_cond:
	lw	$t0, board_size			# for (int row = 0; row < board_size; row++) {
	bge	$s1, $t0, print_puzzle__row_end #

	lw	$t1, box_len			#	if (row % box_len == 0) {
	rem	$t0, $s1, $t1			#
	bnez	$t0, print_puzzle__row_print	#

	move	$a0, $s1			# 		print_box_separator(row);
	jal	print_box_separator		#
						#	}

print_puzzle__row_print:
	lb	$t0, digit_chars($s1)		# 	char c = digit_chars[row] - 1;
	sub	$t0, $t0, 1

	bne	$t0, '@', print_puzzle__row_index	# if (c == '@') c = '9';
	li	$t0, '9'				#

print_puzzle__row_index:
	li	$v0, 11				#	putchar(c);
	move	$a0, $t0			#
	syscall					#

	mul	$t0, $s1, MAX_BOARD_LEN		#	print_row(board[row]);
	add	$a0, $t0, $s0			#
	jal	print_row			#

	add	$s1, $s1, 1			#	row++;
	b	print_puzzle__row_cond		# }
print_puzzle__row_end:
	move	$a0, $zero			# print_box_separator(0);
	jal	print_box_separator		#

print_puzzle__epilogue:
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra


#################################
## void print_row(char row[]); ##
#################################

################################################################################
# .TEXT <print_row>
	.text
print_row:
	# Frame:    [$ra, $s0, $s1]
	# Uses:     [$v0, $a0, $t2, $s0, $s1]
	# Clobbers: [$v0, $a0, $t2]
	#
	# Locals:           
	#   - $s0, char row[]
	#   - $s1, int col
	#   - $t2, int c
	#
	# Structure:        
	#   print_row
	#   -> [prologue]
	#       -> body
	#       -> col_loop
	#       -> print_char
	#       -> do_print_char
	#   -> [epilogue]

print_row__prologue:
	begin
	push	$ra
	push	$s0
	push	$s1
print_row__body:
	move	$s0, $a0
	
	li	$s1, 0		# int col = 0;
print_row__col_loop:		# for (int col = 0; col < board_size; col++) {
	lw	$t2, board_size
	bge	$s1, $t2, print_row__col_loop_end

	lw	$t2, box_len	# if (col % box_len == 0) {
	rem	$t2, $s1, $t2
	bnez	$t2, print_row__print_char

	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11
	syscall

	li	$a0, BOARD_SPACE_SEPERATOR	# putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11
	syscall

print_row__print_char:

	add	$t2, $s1, $s0			# int c = cell_display_char(row[col]);
	lb	$a0, ($t2)			#
	jal	cell_display_char		#

	bne	$v0, '@', print_row__do_print_char	# if (c == '@') c = '9';
	li	$v0, '9'				#

print_row__do_print_char:
	move	$a0, $v0				# putchar(c);
	li	$v0, 11
	syscall

	li	$a0, BOARD_SPACE_SEPERATOR	# putchar(BOARD_SPACE_SEPERATOR);
	li	$v0, 11
	syscall

	add	$s1, $s1, 1			# col ++;
	b	print_row__col_loop
print_row__col_loop_end:

	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11
	syscall

	li	$a0, '\n'			# putchar('\n');
	li	$v0, 11
	syscall

print_row__epilogue:
	pop	$s1
	pop	$s0
	pop	$ra
	end
	jr	$ra


########################################
## void print_box_separator(int row); ##
########################################

################################################################################
# .TEXT <print_box_separator>
	.text
print_box_separator:
	# Frame:    [None]
	# Uses:     [$v0, $a0, $t0 - $t2]
	# Clobbers: [$v0, $a0, $t0 - $t2]
	#
	# Locals:           
	#   - $t1, int row
	#   - $t0, i
	#
	# Structure:        
	#   print_box_separator
	#   -> [prologue]
	#       -> body
	#       -> not_box
	#       -> digits
	#       -> loop
	#       -> horiz
	#       -> loop_end
	#   -> [epilogue]

print_box_separator__prologue:
print_box_separator__body:
	move	$t1, $a0

	li	$a0, BOARD_HORIZONTAL_SEPERATOR	# putchar(BOARD_HORIZONTAL_SEPERATOR);
	li	$v0, 11
	syscall

	lw	$t2, box_len			# if (row % box_len == 0) {
	rem	$t2, $t1, $t2
	bnez	$t2, print_box_separator__not_box

	li	$a0, BOARD_CROSS_SEPERATOR	# putchar(BOARD_CROSS_SEPERATOR);
	li	$v0, 11
	syscall

	li	$a0, BOARD_HORIZONTAL_SEPERATOR	# putchar(BOARD_HORIZONTAL_SEPERATOR);
	li	$v0, 11
	syscall

	b	print_box_separator__digits

print_box_separator__not_box:
	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11
	syscall

print_box_separator__digits:

	li	$t0, 0				# int i = 0;
print_box_separator__loop:				# for (int i = 0; i < board_size; i++) {
	lw	$t1, board_size
	bge	$t0, $t1, print_box_separator__loop_end

	lw	$t1, box_len			# if (i % box_len == 0 && i != 0) {
	rem	$t2, $t0, $t1			#
	bnez	$t2, print_box_separator__horiz		#
	beqz	$t0, print_box_separator__horiz		# {

	li	$a0, BOARD_CROSS_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11
	syscall

	li	$a0, BOARD_HORIZONTAL_SEPERATOR	# putchar(BOARD_HORIZONTAL_SEPERATOR);
	li	$v0, 11
	syscall

print_box_separator__horiz:
	li	$a0, BOARD_HORIZONTAL_SEPERATOR	# putchar(BOARD_HORIZONTAL_SEPERATOR);
	li	$v0, 11
	syscall

	li	$a0, BOARD_HORIZONTAL_SEPERATOR	# putchar(BOARD_HORIZONTAL_SEPERATOR);
	li	$v0, 11
	syscall

	add	$t0, $t0, 1
	b	print_box_separator__loop

print_box_separator__loop_end:

	li	$a0, BOARD_VERTICAL_SEPERATOR	# putchar(BOARD_VERTICAL_SEPERATOR);
	li	$v0, 11
	syscall

	li	$a0, '\n'			# putchar('\n');
	li	$v0, 11
	syscall
print_box_separator__epilogue:
	jr	$ra
