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

````
#pragma once
````

Evita que el archivo se incluya varias veces en la compilación.

````
#include "ofMain.h"
````
Carga la librería principal de OpenFrameworks con las clases y funciones base.

````
class ofApp : public ofBaseApp { ... };
````
Declara la clase ofApp, que hereda de ofBaseApp, permitiendo usar métodos como setup, update, draw y eventos de mouse/teclado.

### Dentro de la clase:

- vector<ofVec2f> particles;  -> lista de posiciones (x,y) de las partículas.

- ofColor particleColor; -> define el color de las partículas.

### Archivo ofApp.cpp
````
#include "ofApp.h"
````
Incluye la definición de la clase.

- setup()
````
void ofApp::setup() {
    ofBackground(0);
    particleColor = ofColor::white;
}
````
Configura el fondo en negro y el color inicial de las partículas en blanco. Solo corre una vez al inicio.

- update()
````
void ofApp::update() { }
````
No contiene código; normalmente se usaría para cálculos o animaciones.

- draw()
````
void ofApp::draw() {
    for (auto &pos : particles) {
        ofSetColor(particleColor);
        ofDrawCircle(pos.x, pos.y, 50);
    }
}
````
Dibuja cada partícula recorriendo el vector. Cada posición genera un círculo con radio 50.

- mouseMoved()
````
void ofApp::mouseMoved(int x, int y) {
    particles.push_back(ofVec2f(x, y));
    if (particles.size() > 100) {
        particles.erase(particles.begin());
    }
}
````
Agrega la posición del mouse al vector. Si supera 100, elimina la más vieja.

- mousePressed()
````
void ofApp::mousePressed(int x, int y, int button) {
    particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}
````
Al hacer clic, cambia el color de las partículas a uno generado aleatoriamente.
# Actividad 4
Trabajo Independiente ( VIDEOS )
# Actividad 5
En la unidad anterior introdujimos el concepto de puntero. Ahora vamos a profundizar en este concepto de manera práctica.

El siguiente ejemplo se supone (en la actividad que sigue vas a corregir un error) que te permite seleccionar una espera y moverla con el mouse.

### - ¿Cuál es la definición de un puntero?
Un puntero es una variable especial que, en vez de guardar un valor como un número o un texto, contiene la dirección en memoria donde está guardado ese dato u objeto. De esta manera, el puntero funciona como un “enlace” que nos permite acceder o modificar el contenido al que apunta. En C++ se declara usando el símbolo *.
### - ¿Dónde está el puntero?
los punteros están declarados dentro de la clase ofApp:
````
vector<Sphere*> spheres;
Sphere* selectedSphere;
````

spheres corresponde a un contenedor (vector) que guarda direcciones hacia objetos del tipo Sphere.

selectedSphere es un puntero que hace referencia a una esfera específica.
### - ¿Cómo se inicializa el puntero?
Se hace en el método setup():
````
spheres.push_back(new Sphere(x, y, radius));
````

Aquí se genera un nuevo objeto Sphere en memoria dinámica mediante new, y su dirección se inserta en el vector spheres.

También esta asignación:
````
selectedSphere = nullptr;
````

Con esto se indica que, al inicio, el puntero no está vinculado a ningún objeto.
### - ¿Para qué se está usando el puntero?
- El vector spheres almacena las ubicaciones de todas las esferas creadas durante la ejecución, lo que permite administrarlas sin necesidad de duplicar cada una.

- El puntero selectedSphere sirve para señalar la esfera que el usuario selecciona, de modo que sea posible modificar sus propiedades o moverla con el mouse.
### - ¿Qué es exactamente lo que está almacenado en el puntero?
Un puntero almacena la dirección en memoria de un objeto, no el objeto mismo. Esa dirección permite acceder y trabajar con él de forma indirecta.


# Actividad 6
- El código anterior tiene un problema. ¿Puedes identificar cuál es? ¿Cómo lo solucionarías? Recuerda que deberías poder seleccionar una esfera y moverla con el mouse.

/ Lo que pasa es que el programa no sabe “olvidar” la esfera que ya seleccioné. Como no se libera correctamente, me obliga a buscar otra más grande para que la cambie. El error está en cómo se maneja la lista de esferas y en que el vector de selección siempre mantiene guardada la última referencia.

# Actividad 7
- Ahora te voy a proponer que reflexiones profundamente sobre el manejo de la memoria en un programa. Se trata de un experimento en el que tienes que analizar por qué está funcionando mal.



# Actividad 8
Construye un experimento (un programa) en el que puedas crear y dibujar objetos que se almacenan:

- En el `heap`.
- En el `stack`.
- En memoria global.



### Nota
sí puedes usar el `stack,`pero recuerda que los objetos solo dudarán en el `stack` el tiempo que dure la función que los creó. ¿Hay alguna función en el programa que dure durante toda la ejecución del programa?

</aside>

- ¿Cuándo debo crear objetos en el `heap` y cuándo en memoria global?

Heap
La memoria dinámica se gestiona con new para crear y delete para liberar. Se utiliza principalmente cuando no sabemos cuántos objetos se necesitarán en tiempo de ejecución o cuando deben existir incluso después de que termine una función. Ejemplos comunes son listas de partículas, enemigos generados en un juego o estructuras que cambian de tamaño.

Pros: Gran adaptabilidad y control sobre la vida de los objetos.

Contras: Riesgo de fugas de memoria si no se liberan correctamente.

Global
Estas variables se definen fuera de cualquier clase o función. Permanecen activas durante toda la ejecución del programa y pueden accederse desde cualquier lugar del código. Resultan prácticas para datos que deben mantenerse únicos y constantes, como configuraciones generales o un recurso central como la cámara.

Pros: Disponibles en todo momento.

Contras: Pueden provocar dependencias fuertes entre módulos y hacer más difícil la organización del código.

# Actividad 9
¿Qué sucede cuando presionas la tecla “f”?
Analiza detalladamente esta parte del código:
```
if(!heapObjects.empty()) {
    delete heapObjects.back();
    heapObjects.pop_back();
}
```
### ¿Qué ocurre al presionar la tecla “f”?
Al presionarla, se elimina el punto más reciente agregado, funcionando como una estructura tipo pila (LIFO: Last In, First Out), donde el último en entrar es siempre el primero en retirarse. En la pantalla desaparece el círculo que había sido dibujado de último.

En términos de memoria, se libera el objeto ofVec2f que fue creado dinámicamente en el heap y, después, se retira el puntero correspondiente de la lista (vector).

Revisión del fragmento de código


### if(!heapObjects.empty())

Este condicional asegura que solo se intente borrar si el vector contiene elementos. De no estar esa validación, acceder a back() cuando el contenedor está vacío provocaría un comportamiento indefinido.

### delete heapObjects.back();

Llama al destructor de ofVec2f y libera la memoria reservada con new dentro de mousePressed. Cabe resaltar que, en este momento, el puntero aún existe dentro del vector, por lo que podría considerarse “colgante” si no se gestiona a continuación.

### heapObjects.pop_back();

Quita la referencia (puntero) que estaba guardada en el vector, de modo que el contenedor ya no almacena punteros inválidos. Con esto, se completa correctamente el ciclo de liberación.
