section .data
    n EQU 5                   ; Number of rows to generate

section .bss
    triangle resb 768         ; Reserve 768 bytes (0x300) for Pascal's triangle

section .text
global _start

_start:
    ; Initialize first two rows
    mov rdi, triangle        ; Base address of triangle
    mov rbx, 1              ; Value 1 for triangle edges
    mov [rdi], rbx          ; Store 1 at start of row 0
    add rdi, 8
    
    mov rcx, 1              ; Current level counter (starting at 1)
    mov rdx, triangle       ; Pointer to previous row
    mov [rdi], rbx          ; Store 1 at start of row 1
    add rdi, 8
    mov [rdi], rbx          ; Store 1 at end of row 1
    add rdi, 8
    
    ; Main triangle calculation loop
calculate_level:
    inc rcx                 ; Increment level counter
    cmp rcx, n              ; Compare with target number of rows
    jg exit                 ; If done, exit
    
    mov r8, rdx            ; Copy previous row pointer
    mov [rdi], rbx         ; Place 1 at start of current row
    add rdi, 8
    mov r9, rcx            ; Counter for current row calculations
    dec r9                 ; Adjust for number of calculations needed
    
calculate_row:
    mov r10, [r8]          ; Load first number from previous row
    add r8, 8
    mov r11, [r8]          ; Load second number from previous row
    
    mov r12, r10
    add r12, r11           ; Add the two numbers
    mov [rdi], r12         ; Store result in current row
    add rdi, 8
    dec r9                 ; Decrement counter
    test r9, r9
    jnz calculate_row      ; If not done with row, continue
    
    mov [rdi], rbx         ; Place 1 at end of current row
    add rdi, 8
    
    ; Prepare for next row
    mov r8, rcx
    shl r8, 3              ; Multiply by 8 (bytes per number)
    add rdx, r8            ; Update previous row pointer
    jmp calculate_level

exit:
    mov rax, 60            ; sys_exit
    xor rdi, rdi           ; status = 0
    syscall
