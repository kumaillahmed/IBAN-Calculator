	.data
	.globl knr2iban
	.text
# -- knr2iban
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
knr2iban:
	# TODO
	la $t7, ($a0)
	
	li $t0 8			# number of iterations for BLZ
	li $t1 10			# number of iterations for KNR
	
	li $t2, 0x00000044		#inputs "D" in t2
	sb $t2, ($t7)			#inputs "D" in first position of IBAN
	addiu $t7 $t7 1			#increases a0 position by 1
	
	li $t2, 0x00000045		#inputs "E" in t2
	sb $t2, ($t7)			#inputs "E" in second position of IBAN
	
	li $t2 0			#loads 0 into t2(counter)
	li $t3, 0x00000030		#inputs "0" in t3
Loop_0CheckDigits:
	addiu $t7 $t7 1			#increases a0 position by 1
	sb $t3, ($t7)			#adds 0 into current position of a0
	addiu $t2 $t2 1			#increases t2 position by 1
	blt $t2, 2, Loop_0CheckDigits	#branch if t2 < 2 to Loop_0CheckDigits
	
	li $t2 0			#loads 0 into t2(counter)
	addiu $t7 $t7 1			#increases a0 position by 1
Loop_BLZ:
	lb $t4, ($a1)			#load contents of a1 to t4
	sb $t4, ($t7)			#loads one BLZ number from t3 to a0
	addiu $a1, $a1, 1		#increases a1 position by 1
	addiu $t7, $t7, 1		#increases a0 position by 1 for the next BLZ number
	addi $t2, $t2, 1		#increases t2 by 1
	blt $t2, 8, Loop_BLZ		#if t2 < 8, move to Loop_BLZ	
	
	li $t2 0			#t2 is our counter
Loop_KNR:
	lb $t4, ($a2)			#load contents of a2 to t4
	sb $t4, ($t7)			#loads one KNR number from t4 to a0
	addiu $a2, $a2, 1		#increases a2 position by 1
	addiu $t7, $t7, 1		#increases a0 position by 1 for the next KNR number
	addi $t2, $t2, 1		#increases t2 by 1
	blt $t2, 10, Loop_KNR		#if t2 < 10, move to LOOP_KNR	
		
Calling_Validate_Checksum:	
	addiu $sp $sp -20	
	sw $a0, 0($sp)
	sw $a1, 16($sp)
	sw $a2, 20($sp)
	sw $ra, 24($sp)

	jal validate_checksum		#jumps and links to validate_checksum
	
	lw $ra, 24($sp)
	lw $a2, 20($sp)
	lw $a1, 16($sp)
	lw $a0, 0($sp)
	addiu $sp $sp 20
	
Change_Check_Digits:	
	li $t5 98			#loads 98 into t5
	subu $t6, $t5, $v0		#stores result of t5 - v0 in t6
	
	li $t3 0
	li $t4 0
	li $t7 0
	la $t7 ,($a0)
	
	li $t8 10
	
	divu $t6 $t8
	mfhi $t3
	mflo $t4
	
	addiu $t3 $t3 48
	addiu $t4 $t4 48
	
	sb $t4, 2($t7)
	sb $t3, 3($t7)
	 
	jr	$ra
	
