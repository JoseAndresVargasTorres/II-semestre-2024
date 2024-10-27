; Triángulo de Pascal en NASM (versión corregida)
; Para sistemas x86_64 Linux

section .data
    n equ 5                  ; Número de niveles del triángulo

section .bss
    triangle resq 100        ; Espacio para 100 números de 64 bits

section .text
    global _start

_start:
    ; Inicializar primer elemento
    mov qword [triangle], 1
    
    ; Verificar si n es 0
    cmp qword n, 0
    je exit

    ; Inicializar registros
    xor rcx, rcx            ; rcx = nivel actual (empezando en 0)
    mov rbx, 0              ; rbx = offset base

next_level:
    inc rcx                 ; Siguiente nivel
    cmp rcx, n              ; Comparar con n
    jge exit               ; Si llegamos a n, terminar
    
    ; Calcular nuevo offset base
    add rbx, rcx           ; Ajustar offset base para este nivel
    
    ; Colocar 1 al inicio del nivel
    mov rdi, rbx
    mov qword [triangle + rdi*8], 1
    
    ; Preparar para calcular elementos internos
    mov rdx, 1             ; rdx = posición actual en el nivel

calc_inner:
    cmp rdx, rcx          ; Comparar posición con nivel
    jge end_level         ; Si llegamos al final, terminar nivel
    
    ; Calcular offset para elementos superiores
    mov rsi, rbx          ; Copiar offset base
    sub rsi, rcx          ; Ajustar para nivel superior
    add rsi, rdx          ; Ajustar para posición actual
    
    ; Calcular nuevo valor
    mov rax, [triangle + rsi*8 - 8]     ; Primer número superior
    add rax, [triangle + rsi*8]         ; Segundo número superior
    mov rdi, rbx
    add rdi, rdx
    mov [triangle + rdi*8], rax         ; Guardar resultado
    
    inc rdx               ; Siguiente posición
    jmp calc_inner

end_level:
    ; Colocar 1 al final del nivel
    mov rdi, rbx
    add rdi, rcx
    mov qword [triangle + rdi*8], 1
    
    inc rbx               ; Preparar offset para siguiente nivel
    jmp next_level

exit:
    mov rax, 60           ; syscall: exit
    xor rdi, rdi          ; status: 0
    syscall
