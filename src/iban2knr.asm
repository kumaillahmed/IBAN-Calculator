	.data
	.globl iban2knr

	.text
# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
iban2knr:
	# TODO  
	
	li $t0 8		# number of iterations for BLZ
	li $t1 10		# number of iterations for KNR
	addiu $a0 $a0 4		#increases a0 to start from BLZ

	li $t5 0		#t5 is our counter
Loop_BLZ:
	lb $t2, ($a0)		#load contents of a0 to t2
	sb $t2, ($a1)		#loads one BLZ number from t2 to a1 
	addiu $a1, $a1, 1	#increases a1 position by 1
	addiu $a0, $a0, 1	#increases a0 position by 1 for the next BLZ number
	addi $t5, $t5, 1	#increases t5 by 1
	blt $t5, $t0, Loop_BLZ	#if t5 < t0 (8), move to Loop_BLZ

	li $t6 0		#t6 is our counter
Loop_KNR:
	lb $t3, ($a0)		#load contents of a0 to t3
	sb $t3, ($a2)		#loads one KNR number from t3 to a2
	addiu $a2, $a2, 1	#increases a2 position by 1
	addiu $a0, $a0, 1	#increases a0 position by 1 for the next KNR number
	addi $t6, $t6, 1	#increases t6 by 1
	blt $t6, $t1, Loop_KNR	#if t6 < t1 (10), move to LOOP_KNR
	 
	jr	$ra
