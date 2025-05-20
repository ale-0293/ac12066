BITS 32

section .data
    mensaje     db "Resultado: "
    mensaje_len equ $ - mensaje

    nl          db 0xA         ; Salto de línea
    buffer      times 6 db 0   ; Para número convertido (hasta 5 dígitos)

section .text
    global _start

_start:
    ; Paso 1: usar registros de 16 bits para la lógica
    mov ax, 100     ; Primer número
    mov bx, 25      ; Segundo número
    sub ax, bx      ; AX = AX - BX
    mov cx, 10      ; Tercer número
    sub ax, cx      ; AX = AX - CX

    ; Paso 2: convertir AX a ASCII
    movzx eax, ax       ; Expandimos AX a EAX
    mov edi, buffer + 5 ; Apuntamos al final del buffer
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

    ; Paso 3: imprimir mensaje "Resultado: "
    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, mensaje_len
    int 0x80

    ; Paso 4: imprimir el número (desde edi, longitud ecx)
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    mov edx, ecx
    add edx, ecx
    sub edx, edi
    add edx, ecx
    mov edx, 5
    int 0x80

    ; Paso 5: imprimir salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, 1
    int 0x80

    ; Salida limpia
    mov eax, 1
    xor ebx, ebx
    int 0x80
