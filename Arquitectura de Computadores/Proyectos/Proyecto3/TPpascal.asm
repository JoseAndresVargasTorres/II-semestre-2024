section .text
global _start
_start:
   mov ecx, 5              ; Número de filas del triángulo de Pascal
   mov edi, 1              ; Inicializar el valor inicial de cada fila en 1
   mov esi, 0x100          ; Dirección base para almacenar los valores de Pascal
generate_triangle:
   mov eax, 1              ; Empezar cada fila con 1 (primer valor de cada fila)
   mov ebx, 0              ; Índice de columna en cada fila
next_value:
   ; En este punto, EAX contiene el valor actual del triángulo de Pascal
   ; Guardar el valor actual en la dirección de memoria indicada por ESI
   mov [esi], eax          ; Guardar EAX en la dirección actual de ESI
   add esi, 4              ; Mover a la siguiente posición de memoria (4 bytes para cada valor)
   ; Calcular el siguiente valor en la fila usando la fórmula (valor actual) * (fila - columna) / (columna + 1)
   cmp ebx, edi            ; Comprobar si hemos alcanzado el final de la fila
   jge next_row            ; Si sí, pasar a la siguiente fila
   ; Calcular el siguiente valor de Pascal
   mov edx, edi            ; EDX = fila actual
   sub edx, ebx            ; EDX = fila - columna
   mul edx                 ; EAX = EAX * (fila - columna)
   add ebx, 1              ; Incrementar el índice de columna
   div ebx                 ; EAX = EAX / (columna actual + 1)
   jmp next_value          ; Repetir para el siguiente valor en la fila
next_row:
   inc edi                 ; Incrementar el número de fila
   cmp edi, ecx            ; Comprobar si hemos alcanzado el número total de filas
   jl generate_triangle    ; Si no, generar la siguiente fila
exit:
   mov eax, 60             ; syscall: exit
   xor edi, edi            ; código de salida 0
   syscall