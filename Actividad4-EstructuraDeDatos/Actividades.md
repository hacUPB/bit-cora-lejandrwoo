# ACTIVIDAD 1



```
#pragma once
#include "ofMain.h"

class Node {
public:
	float x, y;
	Node* next;

	Node(float _x, float _y);
	~Node();
};

class LinkedList {
public:
	Node* head;
	Node* tail;
	int size;

	LinkedList();
	~LinkedList();

	void clear();
	void addNode(float x, float y);
	void update(float x, float y);
	void display();
};

class ofApp : public ofBaseApp {
public:
	LinkedList snake;
	void setup();
	void update();
	void draw();
	void keyPressed(int key); // Nueva función para manejar el teclado
};
```
```
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
	// Agregar nodos a la serpiente
	ofBackground(255, 255, 255);
	for (int i = 0; i < 10; i++) {
		snake.addNode(ofGetWidth() / 2, ofGetHeight() / 2);
	}
}
//--------------------------------------------------------------
void ofApp::update() {
	// Actualizar la posición de la serpiente
	snake.update(ofGetMouseX(), ofGetMouseY());
}
//--------------------------------------------------------------
void ofApp::draw() {
	ofBackground(220);
	// Dibujar la serpiente
	snake.display();
}
//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
	if (key == 'c') {
		snake.clear(); // Limpiar la lista cuando se presiona la tecla 'c'
	}
}
//--------------------------------------------------------------

LinkedList::LinkedList() {
	head = new Node(ofGetWidth() / 2, ofGetHeight() / 2);
	tail = head;
	size = 1;
}
//--------------------------------------------------------------
LinkedList::~LinkedList() {
	clear();
}
//--------------------------------------------------------------
void LinkedList::clear() {
	Node* current = head;
	while (current != nullptr) {
		Node* nextNode = current->next;
		delete current;
		current = nextNode;
	}
	head = nullptr;
	tail = nullptr;
	size = 0;
}
//--------------------------------------------------------------
void LinkedList::addNode(float x, float y) {
	Node* newNode = new Node(x, y);
	if (tail != nullptr) {
		tail->next = newNode;
		tail = newNode;
	}
	else {
		head = tail = newNode;
	}
	size++;
}
//--------------------------------------------------------------
void LinkedList::update(float x, float y) {
	Node* current = head;
	float prevX = x;
	float prevY = y;

	while (current != nullptr) {
		float tempX = current->x;
		float tempY = current->y;
		current->x = prevX;
		current->y = prevY;
		prevX = tempX;
		prevY = tempY;
		current = current->next;
	}
}
//--------------------------------------------------------------
void LinkedList::display() {
	Node* current = head;
	while (current != nullptr) {
		ofSetColor(ofColor(255, 0, 0));
		ofDrawCircle(current->x, current->y, 10);
		current = current->next;
	}
}
//--------------------------------------------------------------
Node::Node(float _x, float _y) {
	x = _x;
	y = _y;
	next = nullptr;
}
//--------------------------------------------------------------
Node::~Node() {
	// Destructor para Node
}
```
### 3. ¿Qué es una lista enlazada y en qué se diferencia de un arreglo en cuanto a la forma en que los elementos están almacenados en la memoria?
Una lista enlazada es una estructura de datos donde cada elemento (nodo) contiene su valor y un puntero al siguiente nodo. A diferencia de un arreglo, sus elementos no están almacenados en posiciones contiguas de memoria, sino dispersos y conectados mediante punteros.
### 4. Al observar el código de una lista enlazada en C++, ¿Cómo crees que se vinculan los nodos entre sí? ¿Qué estructura se utiliza para lograr esta conexión?
Los nodos se vinculan entre sí usando punteros. Cada nodo tiene un campo next que apunta al siguiente nodo de la lista, formando una cadena que termina en nullptr.
### 5. ¿Cómo se gestiona la memoria en una lista enlazada? Investiga cómo se crea y se destruye un nodo en memoria utilizando el operador new y delete en C++.
La memoria se gestiona manualmente con new y delete. Cada nodo se crea en el heap con new Node(...) y se libera con delete cuando ya no se necesita, como en el método clear() que elimina todos los nodos para evitar fugas de memoria.
### 6. Considerando la estructura de una lista enlazada, ¿qué ventajas ofrece en comparación con un arreglo cuando se trata de insertar o eliminar elementos en posiciones intermedias?
La lista enlazada permite insertar o eliminar elementos en posiciones intermedias de forma más eficiente porque solo se modifican los punteros de los nodos vecinos, sin necesidad de mover todos los demás elementos. En cambio, en un arreglo, al estar en memoria contigua, es obligatorio desplazar los elementos posteriores, lo que hace estas operaciones más costosas.

