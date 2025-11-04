# RETO
## IDEA:
* Quiero hacer una lámpara de lava digital en la que yo pueda interactuar. La idea es que cuando dé click con el mouse se creen burbujas dentro de la lámpara y empiecen a moverse. También quiero que al usar la ruedita del mouse la lámpara se agite y las burbujas se muevan más rápido. Así puedo simular de forma sencilla cómo funciona una lámpara de lava, pero de manera digital.
![alt text](image.png)
- Muestra de la idea (faltan correciones)

### ¿Cómo puedo usar herencia en este reto?

En mi proyecto puedo usar herencia creando una clase principal que sea como una partícula general, con cosas basicas como la posicion, el tamaño y la velocidad. Luego puedo hacer que de esa clase salgan otras como la burbuja, y así no tengo que repetir código porque todas heredan lo básico.

### ¿Cómo puedo usar encapsulamiento en este reto?

El encapsulamiento lo aplico cuando pongo los atributos de mis clases en privado y hago funciones para cambiarlos o verlos. De esa forma controlo que nadie modifique mal las variables, por ejemplo la posicion o la velocidad de una burbuja, y asi todo se mantiene más ordenado.

### ¿Cómo aplicar lo visto de rendimiento en este reto?

En cuanto al rendimiento, tengo dos opciones. Si hago que el codigo sea más eficiente, por ejemplo usando vectores y actualizando solo lo necesario, el programa corre mejor y no se pone lento aunque se creen muchas burbujas en la lampara. La otra opcion es limitar el número de burbujas para que no se sobrecargue la memoria.



# PROCESO DE CREACIÓN
https://www.youtube.com/watch?v=xGQO07BguUA

# REFLEXIONES
### 1. ¿Cómo influyó el entendimiento de los mecanismos internos de OOP en el proyecto?

Me ayudó a organizar mejor el código porque pude separar las funciones de cada cosa. Con la herencia y el polimorfismo logré que las burbujas y las partículas se manejaran parecido sin repetir tanto código, y con el encapsulamiento fue más fácil controlar las variables sin que se dañara nada.
### 2. DESAFIOS:
De lo que mas se me complico fue integrar todo, porque al inicio hice diferentes pruebas, una que genere burbujas, otra que genere unicamente particulas, otra que permita que se agite el contenedor y reaccionen las burbujas y una donde las burbujas tengan "fisicas" al chocar con paredes, e integrar todo eso en un solo proyecto si fue maluco en especial lo que era la generación de particulas o tal vez que las burbujas tengan el comportamiento de moverse, devanecerse, tener brillo etc, ademas de aplicar correctamente los principios de POO sin alterar la funcionalidad original

### 3. ¿Qué aprendiste sobre el equilibrio entre diseño y eficiencia?

Aprendí que no siempre se trata de hacer el código lo más bonito posible, sino que también tiene que ser rápido y funcionar bien. Si uno se enfoca solo en diseño se puede volver más lento, pero si se busca un equilibrio, el programa queda ordenado y funciona sin problemas.
# CÓDIGO
```
#include "ofMain.h"
#include "ofApp.h"

int main() {
    ofSetupOpenGL(800, 600, OF_WINDOW);
    ofRunApp(new ofApp());
}

```
```
#pragma once
#include "ofMain.h"

class SimulatedEntity {
public:
    virtual ~SimulatedEntity() {}

    virtual void update(float agitation, const ofRectangle& container) = 0;
    virtual void draw(float agitation) = 0;
};
```

