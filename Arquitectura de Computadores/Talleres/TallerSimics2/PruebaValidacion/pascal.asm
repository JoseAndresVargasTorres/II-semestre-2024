
BITS 32                 ; Cambiado a 32 bits
default rel
section .data
    n EQU 5
section .bss
    triangulo resb 0x300
section .text
global _start
_start:
    ; Modificamos para usar registros de 32 bits
    lea edi, [triangulo + 0x200]
    mov eax, n
    mov [edi], eax
    xor edi, edi
    jmp inicio
inicio:
    lea edi, [triangulo + 0x300]
    mov ebx, 1
    mov [edi], ebx
    add edi, 4          ; Cambiado de 8 a 4 bytes
    cmp eax, 0
    je finalizar
    mov ecx, 1
    mov edx, edi
    mov [edi], ebx
    add edi, 4          ; Cambiado de 8 a 4 bytes
    mov [edi], ebx
    add edi, 4          ; Cambiado de 8 a 4 bytes
    jmp calcular_nivel
calcular_nivel:
    add ecx, 1
    cmp ecx, eax
    jg finalizar
    mov esi, edx        ; Cambiado r8 a esi
    mov [edi], ebx
    add edi, 4          ; Cambiado de 8 a 4 bytes
    mov edi, ecx        ; Cambiado r9 a edi
    sub edi, 1
    jmp calcular_fila
calcular_fila:
    mov ebp, [esi]      ; Cambiado r10 a ebp
    add esi, 4          ; Cambiado de 8 a 4 bytes
    mov eax, [esi]      ; Cambiado r11 a eax
    mov edx, ebp        ; Cambiado r12 a edx
    add edx, eax
    mov [edi], edx
    add edi, 4          ; Cambiado de 8 a 4 bytes
    sub edi, 1
    cmp edi, 0
    jne calcular_fila
    mov [edi], ebx
    add edi, 4          ; Cambiado de 8 a 4 bytes
    jmp siguiente_nivel
siguiente_nivel:
    mov esi, ecx        ; Cambiado r8 a esi
    shl esi, 2          ; Cambiado de 3 a 2 (multiplicar por 4 en lugar de 8)
    add edx, esi
    jmp calcular_nivel
finalizar:
    mov eax, 1          ; syscall exit en 32 bits
    xor ebx, ebx        ; código de retorno 0
    int 0x80            ; interrupción del sistema en 32 bits
