@1      // vamos a r1
D = M   // D tiene la direccion de r1
A = D   // a va a esa direccion
D = M  
@4      // se devuelve a r4
M = D   // se guarda el valor en r4


Luego hay que llenar la región de memoria con un -1
Tenemos que usar un bucle para ir de celda en celda, desde la direccion que esta en R0 hasta que hayamos cubierto el tamaño que esta en R1.

// 1. Preparamos el Puntero (i = R0) y el Contador (j = 0)
@0      // R0 tiene la direccion de inicio
D = M   // D = R0
@3      // R3 como un puntero movil
M = D
@2      // se usa R2 como contador
M = 0   // j = 0

(LOOP)
@2      // i
D = M   
@1      // R1
D = D - M  
@END    
D; JGE



@1   
D = -D
@3      
A = M  
M = D  


@3      
M = M + 1 
@2     
M = M + 1 
@LOOP   
0; JMP  


(END)
@END
0; JMP