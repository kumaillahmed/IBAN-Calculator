	.data
	
	my_buffer: 
	.space 25
	
	.globl validate_checksum
	.text

# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
validate_checksum:
	# TODO
	li $t0 0				#loads 0 into t0(counter)
	addiu $a0 $a0 2				#increases a0 position by 2
	
CheckDigits_Extract:
	lb $t1, ($a0)				#loads first Check Digit from a0 to t1
	addiu $a0 $a0 1				#increases a0 position by 1
	
	lb $t2, ($a0)				#loads second Check Digit from a0 to t2
	addiu $a0 $a0 1				#increases a0 position by 1

	la $t3, my_buffer			#loads address of my_buffer into register
	
Copy_IBAN_to_New_Buffer:
	lb $t4, ($a0)				#loads byte from a0 to t4
	sb $t4, ($t3)				#store a byte into the first byte of the buffer
	addiu $a0 $a0 1				#increase the a0 position by 1
	addiu $t3 $t3 1				#increase t3 position by 1
	addiu $t0 $t0 1				#for the next byte of the buffer
	ble $t0 17 Copy_IBAN_to_New_Buffer	#loop till we reach end of IBAN
	

	li $t5 0x00000031			#loads ASCII of 1 in t5
	sb $t5, ($t3)				#stores ASCII of 1 in a byte of t3
	
	addiu $t3 $t3 1				#increase t3 position by 1	
	li $t6 0x00000033			#loads ASCII of 3 in t6
	sb $t6, ($t3)				#stores ASCII of 3 in a byte of t3
	
	addiu $t3 $t3 1				#increase t3 position by 1	
	li $t7 0x00000031			#loads ASCII of 1 in t7
	sb $t7, ($t3)				#stores ASCII of 1 in a byte of t3
	
	addiu $t3 $t3 1				#increase t3 position by 1
	li $t8 0x00000034			#loads ASCII of 4 in t8
	sb $t8, ($t3)				#stores ASCII of 4 in a byte of t3
	
	addiu $t3 $t3 1				#increase t3 position by 1	
	sb $t1, ($t3)				#stores first Check Digit into $t3
	addiu $t3 $t3 1				#increase t3 position by 1	
	sb $t2, ($t3)				#stores second Check Digit into $t3
 
 Using_ModuloStr_Function:
	
	addiu $sp $sp -20
	sw $a0, 0($sp)			
	sw $ra, 16($sp)
	
	la $a0, my_buffer			#overwrites address of new IBAN into a0
	li $a1 24				#loads 24 into a1
	li $a2 97				#loads 97 into a2 
	
	jal modulo_str				#jumps and links to modulo_str

	lw $ra, 16($sp)
	sw $a0, 0($sp)
	addiu $sp $sp 20
	
	jr 	$ra

