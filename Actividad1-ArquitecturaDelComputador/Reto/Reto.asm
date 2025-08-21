//Carga en D el valor 1978.
@1978
D=A

//Guarda en la posición 100 de la RAM el número 69.
@69
D=A
@100
M=D 

//Guarda en la posición 200 de la RAM el contenido de la posición 24 de la RAM
@24
D=M
@200
M=D 

//Lee lo que hay en la posición 100 de la RAM, resta 15 y guarda el resultado en la posición 100 de la RAM.
@100
D=M                        //D=RAM[100]
@15
D=D-A                       //D=D-15 
@100 
M=D 

//Suma el contenido de la posición 0 de la RAM, el contenido de la posición 1 de la RAM y con la constante 69. Guarda el resultado en la posición 2 de la RAM.
@0
D=M                       //D=RAN[0]
@1
D=D+M                    //D=RAM[0]+RAM[1]
@69
D=D+A                     //D=RAM[0]+RAM[1]+69
@2
M=D                       //RAM[2]

//Si el valor almacenado en D es igual a 0 salta a la posición 100 de la ROM.
@100
D;JEQ

//Si el valor almacenado en la posición 100 de la RAM es menor a 100 salta a la posición 20 de la ROM.
@100
D=M                         // D = RAM[100]
@100
D=D-A                       // D = RAM[100] - 100
@20
D;JLT                     // Si RAM[100] < 100, salta a ROM[20]

