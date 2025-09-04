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
# 3. ¿Qué es una lista enlazada y en qué se diferencia de un arreglo en cuanto a la forma en que los elementos están almacenados en la memoria?
Una lista enlazada es una estructura de datos donde cada elemento (nodo) contiene su valor y un puntero al siguiente nodo. A diferencia de un arreglo, sus elementos no están almacenados en posiciones contiguas de memoria, sino dispersos y conectados mediante punteros.
# 4. Al observar el código de una lista enlazada en C++, ¿Cómo crees que se vinculan los nodos entre sí? ¿Qué estructura se utiliza para lograr esta conexión?
Los nodos se vinculan entre sí usando punteros. Cada nodo tiene un campo next que apunta al siguiente nodo de la lista, formando una cadena que termina en nullptr.
# ¿Cómo se gestiona la memoria en una lista enlazada? Investiga cómo se crea y se destruye un nodo en memoria utilizando el operador new y delete en C++.
La memoria se gestiona manualmente con new y delete. Cada nodo se crea en el heap con new Node(...) y se libera con delete cuando ya no se necesita, como en el método clear() que elimina todos los nodos para evitar fugas de memoria.
# 5. Considerando la estructura de una lista enlazada, ¿qué ventajas ofrece en comparación con un arreglo cuando se trata de insertar o eliminar elementos en posiciones intermedias?
La lista enlazada permite insertar o eliminar elementos en posiciones intermedias de forma más eficiente porque solo se modifican los punteros de los nodos vecinos, sin necesidad de mover todos los demás elementos. En cambio, en un arreglo, al estar en memoria contigua, es obligatorio desplazar los elementos posteriores, lo que hace estas operaciones más costosas.
# 6. En el código presentado, ¿Cómo se asegura que no haya fugas de memoria? ¿Qué papel juega el destructor en la clase LinkedList?
Las listas enlazadas permiten insertar o eliminar elementos en posiciones intermedias de forma más eficiente que los arreglos, ya que no requieren mover otros elementos; solo se actualizan punteros. En cambio, los arreglos deben desplazar todos los elementos posteriores, lo que es más costoso en tiempo.

# 7. En el código presentado, ¿Cómo se asegura que no haya fugas de memoria? ¿Qué papel juega el destructor en la clase LinkedList?
Se evita la fuga de memoria porque la clase LinkedList tiene un destructor que llama al método clear(). Este método recorre toda la lista y elimina (libera) cada nodo con delete. Así, cuando la lista deja de usarse, todos sus nodos se liberan correctamente y no queda memoria sin liberar.

# 8. ¿Qué sucede en la memoria cuando se invoca el método clear() en una lista enlazada? Explica paso a paso cómo se liberan los recursos.
Cuando se llama a clear(), el método empieza desde la cabeza de la lista y va recorriendo nodo por nodo. En cada paso, guarda el puntero al siguiente nodo, elimina el nodo actual con delete para liberar su memoria, y luego avanza al siguiente. Esto se repite hasta eliminar todos los nodos, dejando la lista vacía y sin usar memoria innecesaria.

# 9. Explica cómo cambia la estructura en memoria de una lista enlazada al agregar un nuevo nodo al final de la lista. ¿Cómo afecta esto al rendimiento de la lista enlazada?
Al agregar un nodo al final, se crea un nuevo nodo en memoria dinámica y el puntero next del nodo actual final apunta a este nuevo nodo. Luego, el puntero tail de la lista se actualiza para apuntar a este nuevo nodo. Esto hace que la inserción al final sea rápida (O(1)), porque no hay que recorrer toda la lista para encontrar dónde agregar el nodo. Sin embargo, si no se mantiene el puntero tail, agregar al final podría ser lento (O(n)) porque habría que recorrer la lista.

# 10. Analiza una situación en la que utilizar una lista enlazada sería más ventajoso que utilizar un arreglo. Justifica tu respuesta considerando la gestión de memoria y las operaciones de inserción y eliminación.
Una lista enlazada es más ventajosa que un arreglo cuando el tamaño cambia frecuentemente y se realizan muchas inserciones o eliminaciones en posiciones intermedias. Las listas enlazadas gestionan la memoria dinámicamente y solo actualizan punteros para insertar o eliminar, mientras que los arreglos requieren mover elementos y redimensionarse, consumiendo más tiempo y recursos.

# 11. Después de estudiar el manejo de memoria en listas enlazadas, ¿Cómo aplicarías este conocimiento para diseñar una estructura de datos personalizada para una aplicación creativa? ¿Qué aspectos considerarías para asegurar la eficiencia y evitar fugas de memoria?
