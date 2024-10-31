section .text
global _start

_start:
    mov eax, 5          ; n = tamaño del triángulo
    mov ebx, 1          ; primer valor
    mov ecx, 0x200      ; dirección base
    mov [ecx], ebx    ; guardar primer número
    add ecx, 4
    cmp eax, 0
    je exit
    mov edi, 1         ; edi = fila actual (comienza en 1 porque ya empezó)
    jmp start_row

start_row:
    mov [ecx], ebx      ; guardar primer valor de la fila (siempre 1)
    add ecx, 4
    mov edx, 0          ; edx = columna actual
    mov esi, ebx        ; esi = valor anterior
    jmp next_row_value

next_row_value:

    ; Verificar si hemos llegado al final de la fila
    cmp edx, edi        ; comparar columna con fila
    jg end_row         ; si columna >= fila, terminar fila

    ; Calcular: valor = valor_anterior * (fila-columna) / (columna+1)
    mov ebx, esi        ; ebx = valor anterior
    
    ; Calcular (fila-columna)
    mov esi, edi        ; esi = fila
    sub esi, edx        ; esi = fila - columna
    
    ; Multiplicar valor_anterior * (fila-columna)
    mul ebx, esi       ; ebx = valor_anterior * (fila-columna)
    
    ; Dividir por (columna+1)
    mov esi, edx        ; esi = columna
    inc esi             ; esi = columna + 1
    
    ; División
    mov eax, ebx        ; preparar para división
    cdq                 ; extender signo a EDX:EAX
    idiv esi            ; eax = ebx / esi
    
    ; Guardar resultado
    mov ebx, eax        ; guardar resultado en ebx
    mov [ecx], ebx      ; guardar en memoria
    mov esi, ebx        ; guardar valor anterior para siguiente iteración
    
    ; Preparar para siguiente valor
    add ecx, 4          ; avanzar puntero de memoria
    inc edx             ; incrementar columna
    jmp next_row_value

end_row:
    inc edi             ; incrementar fila
    mov ebx, 1          ; resetear primer valor
    cmp edi, eax          ; comparar con n
    jl start_row        ; si no hemos llegado a n, siguiente fila
    jmp exit

exit:
    ; Aquí tu código de salida