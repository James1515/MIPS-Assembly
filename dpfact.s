#
# Author: James Anthony Ortiz
# Professor: Stephen Leach
# Class: CDA3100
# Program: dpfact.s 
#

#dpfact - Expects $a0, returns value in $f0
dpfact:	li	    $t0, 1		    # initialize product to 1.0
	    mtc1	$t0, $f0        # move $t0 to floating register
	    cvt.d.w	$f0, $f0        # convert to double-precision

again:	slti	$t0, $a0, 2		# test for n < 2
	    bne	    $t0, $zero,done	# if n < 2, return

	    mtc1	$a0, $f2		# move n to floating register
	    cvt.d.w	$f2, $f2		# and convert to double precision

	    mul.d	$f0, $f0, $f2	# multiply product by n
	
	    addi	$a0, $a0, -1	# decrease n
	    j	again		        # and loop

done:	jr	$ra		            # return to calling routine
 
 

main: la $a0, intro # print intro
      li $v0, 4
      syscall
	  
loop: la $a0, req # request value of n
      li $v0, 4
      syscall
	  
	  li $v0, 5 # read value of n
      syscall
	  
	  slt $t0, $v0, $zero # if n < 0, exit
	
	  bne $t0, $zero, out
	
	move $s0, $v0 # save value of n
	
	move $a0, $v0 # place value of n in $a0
	
	jal dpfact    # call dpfact function
	
	#mov.d $f2, $f0 # save value returned by fact (Edited)
	
	move $a0, $s0 # display result
	li $v0, 1     # print value of n
	syscall
	
	la $a0, ans   # print text part of answer
	li $v0, 4
	syscall
	
	mov.d $f12, $f0 # print dpfact(n) (Edited)
	li $v0, 3
	syscall
	
	la $a0, cr    # print carriage return
	li $v0, 4
	syscall
	
	
	j loop         # branch back and next value of n
	
out: la $a0, adios # display closing	
	 li $v0, 4
	 syscall
	
	 li $v0, 10    # exit from the program
	 syscall
	 
	.data
intro: .asciiz "Welcome to the double precision factorial tester!\n"
req:   .asciiz "Enter a value for n (or a negative value to exit): "
ans:   .asciiz "! is "
cr:    .asciiz "\n"
adios: .asciiz "Come back soon!\n"