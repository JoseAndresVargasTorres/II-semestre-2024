section .text
global _start
_start:
   mov ecx, 5              ; Número de filas del triángulo de Pascal
   mov edi, 1              ; Inicializar el valor inicial de cada fila en 1
   mov esi, 0x200          ; Dirección base para almacenar los valores de Pascal
row_start:
   mov eax, 1              ; Empezar cada fila con 1 (primer valor de cada fila)
   mov ebx, 0              ; Índice de columna en cada fila
store_value:
   ; En este punto, EAX contiene el valor actual del triángulo de Pascal
   ; Guardar el valor actual en la dirección de memoria indicada por ESI
   mov [esi], eax          ; Guardar EAX en la dirección actual de ESI
   add esi, 2   
                ; Mover a la siguiente posición de memoria (4 bytes para cada valor)
   ; Calcular el siguiente valor en la fila usando la fórmula (valor actual) * (fila - columna) / (columna + 1)
   cmp ebx, edi            ; Comprobar si hemos alcanzado el final de la fila
   jge next_row            ; Si sí, pasar a la siguiente fila
   ; Calcular el siguiente valor de Pascal
   mov edx, edi            ; EDX = fila actual
   sub edx, ebx            ; EDX = fila - columna
   mul edx                 ; EAX = EAX * (fila - columna)
   add ebx, 1              ; Incrementar el índice de columna
   div ebx                 ; EAX = EAX / (columna actual + 1)
   jmp store_value          ; Repetir para el siguiente valor en la fila
next_row:
   add edi,1                 ; Incrementar el número de fila
   cmp edi, ecx            ; Comprobar si hemos alcanzado el número total de filas
   jl row_start    ; Si no, generar la siguiente fila
exit:
   mov eax, 60             ; syscall: exit
   xor edi, edi            ; código de salida 0
   syscall