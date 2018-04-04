.data
	prompt: .asciiz " Please enter a string: "
	str:      .space 100
	resultMessage: .asciiz " Reverse string: "
	output: .asciiz 

.text
.globl main

main:

	#displays the prompt message
	li $v0, 4
	la $a0, prompt
	syscall

	#getting text from the user
	li $v0, 8
	la $a0, str
	li $a1, 100
	syscall

	#displays result message:
	li $v0, 4
	la $a0, resultMessage
	syscall


#Finding the length of the string
strLen:                 

	lb      $t0, str($t2)   #loading value
	add     $t2, $t2, 1
	bne     $t0, $zero, strLen
	li      $v0, 11         

Loop:

	sub     $t2, $t2, 1     
	la      $t0, str($t2)   
	lb      $a0, ($t0)
	syscall


	bnez    $t2, Loop
	la      $a0, output     #Calling opening output
	li      $v0, 4
	syscall

	#Tell the system this the end of the loop
	li      $v0, 10              
	syscall
