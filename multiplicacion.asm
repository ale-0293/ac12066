BITS 32

section .data
    mensaje     db "Resultado: "
    mensaje_len equ $ - mensaje

    nl          db 0xA             ; Salto de línea
    buffer      times 4 db 0       ; Espacio para 3 dígitos y nulo

section .text
    global _start

_start:
    ; Paso 1: multiplicación en 8 bits
    mov al, 12          ; Primer número (8 bits)
    mov bl, 5           ; Segundo número (8 bits)
    mul bl              ; AX = AL * BL (resultado en AX)

    ; Paso 2: conversión a cadena ASCII
    movzx eax, ax       ; Expandimos AX a EAX para dividir seguro
    mov edi, buffer + 3
    mov ecx, 0
    mov ebx, 10

convert_loop:
    xor edx, edx
    div ebx
    add dl, '0'
    dec edi
    mov [edi], dl
    inc ecx
    test eax, eax
    jnz convert_loop

    ; Paso 3: imprimir "Resultado: "
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, mensaje_len
    int 0x80

    ; Paso 4: imprimir número (desde edi)
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, ecx
    add edx, ecx
    sub edx, edi
    add edx, ecx
    mov edx, 3
    int 0x80

    ; Paso 5: imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, 1
    int 0x80

    ; Salida del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
