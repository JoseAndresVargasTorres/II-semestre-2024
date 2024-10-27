ORG 0x0                 ; add to offsets

section .data
	n EQU 5

section .bss
    triangulo resb 0x300 ; Reservamos espacio para el triángulo de Pascal (768 bytes)

section .text

global _start

_start:
	lea rdi, [triangulo + 0x200]  ; rdi apunta a la ubicación donde se almacenarán n
    	mov rax, n                    ; movemos n a rax
    	mov [rdi], rax                ; guardamos n en la pila
	XOR rdi, rdi
    	jmp inicio                    ; saltamos a la inicialización del triángulo

inicio:
	lea rdi, [triangulo + 0x300]  ; rdi apunta al inicio del nivel 0
    	mov rbx, 1                    ; valor 1 para los extremos de cada nivel
    	mov [rdi], rbx                ; almacenamos 1 al inicio del nivel 0
	add rdi, 8

	cmp rax, 0                    ; comparamos n con 0
    	je finalizar                  ; si n == 0, terminamos

	mov rcx, 1		      ; Contador de nivel inicial (nivel 1)
	mov rdx, rdi		      ; Apuntar al inicio del nivel anterior (ptr_anterior)
	mov [rdi], rbx		      ; Almacenar 1 en la memoria (inicio nivel 1)
	add rdi, 8
	mov [rdi], rbx		      ; Almacenar 1 en la memoria (fin nivel 1)
	add rdi, 8
	
	jmp calcular_nivel            ; saltamos al bucle principal
	

calcular_nivel:
	add rcx, 1		      ; Incrementar contador de nivel
	cmp rcx, rax		      ; Comparar contador de nivel con n
	jg finalizar		      ; Si contador_nivel > n, terminar
	
	mov r8, rdx		      ; Copiar ptr_anterior en R8
	mov [rdi], rbx		      ; Colocar 1 al inicio del nivel actual
	add rdi, 8

	mov r9, rcx		      ; R9 será el contador para el nivel actual
	sub r9, 1		      ; Ajustar R9 para las sumas del nivel actual
	
	jmp calcular_fila

calcular_fila:
	mov r10, [r8]		     ; Leer primer operando desde ptr_anterior
	add r8, 8
	mov r11, [r8]		     ; Leer segundo operando desde ptr_anterior
	
	mov r12, r10
	add r12, r11		     ; Sumar los operandos

	mov [rdi], r12  	     ; Almacenar la suma en ptr_actual
	add rdi, 8

	sub r9, 1		     ; Restar 1 de R7
	cmp r9, 0
	jne calcular_fila	     ; Si R7 != 0, repetir calcular_fila

	mov [rdi], rbx		     ; Colocar 1 al final del nivel actual
	add rdi, 8

	jmp siguiente_nivel	     ; Saltar para preparar el siguiente nivel
	

siguiente_nivel:
	mov r8, rcx
	shl r8, 3		     ; (equivalente a multiplicar por 4)
	add rdx, r8		     ; Sumar el resultado al puntero RDX

	jmp calcular_nivel           ; Repetir para el siguiente nivel

finalizar:
	MOV rax, 1                 ; Syscall para salir
    	XOR rbx, rbx               ; Código de salida 0
    	INT 0x80