### 7. En el código presentado, ¿Cómo se asegura que no haya fugas de memoria? ¿Qué papel juega el destructor en la clase LinkedList?
Se evita la fuga de memoria porque la clase LinkedList tiene un destructor que llama al método clear(). Este método recorre toda la lista y elimina (libera) cada nodo con delete. Así, cuando la lista deja de usarse, todos sus nodos se liberan correctamente y no queda memoria sin liberar.

### 8. ¿Qué sucede en la memoria cuando se invoca el método clear() en una lista enlazada? Explica paso a paso cómo se liberan los recursos.
Cuando se llama a clear(), el método empieza desde la cabeza de la lista y va recorriendo nodo por nodo. En cada paso, guarda el puntero al siguiente nodo, elimina el nodo actual con delete para liberar su memoria, y luego avanza al siguiente. Esto se repite hasta eliminar todos los nodos, dejando la lista vacía y sin usar memoria innecesaria.

### 9. Explica cómo cambia la estructura en memoria de una lista enlazada al agregar un nuevo nodo al final de la lista. ¿Cómo afecta esto al rendimiento de la lista enlazada?
Al agregar un nodo al final, se crea un nuevo nodo en memoria dinámica y el puntero next del nodo actual final apunta a este nuevo nodo. Luego, el puntero tail de la lista se actualiza para apuntar a este nuevo nodo. Esto hace que la inserción al final sea rápida (O(1)), porque no hay que recorrer toda la lista para encontrar dónde agregar el nodo. Sin embargo, si no se mantiene el puntero tail, agregar al final podría ser lento (O(n)) porque habría que recorrer la lista.

### 10. Analiza una situación en la que utilizar una lista enlazada sería más ventajoso que utilizar un arreglo. Justifica tu respuesta considerando la gestión de memoria y las operaciones de inserción y eliminación.
Una lista enlazada es más ventajosa que un arreglo cuando el tamaño cambia frecuentemente y se realizan muchas inserciones o eliminaciones en posiciones intermedias. Las listas enlazadas gestionan la memoria dinámicamente y solo actualizan punteros para insertar o eliminar, mientras que los arreglos requieren mover elementos y redimensionarse, consumiendo más tiempo y recursos.

### 11. Después de estudiar el manejo de memoria en listas enlazadas, ¿Cómo aplicarías este conocimiento para diseñar una estructura de datos personalizada para una aplicación creativa? ¿Qué aspectos considerarías para asegurar la eficiencia y evitar fugas de memoria?
Yo usaría lista enlazadas para generar sistemas de particulas, tazos de dibujo o alguna animación que este en constante cambio. Esto porque facilita poner o quitar sin reordenar toda la memoria como en un arreglo. Para evitar alguna fuga implementaria destructores que liberen los nodos, usaria practicas para controlar los punteros para no dejar algun nodo huerfano.
### 12. Reflexiona sobre las diferencias en la gestión de memoria entre C++ y un lenguaje con recolección de basura automática como C#. ¿Qué ventajas y desafíos encuentras en la gestión explícita de memoria en C++ al trabajar con estructuras de datos?
En C++ la memoria es manejada de manera mas explicita dando mayor control al programador dando el chance de optimizar estructuras de datos y en rendimiento, pero esto implica mayores fugas o errores como accesos a memoria liberada. En lenguajes con recoleción de basura de C#, la gestion es mas sencilla y segura pero pierde el control y podrian aparecer pausas no deseadas en la ejecucion.

