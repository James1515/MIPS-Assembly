##########################################################################################
# File: Excercize#1.asm              Language: MIPS32
# Author: James Ortiz 
# 
#
##########################################################################################
# Directions:
# 
# Put the following bit pattern into register $1 :
# DEADBEEF
#
#Do this one letter at a time, using ori to load each letter (each nibble) into a register, 
#then shifting it into position. You will need to use ori, or, and sll instructions. 
#Look at the contents of register $1 as you push F10 to single step the program.
##########################################################################################


#----------------Data Instruction Section-----------------------#


	.data
	
#----------------Instructions for Program-----------------------#

.text	
main:

	ori $t1, $0, 0x0D #$t1 has 'D' $t1 =    0000 0000 0000 0000 0000 0000 0000 1101
	sll $t1, $t1, 28  #$t1             =    1101 0000 0000 0000 0000 0000 0000 0000
	ori $t2, $0, 0x0E #$t2 has 'E'     =    0000 0000 0000 0000 0000 0000 0000 1110
	sll $t2, $t2, 24  #$t2             =    0000 1110 0000 0000 0000 0000 0000 0000
	or  $t1, $t1, $t2 # $t1 = ($t1 | $t2) = 1101 1110 0000 0000 0000 0000 0000 0000

	ori $t3, $0, 0x0A #$t2                = 0000 0000 0000 0000 0000 0000 0000 1010
	sll $t3, $t3, 20  #$t2                = 0000 0000 1010 0000 0000 0000 0000 0000
	or  $t1, $t1, $t3 #$t1 =  ($t1 | $t2) = 1101 1110 1010 0000 0000 0000 0000 0000
	
	
	ori $t4, $0, 0x0D #$t2 =                0000 0000 0000 0000 0000 0000 0000 1101
	sll $t4, $t4, 16  #$t2 =                0000 0000 0000 1101 0000 0000 0000 0000
	or  $t1, $t1, $t4 #$t1 =  ($t1 | $t2) = 1101 1110 1010 1101 0000 0000 0000 0000
	
	ori $t5, $0, 0x0B #$t2                = 0000 0000 0000 0000 0000 0000 0000 1011
	sll $t5, $t5, 12  #$t2                = 0000 0000 0000 0000 1011 0000 0000 0000
	or  $t1, $t1, $t5 #$t1 = ($t1 | $t2)  = 1101 1110 1010 1101 1011 0000 0000 0000

	
	ori $t6, $0, 0x0E #$t2                = 0x0000 000E
	sll $t6, $t6, 8   #$t2                = 0000 0000 0000 0000 0000 1110 0000 0000
	or  $t1, $t1, $t6 #$t1                = 1101 1110 1010 1101 1011 1110 0000 0000
	
	ori $t7, $0, 0x0E
	sll $t7, $t7, 4
	or  $t1, $t1, $t7 
	
	ori	$s1, $0, 0x0F
	or  $1, $t1, $s1
	
	li $v0, 10                           #Terminate program with syscall(10)
	syscall 
	
	
