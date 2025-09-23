# SESION 1
### 1) ¿Qué representa la clase Particle?

La clase Particle es un molde (blueprint) que describe qué datos y qué comportamiento tienen las partículas. 
```
class Particle {
public:
    float x, y;
    void move(float dx, float dy) {
        x += dx;
        y += dy;
    }
};
```

La clase Particle define los datos o atributos x y y, que representan la posición en un espacio 2D, y un comportamiento a través del método move, encargado de modificar esa posición. Es importante entender que la clase en sí misma no ocupa espacio en tiempo de ejecución, ya que funciona únicamente como una descripción o plantilla usada por el compilador para crear objetos concretos. Además, en C++ el acceso por defecto en una class es private, pero en este caso se declaró como public, lo que permite que los atributos y métodos sean accesibles desde fuera de la clase.

### 2) ¿Cómo interactúan sus atributos y métodos?

Los métodos operan sobre los datos de la instancia que los invoca. Cuando llamas p.move(1.0f, 2.0f);, el compilador realmente pasa implícitamente un puntero this al método; conceptualmente es como Particle::move(&p, 1.0f, 2.0f).

Dentro de move, x y y se refieren a this->x y this->y: por eso la llamada modifica los atributos de esa instancia concreta.

Los métodos no se copian por cada objeto: el código del método vive una sola vez en memoria (segmento de código). Cada objeto sólo contiene su estado (los atributos).

### Ejemplo:
```
Particle p1;
p1.x = 0;
p1.y = 0;
p1.move(1.5f, -0.5f); // ahora p1.x == 1.5, p1.y == -0.5
```

### 3) ¿Qué es un objeto en C++ y cómo se relaciona con una clase? (detalle con Particle)

Una clase es la definición/plantilla: lista de miembros (datos, funciones), constructores, destructores, etc.

Un objeto es una instancia concreta de esa clase: un bloque de memoria que contiene los atributos definidos por la clase (y, opcionalmente, información extra como un puntero a la vtable si la clase tiene funciones virtuales).

En C++, un objeto puede crearse en el stack o en el heap. Por ejemplo, Particle p1; vive en el stack (si está en una función), mientras que Particle* p2 = new Particle(); crea un objeto en el heap, siendo p2 solo el puntero. Cada objeto tiene su propia copia de x y y. El tamaño de Particle suele ser 8 bytes (dos float), y sus atributos se almacenan normalmente de forma contigua, aunque puede haber padding por alineación. Los métodos no ocupan espacio en cada objeto: el código de move está una sola vez en el ejecutable. Si la clase tiene funciones virtuales, cada objeto incluye un puntero extra (vptr). Dos instancias (p1, p2) son totalmente independientes en memoria. 

### Ejemplo:
```
class Particle {
public:
    float x = 0, y = 0;
    void move(float dx, float dy) { x += dx; y += dy; }
};
```

Al imprimir direcciones, verás que &p1.x y &p1.y están muy cerca, sizeof(Particle) ≈ 8, y p1 y p2 tienen direcciones distintas. Cuando llamas p1.move(1,2), el puntero this apunta a p1. Además, C++ crea por defecto constructores y operadores de copia que copian atributos tal cual; si la clase maneja memoria dinámica, es necesario definir copia profunda o semántica de movimiento para evitar errores.


## EXPLORANDO LA MEMORIA
### ¿Los atributos están almacenados de forma contigua?
Sí, normalmente los atributos como x y y se guardan uno al lado del otro en memoria, aunque puede haber pequeños espacios vacíos por alineación.

### ¿Qué indica el tamaño del objeto sobre su estructura interna?
El tamaño muestra cuántos bytes ocupan sus atributos y revela si el compilador agregó espacio extra (padding) para que los datos se alineen correctamente.

### ¿Cómo se almacenan los objetos en memoria en C++?
Cada objeto ocupa su propio bloque de memoria con sus atributos. Dos instancias (p1 y p2) están en direcciones distintas y no comparten datos, pero dentro de cada una sus atributos suelen estar contiguos.

## ANALISIS DE DIFERENCIAS
### ¿Cómo afectan los datos estáticos al tamaño de la instancia?
Las variables estáticas no cambian el tamaño de cada objeto, porque solo existen una vez en memoria y son compartidas por todas las instancias.

