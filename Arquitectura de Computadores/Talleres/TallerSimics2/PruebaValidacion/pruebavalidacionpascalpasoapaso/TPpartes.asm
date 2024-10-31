section .data
	
	n EQU 5

section .bss triangulo resb 0x300 ;Reservar espacio para el triángulo de Pascal
	triangulo resb 0x300

section .text 
global _start

_start:
	
	lea edi,[triangulo+0x200]
	mov eax,n
	mov [rdi],eax

