# ACTIVIDAD 1

### ¿Cuál es el resultado que se obtiene al ejecutar este programa?
Dibuja en cada fotograma un círculo blanco de radio 20 píxeles en la posición actual del mouse (ofGetMouseX(), ofGetMouseY()), haciendo que el círculo siga el cursor en tiempo real.

<video controls src="2025-08-14 09-08-11.mp4" title="Title"></video>

# ACTIVIDAD 2
<video controls src="2025-08-14 09-17-33.mp4" title="Title"></video>

### ¿Qué fue lo que incluimos en el archivo .h?
En el .h se puso la clase ofApp que viene de ofBaseApp, con las funciones que necesita el programa y unas variables privadas para manejar las posiciones de las partículas y su color.
### ¿Cómo funciona la aplicación?
El programa dibuja círculos en las posiciones por donde se mueve el mouse, guardando hasta 100 posiciones. Además, cuando se da clic cambia aleatoriamente el color de todos los círculos.
### ¿Qué hace la función mouseMoved?
Cada vez que mueves el mouse, guarda la posición (x, y) en el vector particles. Si ya hay más de 100 posiciones guardadas, elimina la más antigua para mantener solo las últimas 100.
### ¿Qué hace la función mousePressed?
Cuando presionas un botón del mouse, cambia el color de los círculos a un color aleatorio.
### ¿Qué hace la función setup?
Se ejecuta el programa y define el color inicial de las partículas como blanco.
### ¿Qué hace la función update?
Update sirve para actualizar la lógica o el estado del programa antes de dibujar.
### ¿Qué hace la función draw?
Dibuja un círculo de radio 50 en cada posición guardada en particles, usando el color actual definido en particleColor.

# Actividad 3

### Analiza la aplicación anterior. ¿Qué hace cada función? ¿Qué hace cada línea de código? Realiza un experimento con la aplicación anterior. Modifica alguna parte de su código.