### 13. Imagina que estás optimizando una pieza de arte generativo que usa listas enlazadas para representar elementos en movimiento. ¿Qué consideraciones tomarías en cuenta para garantizar que la gestión de la memoria sea eficiente y que no ocurran fugas de memoria?
Para evitar fugas en alguna lista enlazada libero los nodos en el destructor, usa punteros inteligentes y controla el numero de elementos para no saturar la memoria.

# ACTIVIDAD 2
ofApp.h:
```
#pragma once

#include "ofMain.h"

class Node {
public:
    ofVec2f position;
    Node* next;

    Node(float x, float y) {
        position.set(x, y);
        next = nullptr;
    }
};

class Stack {
public:
    Node* top;

    Stack() {
        top = nullptr;
    }

    ~Stack() {
        clear();
    }

    void push(float x, float y) {
        Node* newNode = new Node(x, y);
        newNode->next = top;
        top = newNode;
    }

    void pop() {
        if (top != nullptr) {
            Node* temp = top;
            top = top->next;
            delete temp;  // Liberar memoria del nodo eliminado
        }
    }

    void clear() {
        while (top != nullptr) {
            pop();
        }
    }

    void display() {
        Node* current = top;
        while (current != nullptr) {
            ofDrawCircle(current->position.x, current->position.y, 20);
            current = current->next;
        }
    }
};

class ofApp : public ofBaseApp {

public:
    Stack circleStack;

    void setup();
    void update();
    void draw();
    void keyPressed(int key);
};
```
ofApp.cpp:
```
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofSetBackgroundColor(220);
}

//--------------------------------------------------------------
void ofApp::update() {

}

//--------------------------------------------------------------
void ofApp::draw() {
    // Dibujar todos los círculos en la pila
    circleStack.display();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (key == 'a') { // Apilar un nuevo círculo
        circleStack.push(ofGetMouseX(), ofGetMouseY());
    }
    else if (key == 'd') { // Desapilar el último círculo
        circleStack.pop();
    }
}
```
El código para la cola es este:

ofApp.h:
```
#pragma once

#include "ofMain.h"

class Node {
public:
    ofVec2f position;
    Node* next;

    Node(float x, float y) {
        position.set(x, y);
        next = nullptr;
    }
};

class Queue {
public:
    Node* front;
    Node* rear;

    Queue() {
        front = rear = nullptr;
    }

    ~Queue() {
        clear();
    }

    void enqueue(float x, float y) {
        Node* newNode = new Node(x, y);
        if (rear == nullptr) {
            front = rear = newNode;
        }
        else {
            rear->next = newNode;
            rear = newNode;
        }
    }

    void dequeue() {
        if (front != nullptr) {
            Node* temp = front;
            front = front->next;
            if (front == nullptr) {
                rear = nullptr;
            }
            delete temp;  // Liberar memoria del nodo eliminado
        }
    }

    void clear() {
        while (front != nullptr) {
            dequeue();
        }
    }

    void display() {
        Node* current = front;
        while (current != nullptr) {
            ofDrawCircle(current->position.x, current->position.y, 20);
            current = current->next;
        }
    }
};

class ofApp : public ofBaseApp {

public:
    Queue circleQueue;

    void setup();
    void update();
    void draw();
    void keyPressed(int key);
};
```
ofApp.cpp:
```
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofSetBackgroundColor(220);
}

//--------------------------------------------------------------
void ofApp::update() {

}

//--------------------------------------------------------------
void ofApp::draw() {
    // Dibujar todos los círculos en la cola
    circleQueue.display();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (key == 'a') { // Encolar un nuevo círculo
        circleQueue.enqueue(ofGetMouseX(), ofGetMouseY());
    }
    else if (key == 'd') { // Desencolar el primer círculo
        circleQueue.dequeue();
    }
}
```
### 1. **Entendiendo la aplicación**: comienza explorando detenidamente cómo funciona el programa. Usa un un modelo del lenguaje como ChatGPT y el depurador para que verifiques las explicaciones que te propone ChatGPT. Puedes escribir el prompt: quiere entender de manera muy detallada el siguiente programa escrito en C++ y el openframeworks. Luego le das el código. Ve preguntando lo que no entiendas. recuerda ir usando al mismo tiempo el depurador de visual studio.
La aplicación funciona creando un stack de nodos que representarian circulos en la pantalla, estos mismos son gestionados con puntero y con la tecla a se apila un nuevo circulo, con la tecla d es para desapilarlo, cada acción modifica la memoria dinamica del programa y se mostraria en tiempo real como se cren y destruyen los nodos.
### 2. **Realiza evaluaciones formativas**. Dile a ChatGPT que te genere preguntas para verificar si entiendes cómo funciona el programa. Trata de verificar tus hipótesis usando el depurador y luego con las conclusiones del experimento responde la pregunta de ChatGPT. Continúa con este proceso hasta que estés seguro de que entiendes cómo funciona el programa.


