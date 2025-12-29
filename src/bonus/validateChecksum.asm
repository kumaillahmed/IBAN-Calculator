	.data
	.globl validate_checksum
	.text


# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# v0 : the checksum of the IBAN
validate_checksum:
	# TODO
	
	
	li $t0 0				#loads 0 into t0(last number)
	li $t1 0				#loads 0 into t1(counter)
	
	la $t2, ($a0)				#a0 address to t2
	addiu $t2 $t2 2				#t2 inc by 2
	
CheckDigits_Extract:
	lb $t3, ($t2)				#loads first Check Digit from t2 to t3
	addiu $t2 $t2 1				#increases t2 position by 1
	
	lb $t4, ($t2)				#loads second Check Digit from t2 to t4
	addiu $t2 $t2 1				#increases t2 position by 1
	
	
Loop_Horner_Method:
	lb $t5, ($t2)				#loads value of t2 to t5
	subu $t5 $t5 48				#changes t5 from ASCII to Decimal Digit
	addiu $t2 $t2 1				#increases t2 position by 1
	mul $t6 $t0 10				#multiplies t0 by 10 and stores in t6
	rem $t6 $t6 97				#stores remainder of t6/97 in t6
	addu $t5, $t6, $t5			#adds t6 to t5(current number) and stores in t5
	rem $t0 $t5 97				#stores remainder of t5/97 in t0
	addiu $t1 $t1 1				#increases t1 counter by 1
	blt $t1, 18, Loop_Horner_Method		#if t1 < 18, move to Loop_Horner_Method
	
For_D1_in_1314:	
	li $t5, 1				#loads 1 to t5
	mul $t6 $t0 10				#multiplies t0 by 10 and stores in t6
	rem $t6 $t6 97				#stores remainder of t6/97 in t6
	addu $t5, $t6, $t5			#adds t6 to t5(current number) and stores in t5
	rem $t0 $t5 97				#stores remainder of t5/97 in t0

For_D3_in_1314:
	li $t5, 3				#loads 3 to t5
	mul $t6 $t0 10				#multiplies t0 by 10 and stores in t6
	rem $t6 $t6 97				#stores remainder of t6/97 in t6
	addu $t5, $t6, $t5			#adds t6 to t5(current number) and stores in t5
	rem $t0 $t5 97				#stores remainder of t5/97 in t0

For_E1_in_1314:	
	li $t5, 1				#loads 1 to t5
	mul $t6 $t0 10				#multiplies t0 by 10 and stores in t6
	rem $t6 $t6 97				#stores remainder of t6/97 in t6
	addu $t5, $t6, $t5			#adds t6 to t5(current number) and stores in t5
	rem $t0 $t5 97				#stores remainder of t5/97 in t0
	
For_E4_in_1314:
	li $t5, 4				#loads 4 to t5
	mul $t6 $t0 10				#multiplies t0 by 10 and stores in t6
	rem $t6 $t6 97				#stores remainder of t6/97 in t6
	addu $t5, $t6, $t5			#adds t6 to t5(current number) and stores in t5
	rem $t0 $t5 97				#stores remainder of t5/97 in t0
	
For_First_Check_Digit:
	move $t5, $t3				#loads value of t3 to t5
	subu $t5 $t5 48				#changes t5 from ASCII to Decimal Digit
	mul $t6 $t0 10				#multiplies t0 by 10 and stores in t6
	rem $t6 $t6 97				#stores remainder of t6/97 in t6
	addu $t5, $t6, $t5			#adds t6 to t5(current number) and stores in t5
	rem $t0 $t5 97				#stores remainder of t5/97 in t0	
	
For_Second_Check_Digit:	
	move $t5, $t4				#loads value of t4 to t5
	subu $t5 $t5 48				#changes t5 from ASCII to Decimal Digit
	mul $t6 $t0 10				#multiplies t0 by 10 and stores in t6
	rem $t6 $t6 97				#stores remainder of t6/97 in t6
	addu $t5, $t6, $t5			#adds t6 to t5(current number) and stores in t5
	rem $t0 $t5 97				#stores remainder of t5/97 in t0
	
	
	move $v0 $t0				#loads value of t0 to v0
	
	
	
	
	
	
	
	
	jr	$ra
