

fact:	
    slti $t0, $a0, 1    # test for n < 1
	beq	 $t0, $zero, L1	# if n >= 1, go to L1

	li	$v0, 1		    # return 1
	jr	$ra		        # return to instruction after jal

L1:	
    addi $sp, $sp, -8	    # adjust stack for 2 items
	sw	$ra, 4($sp)	        # save the return address
	sw	$a0, 0($sp)	        # save the argument n

	addi	$a0, $a0, -1	# n >= 1; argument gets (n – 1)
	jal	fact		        # call fact with (n – 1)

	lw	$a0, 0($sp)	        # return from jal: restore argument n
	lw	$ra, 4($sp)	        # restore the return address
	addi	$sp, $sp, 8	    # adjust stack pointer to pop 2 items

	mul	$v0, $a0, $v0	    # return n * fact (n – 1)

	jr	$ra		            # return to the caller
	

main:
      #Message Number 1 Prompt:
      li $v0, 4      #System call for print string
	  la $a0, msg1   #$a0 obtains address of string, to display string.
	  syscall
	  

LOOP:
	  
	  #Message Number 2 Prompt:
	  li $v0, 4      #System call for print string
	  la $a0, msg2   #$a0 obtains address of string, to display text
	  syscall
	  
 
	  li $v0, 5      #system call to read int from keyboard
	  syscall 
	  move $s0, $v0  #Value returned in $v0
	  
	  bltz $s0, exit #Checks if value is < 0, if true, goto exit:
	
	 #Printing out the number in msg3:
	  li $v0, 1
	  move $a0, $s0 
	  syscall 
	  
	  #jal to L1:
	  jal L1
	  
	  move $s1, $v0 #Moves value recieved after jal to $s1
	  
	  
	  #Displays third message:
	  li $v0, 4
	  la $a0, msg3
	  syscall
	  
	  #Printing out the second number:
	  li $v0, 1
	  move $a0, $s1
	  syscall
	  
      j LOOP 	#LOOP Repeats HERE:
	  
	exit:       #Early exit, if value is < 0
	
	  #Display Thanks message
	  li $v0, 4
	  la $a0, msg4
	  syscall
	  
	 #Exit Program 
	  li $v0, 10
	  syscall
.data

msg1: .asciiz "Welcome to the factorial tester!"
msg2: .asciiz "\nEnter a value for n (or a negative value to exit): "
msg3: .asciiz "! is "
msg4: .asciiz "Come back soon!\n"
.text

