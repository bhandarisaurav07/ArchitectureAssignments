.data
	prompt: .asciiz "Enter an integer: "
	result: .asciiz "The factorial of the number is: "
	input: .word 0
	output: .word 0
	
.text
.globl main
main:
	#Read input from the user
	li $v0, 4
	la $a0, prompt
	syscall
	
	li $v0, 5
	syscall
	
	sw $v0, input
	
	#call the factorial function 
	lw $a0, input 			#argument to the function
	jal factorial
	sw $v0, output		 #storing the returned value
	
	#display the result prompt
	li $v0, 4
	la $a0, result
	syscall
	
	#dispaly the result
	li $v0, 1
	lw, $a0, output
	syscall
	
	#the end of the main function
	li $v0, 10
	syscall
	
.globl factorial
factorial:

	subu $sp, $sp, 8 		#enough space for two values to store
	sw $ra, ($sp) #putting value to the stack
	sw $s0, 4($sp)
	
	#the base of the function when the argument is equal to zero
	li $v0, 1   			 #return 1 
	beq $a0, 0, terminate
	
	#if argument is not equsl to zero, factorial(input -1)
	move $s0, $a0
	sub $a0, $a0, 1
	jal factorial
	
	mul $v0, $s0, $v0
	
	terminate:
		lw $ra, ($sp)
		lw $s0, 4($sp) 		#loading the value back to the register/getting values back from stack
		addu $sp, $sp, 8	 #restore the stack
		
		jr $ra 			#return from the function
