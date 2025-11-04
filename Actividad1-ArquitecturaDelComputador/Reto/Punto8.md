# Considera el siguiente programa:
    
    ```
    @var1
    D = M
    @var2
    D = D + M
    @var3
    M = D
    ```
    
### ¿Qué hace este programa?
El programa en Hack Assembly suma los valores almacenados en las variables var1 y var2, y guarda el resultado en var3.
Es decir, realiza: var3 = var1 + var2.
### En qué posición de la memoria está var1, var2 y var3? ¿Por qué en esas posiciones?
En Hack, las variables como var1, var2 y var3 se guardan desde la posición 16 en adelante.
Como aparecen en orden, var1 va en la 16, var2 en la 17 y var3 en la 18.
    
