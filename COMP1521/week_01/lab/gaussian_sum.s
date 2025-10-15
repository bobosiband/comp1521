# A simple MIPS program that calculates the Gaussian sum between two numbers

# int main(void)
# {
#   int number1, number2;
#
#   printf("Enter first number: ");
#   scanf("%d", &number1);
#
#   printf("Enter second number: ");
#   scanf("%d", &number2);
#
#   int gaussian_sum = ((number2 - number1 + 1) * (number1 + number2)) / 2;
#
#   printf("The sum of all numbers between %d and %d (inclusive) is: %d\n", number1, number2, gaussian_sum);
#
#   return 0;
# }
PRINT_STR=4
READ_INT=5
PRINT_INT=1
  .text
main:

  #
  # TODO: add your code HERE
  la    $a0, prompt1 # Enter the first number 
  li    $v0, PRINT_STR
  syscall
  li    $v0, READ_INT #scanf
  syscall
  move  $t0, $v0 # number1 = t0
  la    $a0, prompt2 #Enter the second number
  li    $v0, PRINT_STR
  syscall
  li    $v0, READ_INT
  syscall
  move  $t1, $v0
  add   $t2, $t1, 1 # number2 + 1
  sub   $t3, $t2, $t0 # (number2 + 1) - number 1
  add   $t4, $t0, $t1 # number1 + number2
  mul   $t2, $t3, $t4 # ((number2 + 1) - number 1) * (number1 + number2)
  div   $t3,  $t2, 2

  la    $a0, answer1
  li	  $v0, PRINT_STR
  syscall
  move  $a0, $t0
  li    $v0, PRINT_INT
  syscall
  la    $a0, answer2
  li    $v0, PRINT_STR
  syscall
  move  $a0, $t1
  li    $v0, PRINT_INT
  syscall
  la    $a0, answer3
  li    $v0, PRINT_STR
  syscall  
  move  $a0, $t3
  li    $v0, PRINT_INT
  syscall
  # new line characte r
  la    $a0, newline
  li    $v0, PRINT_STR
  syscall
  #

  li    $v0, 0
  jr    $ra          # return


.data
  prompt1: .asciiz "Enter first number: "
  prompt2: .asciiz "Enter second number: "

  answer1: .asciiz "The sum of all numbers between "
  answer2: .asciiz " and "
  answer3: .asciiz " (inclusive) is: "
  newline: .asciiz "\n"
