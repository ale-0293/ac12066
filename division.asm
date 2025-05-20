BITS 32

section .data
    mensaje     db "Resultado: "
    mensaje_len equ $ - mensaje
    nl          db 0xA             ; Salto de línea

section .bss
    buffer      resb 11            ; Hasta 10 dígitos

section .text
    global _start

_start:
    ; División: 100 / 4 = 25
    mov eax, 100
    xor edx, edx
    mov ebx, 4
    div ebx

    ; Convertir resultado a ASCII
    mov esi, buffer + 10
    mov byte [esi], 0
    mov edi, eax
    mov eax, edi
    mov ebx, 10

convert_loop:
    xor edx, edx
    div ebx
    add dl, '0'
    dec esi
    mov [esi], dl
    test eax, eax
    jnz convert_loop

    ; Mostrar "Resultado: "
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, mensaje_len
    int 0x80

    ; Mostrar número (usando `esi` como puntero y `buffer + 10 - esi` como longitud)
    mov eax, 4
    mov ebx, 1
    mov ecx, esi
    mov edx, buffer + 10
    sub edx, ecx
    int 0x80

    ; Salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, 1
    int 0x80

    ; Salida
    mov eax, 1
    xor ebx, ebx
    int 0x80
