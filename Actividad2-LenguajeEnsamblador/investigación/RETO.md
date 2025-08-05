## RET0 5
### Traduce este programa a lenguaje ensamblador

````
int var = 10;
int *punt;
punt = &var;
*punt = 20;
````
````
@10
D=A                  //var=10
@VAR
M=D

@VAR
D=A                 //*punt=&var
@PUNT
M=D

@20
D=A                  // D = 20
@PUNT
A=M                  // A = *punt
M=D                  // *punt = 20