Preguntas de reflexión para el stack:


### 1. ¿Cómo se gestiona la memoria en una implementación manual de un stack en C++? Reflexiona sobre cómo el uso de new y delete en la creación y destrucción de nodos afecta el rendimiento y la seguridad de tu programa.
La memoria se gestionaria de manera manual usando un new para crear los nodos y delete para liberarlos al desapilarlos dando un control mas preciso sobre los recursos ayudando esto al rendimiento en programas de x eficiencia, pero si no se libera la memoria de manera correcta pueden aparecer fugas o errores de acceso, la seguridad ya dependeria de uno programando y su uso en punteros.
### 2. ¿Por qué es importante liberar la memoria cuando se desapila un nodo en un stack? Considera las consecuencias de no liberar memoria en términos de fugas de memoria y cómo esto puede impactar aplicaciones de largo tiempo de ejecución.
Es clave liberar memoria porque cada nodo ocupa un espacio en el heap y si no se elimina se pueden acumular fugas. En apps de larga duracion esto puede llevar agotamiento de recursos, ademas de que las fugas de memoria reducen el rendimiento en el sistema. En pocas palabras tener limpio el heap es para tener mayor estabilidad y eficiencia en la ejecucion del programa.
### 3. ¿Qué diferencias existen entre usar un stack de la STL (std::stack) y crear un stack manualmente? Explora cómo la abstracción que proporciona la STL puede simplificar la implementación, pero también cómo una implementación manual ofrece mayor control sobre la gestión de recursos.
std: :stack abstrae gestion de memoria y hace simple la implementacion, permitiendo el trabajo con pilas sin preocuparse por fugas, en cambio un stack manual exige esfuerzo porque uno de programador debe de manejar los punteros y la liberacion de memoria, pero esto da mas control sobre como se maneja y gestionan los datos. En pocas palabras la STL da prioridad a seguridad y rapidez en el desarrollo pero la manual permite personalizacion y asi.
### 4. ¿Cómo afecta la estructura de un stack al orden de acceso y eliminación de elementos? Analiza cómo la naturaleza LIFO (Last In, First Out) del stack influye en los tipos de problemas que esta estructura de datos puede resolver eficientemente.
El stack sigue el principio LIFO, entonces el ultimo elemento en estrar es el primero en salir, siendo bueno para problemas que requieren retroceso o historial, como el deshacer acciones o expresiones matematicas.
### 5. ¿Cómo podrías modificar el stack para almacenar tipos de datos más complejos (e.g., objetos con múltiples atributos) sin causar problemas de memoria? Reflexiona sobre cómo gestionar adecuadamente la memoria para objetos más complejos y cómo esto afectaría tu implementación actual.
Usando plantillas template para aceptar cualquier tipo de dato y punteros inteligentes std::unique_ptr para evitar fugas de memoria.
Con esto permitiria que el stack maneje objetos con múltiples atributos sin necesidad de liberar manualmente la memoria. Tambien habria que ajustar constructores y destructores para garantizar un manejo seguro.