######################################################################
## Fichero: Vectores.asm
## Fecha �ltima modificaci�n: 

## Autores: 
## Asignatura: E.C. 1� grado
## Grupo de Pr�cticas:
## Grupo de Teor�a:
## Pr�ctica: 3
## Ejercicio: 3
######################################################################

.text


main:		
	#Lee la variable N
	lw $a0, N
	
	#Adaptaci�n de N
	addi $a0, $a0, 30
	
	#Inicializa el bucle for
	addi $t0, $0, 0
	
	#Comprobaci�n del bucle
for: 	beq $a0, $t0, done	
	
	#Lectura de A(i)
	lw $a1, A($t0)
	
	#Lectura de B(i)
	lw $a2, B($t0)
	
	#Multiplicaci�n por 4 de B(i)
	#sll $a2, $a2, 2
	add $a2, $a2, $a2
	add $a2, $a2, $a2
	
	#Suma 
	add $a3, $a2, $a1
	
	#Escritura en C(i)
	sw $a3, C($t0)
	
	#Operaci�n del bucle
	addi $t0, $t0, 4
	
	#Salto a la comparaci�n
	j for
	
	#Bucle infinito
done:	j done	



.data # Comienzo de seccion de memoria de datos
A: 2,2,4,6,5,6,7,8,9,10
B: -1,-5,4,10,1,-2,5,10,-10,0
C: .space 40 #.space reserva el espacio determinado en bytes.
N: .word 10