### ¿Qué diferencias hay entre datos estáticos y dinámicos en términos de memoria?
Los datos estáticos viven en un solo lugar de la memoria y son iguales para todos los objetos, mientras que los datos dinámicos se guardan en el heap y cada objeto tiene su propio bloque reservado, aunque dentro del objeto solo se guarda el puntero.

### ¿Las variables estáticas ocupan espacio en cada objeto?
No, las variables estáticas no ocupan espacio dentro de cada instancia, solo el atributo normal o el puntero sí lo hacen.


# REFLEXIÓN:
### ¿Qué es un objeto desde la perspectiva de la memoria?
Un objeto en C++ es un bloque de memoria que guarda sus atributos (variables de instancia). Cada objeto tiene su propio espacio en memoria, independiente de otros, aunque provengan de la misma clase.
### ¿Cómo influyen los atributos y métodos en el tamaño y estructura del objeto?
Los atributos determinan directamente el tamaño del objeto porque cada uno ocupa memoria. Los métodos no aumentan el tamaño, ya que el código de las funciones se guarda solo una vez en el ejecutable. Solo si hay métodos virtuales, se añade un puntero extra (vptr) dentro de cada objeto.
### Conclusión: resumir los hallazgos y cómo esto impacta el diseño de clases.
Los objetos ocupan memoria según sus atributos y la alineación que decida el compilador. Los métodos no influyen en el tamaño, pero los atributos estáticos y dinámicos sí cambian cómo y dónde se reserva memoria. Esto demuestra que al diseñar clases se debe planear bien la cantidad y tipo de atributos, sobre todo si se crean muchos objetos, ya que su tamaño impacta directamente el uso de memoria y el rendimiento del programa.

# SESIÓN 2
### ¿Dónde se almacenan los datos y métodos de una clase en C++?
Los atributos viven en el stack si la instancia se declara local, o en el heap si se crea con new. Los métodos no están dentro de cada objeto: el código de las funciones se guarda en la sección de texto/código del ejecutable y solo existe una copia.

### ¿Qué es la vtable y cómo se relaciona con los métodos virtuales?
Cuando una clase tiene métodos virtuales, el compilador añade un puntero oculto dentro de cada objeto llamado vptr, que apunta a una vtable (tabla virtual).
La vtable es una tabla en memoria donde se guardan las direcciones de las funciones virtuales que corresponden a esa clase. Gracias a ella, al llamar un método virtual, el programa consulta la vtable en tiempo de ejecución y ejecuta la función correcta (soportando polimorfismo).

### Impacto en el tamaño y polimorfismo: 
Los objetos con métodos virtuales suelen ser más grandes porque incluyen el puntero vptr (4 u 8 bytes dependiendo de la arquitectura). Esto hace posible que Base* pueda apuntar a un Derived y ejecutar el método adecuado dinámicamente.

## PUNTEROS Y REFERENCIAS


## Punteros a funciones vs punteros a métodos miembro

* Un puntero a función almacena la dirección de una función global o estática. No depende de un objeto, así que no necesita un this.

* Un puntero a método miembro incluye información extra para saber a qué clase pertenece y requiere un objeto para usarse.

## Impacto en memoria

* Un puntero a función ocupa el mismo espacio que un puntero normal (4 bytes en sistemas de 32 bits, 8 bytes en 64 bits).

* El tamaño de la clase aumenta solo por el espacio del puntero.

* Los punteros a funciones no tienen relación directa con la vtable: la vtable se usa para llamadas dinámicas de métodos virtuales, mientras que un puntero a función apunta a una dirección fija de código.

## Rendimiento

* Llamar mediante un puntero a función es muy rápido (solo un salto indirecto).

* Las vtables añaden un nivel de indirección similar, pero gestionan polimorfismo en tiempo de ejecución.

* El impacto en rendimiento suele ser mínimo, pero a gran escala puede importar.

## REFLEXIÓN
### ¿Dónde residen los datos y métodos de una clase en la memoria?
Los datos (atributos) viven en el stack o heap según cómo se creen los objetos. Los métodos se guardan en la sección de código del ejecutable.

### ¿Cómo interactúan en tiempo de ejecución?
Los punteros a función guardan direcciones de funciones y permiten llamadas indirectas. Los punteros a métodos miembro necesitan un objeto y permiten despachar dinámicamente funciones de esa clase.

### Conclusión
Comprender estas diferencias ayuda a diseñar sistemas más eficientes: elegir punteros a función para callbacks simples, métodos virtuales para polimorfismo y punteros a métodos miembro cuando se necesita flexibilidad con objetos específicos.