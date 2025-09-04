19. Analiza el siguiente programa en lenguaje de máquina:
````
    0100000000000000
    1110110000010000
    0000000000010000
    1110001100001000
    0110000000000000
    1111110000010000
    0000000000010011
    1110001100000101
    0000000000010000
    1111110000010000
    0100000000000000
    1110010011010000
    0000000000000100
    1110001100000110
    0000000000010000
    1111110010101000
    1110101010001000
    0000000000000100
    1110101010000111
    0000000000010000
    1111110000010000
    0110000000000000
    1110010011010000
    0000000000000100
    1110001100000011
    0000000000010000
    1111110000100000
    1110111010001000
    0000000000010000
    1111110111001000
    0000000000000100
    1110101010000111
 ````
### ¿Qué hace este programa?
El programa recorre un arreglo de cuatro elementos almacenados en las direcciones de memoria comenzando en RAM[16]. Usa un contador almacenado en RAM[17] para acceder secuencialmente a cada elemento (índices 0 a 3). Para cada elemento, lee su valor y realiza una comparación. Mientras no se presione ninguna tecla (entrada en la dirección KBD), el contador avanza para procesar el siguiente elemento. Si se detecta una tecla, el contador y el proceso se reinician, comenzando nuevamente desde el primer elemento del arreglo.
