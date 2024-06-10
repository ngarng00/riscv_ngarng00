	.data
entrada:	.string "Enter a string: "
salida:		.string "\nConverted string: "
input:		.space 100
output:		.space 100

	.global main
	.text
main:
	#IMPRIMIMOS ENTRADA:
	la a0, entrada
	li a7, 4 		#SYSCALL PARA ESCRIBIR
	ecall
	
	#LEEMOS EL INPUT
	la a0, input
	li a1, 100		#TAMAÑO MAX DEL STRING
	li a7, 8		#SYSCALL PARA LEER
	ecall
	
	#ASIGNAMOS LOS ATRIBUTOS
	la a0, input
	la a1, output
	#LLAMAMOS A LA SUBRUTINA
	jal funcionInvert
	
	#IMPRIMIMOS SALIDA
	la a0, salida
	li a7, 4
	ecall
	
	#IMPRIMIMOS OUTPUT
	la a0, output
	li a7, 4
	ecall
	
	#TERMINAMOS EL PROGRAMA
	li a7, 10
	ecall
	

#CREAMOS LA SUBRUTINA FUNCIONINVERT
#PARAMETROS:
	#a0: INPUT, STRING A CONVERTIR
	#a1: OUTPUT, STRING DONDE GUARDAMOS EL STRING INVERTIDO
	
funcionInvert:
	addi t0, zero, 0        # Initialize source index to 0
    la t1, input           # Load address of buffer
    la t2, output          # Load address of inverted
    # Calculate the length of the source string
find_length:
    lb t3, 0(t1)
    beq t3, zero, length_found
    addi t1, t1, 1
    addi t0, t0, 1
    j find_length

length_found:
    addi t1, t1, -1         # t1 points to the last character
    addi t0, t0, -1         # t0 is now the index of the last character

invert_loop:
    blt t0, zero, end_invert # If t0 < 0, we're done
    lb t3, 0(t1)            # Load byte from source string
    sb t3, 0(t2)            # Store byte in target string
    addi t1, t1, -1         # Move to previous character in source
    addi t2, t2, 1          # Move to next character in target
    addi t0, t0, -1         # Decrement the index
    j invert_loop

end_invert:
    sb zero, 0(t2)          # Null-terminate the target string
    jr ra                   # Return from subroutine
