# SESIÓN 2

## ¿Qué hace el patrón Observer en este caso?

El patrón Observer sirve para que cuando se presione una tecla, todas las partículas reciban el mismo mensaje sin tener que llamarlas una por una. Así, si el programa dice “atraer”, todas las partículas cambian su estado al mismo tiempo.

## ¿Qué hace el patrón Factory en este caso?

El patrón Factory se usa para crear partículas de diferentes tipos. Por ejemplo, unas se hacen estrellas, otras planetas o estrellas fugaces. Así no tengo que escribir el mismo código cada vez que quiero un tipo distinto de partícula.

## ¿Qué hace el patrón State en este caso?

El patrón State hace que cada partícula pueda cambiar de comportamiento según el estado en el que esté. Por ejemplo, en estado normal se mueven libremente, en atraer van hacia el mouse, en repeler se alejan y en stop se quedan quietas.

