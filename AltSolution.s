

#Summit: Calculate Formula (n) - Formula (m-1)
#$ra - contains return address
#$s0 - Saves value of "m"
#$s1 - Saves value of "n"
#$s2 - Saves value of Formula (n) - Formula (m-1)

Summit: 
	blt $a1, $a0, early_exit #if $a1 < $a0 goto early_exit 
	addi $sp, $sp, -16       #Create a stack for 4 registers 
	sw $ra, 12($sp)
	sw $s0, 8($sp)
	sw $s1, 4($sp)
	sw $s2, 0($sp)
	
	move $s0, $a0   #$s0 = m 
	move $s1, $a1   #$s1 = n
	
	move $a0, $s1    #a0 = $s1 
	jal Formula      #Call Formula (n) 
	
	move $s1, $v0    #$s1 = Formula (n) 
	
	addi $s0, $s0, -1 #$s0 = m - 1
	
	move $a0, $s0     #a0 = $s0
	
	jal Formula       #$v0 = Formula (m-1)
	
	move $s0, $v0     #$s0 = Formula (m-1)
	
	sub $v0, $s1, $v0 #$s2 = Formula (n) - Formula (m-1)
	
	
	#Restore the stack
	
	lw $s2, 0($sp)
	lw $s1, 4($sp)
	lw $s0, 8($sp)
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra 
	
early_exit:
		li $v0, 0
		jr $ra 
	
	





#Formula: Calculate x(x+1)/2
#$a0 - Contains parameter x
#$t0 - Contains x - 1
#$t1 - Contains x(x+1)
#$t2 - Contains "2"
#$t3 - Contains x(x+1)/2
#$v0 - To be returned from this function
#--------------------------------------------
Formula:
	addi $t0, $a0, 1  #$t0 contains x+1
	mul  $t1, $a0, $t0 #$t1 contains x(x+1)
	li   $t2, 2        #$t2 contains "2"
	div  $t3, $t1, $t2 #$t3 contains x(x+1)/2
	move $v0, $t3      #$v0 = $t3 
	jr $ra             #return 
#---------------------------------------------








# Driver program provided by Stephen P. Leach -- written 03/10/12
# Register use:
#	$s0	the value of m
#	$s1	the value of n
#	$s2	the value of the sum [m+(m+1)+..+n]

main:	la	$a0, intr		# print intro
	li	$v0, 4
	syscall

next:	la	$a0, reqm		# request value of m
	li	$v0, 4
	syscall

	li	$v0, 5			# read value of m
	syscall

	ble	$v0, $zero, out		# if m is 0 or negative, exit

	move	$s0, $v0		# save value of m in $s0

	la	$a0, reqn		# request value of n
	li	$v0, 4
	syscall

	li	$v0, 5			# read value of n
	syscall

	move	$s1, $v0		# save value of n

	move	$a0, $s0		# set parameter m for Summit function
	move	$a1, $v0		# set parameter n for Summit function

	jal	Summit			# invoke Summit function

	move	$s2, $v0		# save answer

	la	$a0, txt1		# display answer (txt1)
	li	$v0, 4
	syscall

	move	$a0, $s0		# display m
	li	$v0, 1
	syscall

	la	$a0, txt2		# display answer (txt2)
	li	$v0, 4
	syscall

	move	$a0, $s1		# display n
	li	$v0, 1
	syscall

	la	$a0, txt3		# display answer (txt3)
	li	$v0, 4
	syscall

	move	$a0, $s2		# display answer (value)
	li	$v0, 1
	syscall

	j	next			# branch back for next value of m

out:	la	$a0, done		# display closing
	li	$v0, 4
	syscall

	li	$v0, 10		# exit from the program
	syscall


	.data
intr:	.asciiz  "Welcome to the Example Problem tester!"
reqm:	.asciiz  "\nEnter a value for m (0 or negative to exit): "
reqn:	.asciiz  "Enter a value for n: "
txt1:	.asciiz  "The sum of the numbers from "
txt2:	.asciiz  " to "
txt3:	.asciiz  " is "
done:	.asciiz  "Come back soon!\n"

