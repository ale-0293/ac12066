# Generalidades del Proyecto
Universidad de El Salvador
Facultad Multidisciplinaria de Occidente
Departamento de Ingeniería y Arquitectura
Ingeniería en Desarrollo de Software

Estudiante: Martín Alejandro Amaya Castro 
Carné: AC12066

Asignatura: Diseño y Estructura de Computadoras DEC135 GT01

Docente tutor: Ing. Erick Vladimir Guirola Lemus
Coordinador de cátedra: MEd. Ing. Luis Alberto Herrera Mejía

Asignación: Portafolio

# Portafolio: Programas en Ensamblador x86

Este repositorio contiene tres programas escritos en lenguaje ensamblador x86. Cada uno de ellos resuelve un problema aritmético simple (resta, multiplicación y división) utilizando diferentes tamaños de registros: 16 bits, 8 bits y 32 bits. El objetivo es ilustrar el uso de distintos registros en operaciones matemáticas básicas.

> Valor agregado: También se ha utilizado la conversión a formato ASCII para mostrar los resultados por pantalla.

Todos los programas utilizan llamadas al sistema (`int 0x80`) para realizar la salida estándar en consola bajo sistemas Linux en modo protegido (32 bits).

---

## Ejercicio 1: Resta de tres enteros (registros de 16 bits)

### Descripción:
Programa que resta tres números enteros usando únicamente registros de 16 bits (`AX`, `BX`, `CX`), respetando la restricción de no utilizar registros de mayor tamaño en la operación aritmética principal.

### Lógica:
1. Se cargan tres valores enteros en registros AX, BX y CX.
2. Se realiza la operación: `AX = AX - BX - CX`.
3. Luego, se expande el resultado a 32 bits (`movzx eax, ax`) para convertirlo en cadena de caracteres.
4. Finalmente, se imprime en consola utilizando `int 0x80`.

---

## Ejercicio 2: Multiplicación de dos números enteros (registros de 8 bits)

### Descripción:
Programa que multiplica dos números enteros utilizando registros de 8 bits (`AL` y `BL`). El resultado se almacena en `AX`, ya que una multiplicación de 8 bits puede dar un resultado de hasta 16 bits.

### Lógica:
1. Se cargan dos valores enteros en `AL` y `BL`.
2. Se realiza la multiplicación: `AL * BL`, resultado alojado en `AX`.
3. Se mueve el contenido de `AX` a `EAX` para convertirlo a su representación ASCII.
4. Se imprime el resultado por pantalla.

---

## Ejercicio 3: División de dos números enteros (registros de 32 bits)

### Descripción:
Este ejercicio realiza la división entre dos enteros utilizando directamente registros de 32 bits (`EAX`, `EBX`, `EDX`). El resultado de la división se convierte a ASCII y se muestra en consola.

### Lógica:
1. Se inicializa el dividendo en `EAX` y el divisor en `EBX`.
2. Se limpia `EDX` (para evitar errores) y se ejecuta la instrucción `div EBX`.
3. El cociente queda en `EAX`, que luego se convierte a ASCII mediante un bucle de división por 10.
4. Finalmente, se imprime el resultado junto con un mensaje y un salto de línea.

---

## Requisitos

- Linux (cualquier distro o sistema operativo basado en Linux)
- GNU Ninutils (sudo apt install nasm binutils)
- NASM (Netwide Assembler)
- `ld` (GNU Linker)

---

## Instrucciones para realizar compilación y ejecución

```bash
nasm -f elf32 programa.asm -o programa.o
ld -m elf_i386 programa.o -o programa
./programa
```

### Compilación y ejecución: Ejercicio 1
```bash
nasm -f elf32 resta.asm -o resta.o
ld -m elf_i386 resta.o -o resta
./resta
```

Impresión en pantalla esperado:
Resultado: 65

### Compilación y ejecución: Ejercicio 2
```bash
nasm -f elf32 multiplicacion.asm -o multiplicacion.o
ld -m elf_i386 multiplicacion.o -o multiplicacion
./multiplicacion
```

Impresión en pantalla esperado:
Resultado: 60

### Compilación y ejecución: Ejercicio 3
```bash
nasm -f elf32 division.asm -o division.o
ld -m elf_i386 division.o -o division
./division
```

Impresión en pantalla esperado:
Resultado: 25