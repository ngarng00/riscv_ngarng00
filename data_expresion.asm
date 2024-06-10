	.data
n:	.byte -5, 2, 30, 5
f:	.word 0
		
	.global main 
	.text
main:
	#READ VALUES
	la t0, n
	lb t2, 0(t0)
	lb t3, 1(t0)
	lb t4, 2(t0)
	lb t5, 3(t0)
	
	la t1, f
	lw t6, 0(t1)	
	#FUNCTION
	add t2, t2, t3
	add t2, t2, t4
	addi t5, t5, -3
	sub t6, t2, t5
	
	
	
	
	li a7, 10
	ecall