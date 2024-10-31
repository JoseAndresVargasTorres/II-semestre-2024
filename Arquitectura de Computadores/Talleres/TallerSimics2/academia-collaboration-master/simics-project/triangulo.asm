section .data
    n EQU 5
    fmt: db "%d ", 10, 0  ; Formato para debug (opcional)

section .bss
    triangle: resd 100    ; Reservamos espacio para el triángulo (ajusta según necesites)

section .text
global _start

_start:
    ; Inicializar registros y primera posición
    mov dword [triangle], 1   ; Primer 1 del triángulo
    mov ecx, 0               ; Contador de nivel actual (equivalente a R5)
    mov ebx, 0               ; Contador de posición en nivel (equivalente a R4)
    
    ; Cargar n en un registro y verificar si es 0
    mov eax, [n]            ; Cargar el valor de n en eax
    test eax, eax           ; Verificar si n es 0
    je exit                 ; Si n es 0, salir

next_level:
    inc ecx                     ; Incrementar nivel
    cmp ecx, dword [n]         ; Comparar con n
    jg exit                    ; Si superamos n, terminamos
    xor ebx, ebx               ; Reiniciar posición en nivel
    
level_loop:
    ; Calcular offset en el array
    push ecx                   ; Guardar ecx
    mov eax, ecx               ; Nivel actual en eax
    mul eax                    ; eax = nivel * nivel
    add eax, ebx               ; Añadir posición actual
    mov edi, eax              ; Guardar offset en edi
    pop ecx                    ; Recuperar ecx
    
    ; Verificar si es primera o última posición
    cmp ebx, 0
    je first_pos
    cmp ebx, ecx
    je last_pos
    
    ; Calcular valor intermedio
    push ecx
    mov eax, ecx              ; Nivel anterior
    dec eax
    mul eax                   ; eax = (nivel-1) * (nivel-1)
    add eax, ebx              ; Añadir posición actual
    dec eax                   ; Posición izquierda en nivel anterior
    
    ; Cargar valores superiores y sumarlos
    mov edx, dword [triangle + eax * 4]     ; Valor izquierdo
    mov eax, dword [triangle + eax * 4 + 4] ; Valor derecho
    add eax, edx                            ; Sumar valores
    
    ; Guardar resultado
    mov [triangle + edi * 4], eax
    pop ecx
    
    inc ebx
    jmp check_pos

first_pos:
    mov dword [triangle + edi * 4], 1
    inc ebx
    jmp check_pos

last_pos:
    mov dword [triangle + edi * 4], 1
    jmp next_level

check_pos:
    cmp ebx, ecx
    jle level_loop
    jmp next_level

exit:
    mov eax, 1       ; sys_exit
    xor ebx, ebx     ; código de retorno 0
    int 0x80         ; llamada al sistema
