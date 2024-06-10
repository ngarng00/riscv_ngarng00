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
	li a1, 18		#TAMAÑO DEL STRING
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
	jal ra, funcionConvert
		
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
	
	
	
#CREAMOS LA SUBRUTNA FUNCIONCONVERT
#PARAMETROS:
	#a0: INPUT, STRING A CONVERTIR
	#a1: OUTPUT, STRING DONDE GUARDAMOS EL STRING CONVERTIDO
	
funcionConvert:
	addi t0, zero, 0	#t0 será el index, lo asignamos a 0
	
loop:	
	lb t1, 0(a0)
	beq t1, zero, exit	#terminamos si no hay mas caracteres
	
	#comprobamos si el caracter esta entre 'a'-'z'
	li t2, 97               
    	li t3, 122
    	blt t1, t2, copy	#si es menor que a, se salta a copy para copiarlo tal cual y volver al bucle
    	bgt t1, t3, copy	#si es mayor que z, se salta a copy para copiarlo tal cual y volver al bucle
    	
    	#si llegamos aqui, estamos seguros que es 'a'-'z'
    	#la convertimos a mayuscula restandole 32, que equivale a su valor en ASCII en mayuscula
	addi t1, t1, -32
	
copy:
	sb t1, 0(a1)            
    	addi a0, a0, 1          
    	addi a1, a1, 1          
    	j loop          
    	
exit:
	sb zero, 0(a1)
    	jr ra
    	