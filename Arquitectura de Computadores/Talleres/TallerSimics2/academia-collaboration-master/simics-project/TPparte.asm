section .data
    n EQU 5           ; Número de filas del triángulo

section .bss
    triangulo resb 0x300    ; Reservar 768 bytes para el triángulo

section .text
global _start

_start:
    ; Inicializar el primer elemento del triángulo
    lea edi, [0x200]  ; Cargar dirección base + offset
    mov eax, 5
    mov [edi],eax 
    mov eax, 1
    add edi,4
    lea                  ; Primer elemento es 1
    mov [edi], eax             ; Guardar en memoria

    ; Inicializar contadores
    mov ecx, 1                  ; Contador de filas, empezamos en 1 ya que la primera fila ya está
    
