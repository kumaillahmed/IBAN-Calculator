	.data
	.globl modulo_str
	.text

# --- modulo_str ---
# Arguments:
# a0: start address of the buffer
# a1: number of bytes in the buffer
# a2: divisor
# Return:
# v0: the decimal number (encoded using ASCII digits '0' to '9') in the buffer [$a0 to $a0 + $a1 - 1] modulo $a2 
modulo_str:
	# TODO

	li $t0 0				#loads 0 into t0(last number)
	li $t1 0				#loads 0 into t1(counter)
	
Loop_Horner_Method:
	lb $t2, ($a0)				#loads value of a0 to t2
	subu $t2 $t2 48				#changes t2 from ASCII to Decimal Digit
	addiu $a0 $a0 1				#increases a0 position by 1
	mul $t3 $t0 10				#multiplies t0 by 10 and stores in t3
	rem $t3 $t3 $a2				#stores remainder of t2/a2 in t3
	addu $t2, $t3, $t2			#adds t3 to t2(current number) and stores in t2
	rem $t0 $t2 $a2				#stores remainder of t2/a2 in t0
	addiu $t1 $t1 1				#increases t1 counter by 1
	blt $t1, $a1, Loop_Horner_Method	#if t1 < a1, move to Loop_Horner_Method
	
	move $v0 $t0				#loads value of t0 to v0
	

	jr	$ra