```
#pragma once
#include "ofMain.h"
#include "SimulatedEntity.h" 


class Bubble : public SimulatedEntity {
public:
    ofVec2f pos, vel;
    float radius;
    ofColor color;
    float deformAmount;


    float targetRadius;
    float currentLife;
    float lifeSpeed;
    ofColor targetColor;

    Bubble(ofVec2f _pos, ofVec2f _vel, float _radius, ofColor _color);

    // Las funciones deben ser 'override' para el polimorfismo
    void update(float agitation, const ofRectangle& container) override;
    void draw(float agitation) override;
};

class Particle : public SimulatedEntity {
public:
    ofVec2f pos, vel;
    float radius;
    ofColor color;

    Particle(ofRectangle container);


    void update(float agitation, const ofRectangle& container) override;
    void draw(float agitation) override;
};


class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();
    void exit(); 

    void keyPressed(int key);
    void mousePressed(int x, int y, int button);

   
    vector<SimulatedEntity*> entities;

    ofRectangle container;

    float agitation;
    int maxBubbles;
    int maxParticles;
    int insertIndex;

    
    void addBubble(ofVec2f pos, ofVec2f vel, float r, ofColor c);
    void setupParticles(int num);
    void cleanupEntities();
};
```
```
#include "ofMain.h"
#include "ofApp.h"
#include "SimulatedEntity.h" 

int main() {
    ofSetupOpenGL(800, 800, OF_WINDOW); 
    ofRunApp(new ofApp());
    return 0;
}

Bubble::Bubble(ofVec2f _pos, ofVec2f _vel, float _radius, ofColor _color) {
    pos = _pos;
    vel = _vel;
    color = _color;
    deformAmount = 0.0f;
    radius = 5.0f;
    targetRadius = _radius;
    currentLife = ofRandom(0.0f, 1.0f);
    lifeSpeed = ofRandom(0.005, 0.015);
    targetColor.setHsb(ofRandom(0, 255), 200, 255);
}
void Bubble::update(float agitation, const ofRectangle& container) {
    currentLife += lifeSpeed;
    if (currentLife >= 1.0f) {
        currentLife = 0.0f;
        lifeSpeed = ofRandom(0.005, 0.015);
    }
    color.lerp(targetColor, 0.01f);
    if (currentLife >= 0.9f && currentLife - lifeSpeed < 0.9f) {
        targetColor.setHsb(ofRandom(0, 60), 200, 255);
    }

    float growFactor;
    if (currentLife < 0.3) {
        growFactor = ofMap(currentLife, 0.0f, 0.3f, 0.0f, 1.0f);
        radius = ofLerp(radius, targetRadius * growFactor, 0.1);
    }
    else if (currentLife > 0.7) {
        growFactor = ofMap(currentLife, 0.7f, 1.0f, 1.0f, 0.0f);
        radius = ofLerp(radius, targetRadius * growFactor, 0.05);
    }
    else {
        radius = ofLerp(radius, targetRadius, 0.05);
    }
    radius = MAX(radius, 5.0f);

    vel *= 0.98;
    ofVec2f errantForce(ofRandom(-0.1, 0.1), ofRandom(-0.1, 0.1));
    ofVec2f agitationForce(ofRandom(-agitation, agitation), ofRandom(-agitation, agitation));
    vel += errantForce;
    vel += agitationForce * 0.5;
    pos += vel * (1.0 + agitation * 1.5);

    bool collided = false;
    if (pos.x - radius < container.getLeft()) {
        pos.x = container.getLeft() + radius;
        vel.x *= -0.8;
        collided = true;
    }
    if (pos.x + radius > container.getRight()) {
        pos.x = container.getRight() - radius;
        vel.x *= -0.8;
        collided = true;
    }
    if (pos.y - radius < container.getTop()) {
        pos.y = container.getTop() + radius;
        vel.y *= -0.8;
        collided = true;
    }
    if (pos.y + radius > container.getBottom()) {
        pos.y = container.getBottom() - radius;
        vel.y *= -0.8;
        collided = true;
    }

    if (collided || agitation > 0.5) {
        deformAmount = ofLerp(deformAmount, 1.0f, 0.1f);
    }
    deformAmount = ofLerp(deformAmount, 0.0f, 0.04f);
}
void Bubble::draw(float agitation) {
    ofPushMatrix();

    ofTranslate(pos.x + ofRandom(-agitation * 5, agitation * 5),
        pos.y + ofRandom(-agitation * 5, agitation * 5));


    ofColor baseColor = color;
    float alphaFactor = ofMap(radius, 5.0f, targetRadius, 0.0f, 255.0f, true);
    baseColor.a = alphaFactor;

    ofSetColor(baseColor);
    ofFill();

    ofBeginShape();
    int resolution = 80;
    float time = ofGetElapsedTimef();

    for (int i = 0; i < resolution; i++) {
        float angle = ofMap(i, 0, resolution, 0, TWO_PI);
        float r = radius;
        float noiseVal = ofNoise(cos(angle) * 0.8 + time * 0.5,
            sin(angle) * 0.8 + time * 0.5,
            deformAmount * 2.0);

        r += deformAmount * 25.0f * (noiseVal - 0.5f);

        float x = cos(angle) * r;
        float y = sin(angle) * r;
        ofVertex(x, y);
    }
    ofEndShape(true);

  
    ofColor highlightColor = baseColor;
    highlightColor.setBrightness(255);
    highlightColor.a = 180 * (alphaFactor / 255.0f);
    ofSetColor(highlightColor);
    ofDrawCircle(-radius * 0.3, -radius * 0.3, radius * 0.3);


    ofColor centerGlow(255, 255, 255);
    centerGlow.a = 80 * (alphaFactor / 255.0f);
    ofSetColor(centerGlow);
    ofDrawCircle(0, 0, radius * 0.2);

    ofPopMatrix();
}

Particle::Particle(ofRectangle container) {
    pos.set(ofRandom(container.getLeft(), container.getRight()),
        ofRandom(container.getTop(), container.getBottom()));
    vel.set(ofRandom(-0.3, 0.3), ofRandom(-0.3, 0.3));


    radius = ofRandom(0.5, 1.5);


    ofColor base(255, 0, 100);
    base.r = ofRandom(180, 220);
    base.g = 0;
    base.b = ofRandom(50, 120);
    base.a = ofRandom(100, 180);
    color = base;
}

void Particle::update(float agitation, const ofRectangle& container) {
    ofVec2f agitationForce(ofRandom(-agitation * 2, agitation * 2),
        ofRandom(-agitation * 2, agitation * 2));

    pos += vel * (1.0 + agitation * 2.0) + agitationForce * 0.1;

    if (pos.x - radius < container.getLeft()) {
        pos.x = container.getLeft() + radius;
        vel.x *= -1;
    }
    if (pos.x + radius > container.getRight()) {
        pos.x = container.getRight() - radius;
        vel.x *= -1;
    }
    if (pos.y - radius < container.getTop()) {
        pos.y = container.getTop() + radius;
        vel.y *= -1;
    }
    if (pos.y + radius > container.getBottom()) {
        pos.y = container.getBottom() - radius;
        vel.y *= -1;
    }
}

void Particle::draw(float agitation) {
    ofSetColor(color);
    ofDrawCircle(pos, radius);
}

void ofApp::setup() {
    ofSetFrameRate(60);
    ofBackground(0);
    ofEnableAlphaBlending();

    agitation = 0.0f;
    maxBubbles = 20;
    maxParticles = 150;
    insertIndex = 0;


    container.set(300, 20, 200, 700);

    setupParticles(maxParticles);
}


void ofApp::addBubble(ofVec2f pos, ofVec2f vel, float r, ofColor c) {
    if (insertIndex < maxBubbles) {

        entities.push_back(new Bubble(pos, vel, r, c));
        insertIndex++;
    }
    else {
      
        int replacementIndex = maxParticles + (insertIndex % maxBubbles);

      
        delete entities[replacementIndex];

        entities[replacementIndex] = new Bubble(pos, vel, r, c);
        insertIndex = (insertIndex + 1) % maxBubbles;
    }
}

void ofApp::setupParticles(int num) {
    for (int i = 0; i < num; i++) {
        entities.push_back(new Particle(container));
    }
    maxParticles = num; 
}

void ofApp::cleanupEntities() {
    for (auto& entity : entities) {
        delete entity;
    }
    entities.clear();
}

void ofApp::exit() {
    cleanupEntities(); 
}


void ofApp::update() {
    
    for (auto& entity : entities) {
        entity->update(agitation, container);
    }
    agitation = ofLerp(agitation, 0.0f, 0.05f);
}


void ofApp::draw() {
  
    ofPushMatrix();

   
    ofTranslate(ofRandom(-agitation * 15, agitation * 15),
        ofRandom(-agitation * 15, agitation * 15));

    ofColor bottomColor(200, 0, 50);
    ofColor topColor(255, 100, 150);


    ofMesh gradientMesh;
    gradientMesh.setMode(OF_PRIMITIVE_TRIANGLE_FAN);
    gradientMesh.addVertex(container.getTopLeft());
    gradientMesh.addColor(topColor);
    gradientMesh.addVertex(container.getTopRight());
    gradientMesh.addColor(topColor);
    gradientMesh.addVertex(container.getBottomRight());
    gradientMesh.addColor(bottomColor);
    gradientMesh.addVertex(container.getBottomLeft());
    gradientMesh.addColor(bottomColor);
    gradientMesh.draw();


    ofNoFill();
    ofSetColor(255, 50, 100);
    ofSetLineWidth(6);
    ofDrawRectangle(container);

 
    ofPopMatrix();



    for (int i = 0; i < maxParticles; i++) {
        entities[i]->draw(agitation);
    }


    for (size_t i = maxParticles; i < entities.size(); i++) {
        entities[i]->draw(agitation);
    }
}


void ofApp::keyPressed(int key) {
    if (key == ' ') {
        agitation = 1.0f;
    }
}


void ofApp::mousePressed(int x, int y, int button) {
    if (container.inside(x, y)) {
        ofVec2f pos(x, y);
        ofVec2f vel(ofRandom(-2, 2), ofRandom(-2, 2));
        float r = ofRandom(20, 40);
        ofColor c;
        c.setHsb(ofRandom(0, 60), 200, 255);

        addBubble(pos, vel, r, c);
    }
}
```
