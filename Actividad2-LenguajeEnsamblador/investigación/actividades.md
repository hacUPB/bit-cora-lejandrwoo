# ACTIVIDAD 1
### En el capítulo 4 del libro “The Elements of Computing Systems” que puedes encontrar [**aquí**](https://www.nand2tetris.org/_files/ugd/44046b_7ef1c00a714c46768f08c459a6cab45a.pdf), vas a repasar de nuevo cómo se realizan las operaciones de entrada y salida en la plataforma de cómputo que estamos estudiando, es decir, la plataforma Hack y la CPU Hack. También puedes ver [**este**](https://youtu.be/gTOFd80QfBU?si=6FLpT907cx1Q_NDB) video, si quieres, donde te explican el concepto. En la sección 4.2.5. vas a encontrar el concepto de entrada-salida mapeada a memoria o *memory maped* I/O. Analiza lo siguiente:

- ### ¿Qué es la entrada-salida mapeada a memoria?

// Es en donde la memoria RAM se comunica con los dispositivos de entrada y salida como teclado y pantalla, es como decir, escribo un valor en una dirección especial de la RAM y se traduce a una salida como dibujar un pixel en la pantalla.
- ### ¿Cómo se implementa en la plataforma Hack?

// Se implementa a PANTALLA, cada dirección representa 16 pixeles en pantalla y por cada pixel prendido son 16 bits, cubriendo una pantalla de 256 filas y 512 columnas.
Tambien esta el TECLADO con dirección 24576 y el valor de la dirección dice cual tecla es presionada.
- ### Inventa un programa que haga uso de la entrada-salida mapeada a memoria.
- ### Investiga el funcionamiento del programa con el simulador.





# ACTIVIDAD 2
### Vas a revisar de nuevo el reto 20 de la unidad anterior. Asegúrate de entenderlo, simularlo y experimentar con él antes de continuar con el siguiente reto.
````

Este código dibuja una imagen de 32 filas de altura y 48 píxeles de ancho directamente en la memoria de video de Hack. Usa registros temporales y manipulación de direcciones para recorrer la memoria de pantalla eficientemente. Al final, salta a la dirección de retorno.


````

# ACTIVIDAD 3
### Vas a implementar y simular una modificación al reto 20 de la unidad anterior. Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Si no se presiona ninguna tecla, borrarás la imagen.


@SCREEN
D=A
@R0
M=D

(LOOP)

    @KBD
    D=M


    @100
    D=D-A


    @DRAW
    D;JEQ


    @ERASE
    0;JMP

(DRAW)
   
    @R0
    A=M
    M=-1          

   
    @LOOP
    0;JMP

(ERASE)
 
    @R0
    A=M
    M=0

    @LOOP
    0;JMP


# Actividad 4

Ahora realizarás una nueva variación al programa de la actividad anterior. Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Solo si se presiona la letra “e” borrarás la imagen que se muestra en pantalla.

EL CODIGO ESTA EN "code actividad 4.asm"

<video controls src="NAND2Tetris - Opera 2025-08-05 09-08-23.mp4" title="Title"></video>