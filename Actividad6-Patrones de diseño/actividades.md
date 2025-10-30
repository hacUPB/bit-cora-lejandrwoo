# SESIÓN 2

## ¿Qué hace el patrón Observer en este caso?

El patrón Observer sirve para que cuando se presione una tecla, todas las partículas reciban el mismo mensaje sin tener que llamarlas una por una. Así, si el programa dice “atraer”, todas las partículas cambian su estado al mismo tiempo.

## ¿Qué hace el patrón Factory en este caso?

El patrón Factory se usa para crear partículas de diferentes tipos. Por ejemplo, unas se hacen estrellas, otras planetas o estrellas fugaces. Así no tengo que escribir el mismo código cada vez que quiero un tipo distinto de partícula.

## ¿Qué hace el patrón State en este caso?

El patrón State hace que cada partícula pueda cambiar de comportamiento según el estado en el que esté. Por ejemplo, en estado normal se mueven libremente, en atraer van hacia el mouse, en repeler se alejan y en stop se quedan quietas.

# EXPERIMENTACION
<video controls src="particulas.mp4" title=""></video>

El nuevo tipo de partícula llamado OrbitState (las amarillas) hace que las partículas giren en círculo alrededor del centro de la pantalla. Cada una tiene su propio ángulo y distancia del centro, por eso no giran todas igual. En cada actualización el ángulo aumenta un poco, lo que hace que se muevan en forma circular usando coseno y seno.

## Adiciona un nuevo estado:
En ofApp.cpp se creo un nuevo estado llamado OrbitState, que es el que hace que las partículas giren en circulo.

## Modifica el comportamiento de las partículas:
Esta dentro del metodo update del nuevo estado (OrbitState::update). Ahi se cambio cómo se mueven las partículas, haciendolas girar suavemente en el centro.

## Crea otros eventos para notificar a las partículas:
Se agregaron en ofApp.cpp cuando se detectan las teclas que cambian el comportamiento de las particulas. 



### ofApp.cpp
```
#include "ofApp.h"

void Subject::addObserver(Observer* observer) {
    observers.push_back(observer);
}

void Subject::removeObserver(Observer* observer) {
    observers.erase(std::remove(observers.begin(), observers.end(), observer), observers.end());
}

void Subject::notify(const std::string& event) {
    for (Observer* observer : observers) {
        observer->onNotify(event);
    }
}
//Particulas
Particle::Particle() {
    position = ofVec2f(ofRandomWidth(), ofRandomHeight());
    velocity = ofVec2f(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
    size = ofRandom(2, 5);
    color = ofColor(255);
    state = new NormalState();
}

Particle::~Particle() {
    delete state;
}

void Particle::setState(State* newState) {
    if (state != nullptr) {
        state->onExit(this);
        delete state;
    }
    state = newState;
    if (state != nullptr) {
        state->onEnter(this);
    }
}

void Particle::update() {
    if (state != nullptr) {
        state->update(this);
    }


    if (position.x < 0 || position.x > ofGetWidth()) velocity.x *= -1;
    if (position.y < 0 || position.y > ofGetHeight()) velocity.y *= -1;
}

void Particle::draw() {
    ofSetColor(color);
    ofDrawCircle(position, size);
}

void Particle::onNotify(const std::string& event) {
    if (event == "attract") {
        setState(new AttractState());
    }
    else if (event == "repel") {
        setState(new RepelState());
    }
    else if (event == "stop") {
        setState(new StopState());
    }
    else if (event == "normal") {
        setState(new NormalState());
    }
    else if (event == "orbit" && type == "orbiter") {
        setState(new OrbitState());
    }
}

//ubicacion de los estados
void NormalState::update(Particle* particle) {
    particle->position += particle->velocity;
}

void NormalState::onEnter(Particle* particle) {
    particle->velocity = ofVec2f(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
}

void AttractState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = mousePosition - particle->position;
    direction.normalize();
    particle->velocity += direction * 0.05;
    ofClamp(particle->velocity.x, -3, 3);
    particle->position += particle->velocity * 0.2;
}

void RepelState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = particle->position - mousePosition;
    direction.normalize();
    particle->velocity += direction * 0.05;
    ofClamp(particle->velocity.x, -3, 3);
    particle->position += particle->velocity * 0.2;
}

void StopState::update(Particle* particle) {
    particle->velocity.x = 0;
    particle->velocity.y = 0;
}

//estado añadido orbitstate
void OrbitState::onEnter(Particle* particle) {
 
    particle->position = ofVec2f(ofGetWidth() / 2, ofGetHeight() / 2);
}

void OrbitState::update(Particle* particle) {
    static std::map<Particle*, float> angles;
    static std::map<Particle*, float> radii;
    static std::map<Particle*, float> directions;


    if (angles.find(particle) == angles.end()) {
        angles[particle] = ofRandom(0, TWO_PI);
        radii[particle] = ofRandom(50, 150);         
        directions[particle] = ofRandom(1) > 0.5 ? 1 : -1; 
    }


    angles[particle] += directions[particle] * 0.01f; 

    float angle = angles[particle];
    float radius = radii[particle];

    particle->position.x = ofGetWidth() / 2 + cos(angle) * radius;
    particle->position.y = ofGetHeight() / 2 + sin(angle) * radius;
}

//particle factory
Particle* ParticleFactory::createParticle(const std::string& type) {
    Particle* particle = new Particle();
    particle->type = type;

    if (type == "star") {
        particle->size = ofRandom(2, 4);
        particle->color = ofColor(255, 0, 0);
    }
    else if (type == "shooting_star") {
        particle->size = ofRandom(3, 6);
        particle->color = ofColor(0, 255, 0);
        particle->velocity *= 3;
    }
    else if (type == "planet") {
        particle->size = ofRandom(5, 8);
        particle->color = ofColor(0, 0, 255);
    }
    else if (type == "orbiter") {
        particle->size = ofRandom(4, 6);
        particle->color = ofColor(255, 255, 0);
        particle->position = ofVec2f(ofGetWidth() / 2, ofGetHeight() / 2);
        particle->velocity = ofVec2f(ofRandom(-1, 1), ofRandom(-1, 1));
    }

    return particle;
}

void ofApp::setup() {
    ofBackground(0);

    for (int i = 0; i < 100; ++i) {
        Particle* p = ParticleFactory::createParticle("star");
        particles.push_back(p);
        addObserver(p);
    }

    for (int i = 0; i < 5; ++i) {
        Particle* p = ParticleFactory::createParticle("shooting_star");
        particles.push_back(p);
        addObserver(p);
    }

    for (int i = 0; i < 10; ++i) {
        Particle* p = ParticleFactory::createParticle("planet");
        particles.push_back(p);
        addObserver(p);
    }

    for (int i = 0; i < 20; ++i) {
        Particle* p = ParticleFactory::createParticle("orbiter");
        particles.push_back(p);
        addObserver(p);
    }
}

void ofApp::update() {
    for (Particle* p : particles) {
        p->update();
    }
}

void ofApp::draw() {
    for (Particle* p : particles) {
        p->draw();
    }
}

void ofApp::keyPressed(int key) {
    if (key == 's') {
        notify("stop");
    }
    else if (key == 'a') {
        notify("attract");
    }
    else if (key == 'r') {
        notify("repel");
    }
    else if (key == 'n') {
        notify("normal");
    }
    else if (key == 'o') {
        notify("orbit");
    }
}
```
### ofApp.h
```
#pragma once

#include "ofMain.h"
#include <vector>
#include <string>

class Observer {
public:
    virtual void onNotify(const std::string& event) = 0;
};

class Subject {
public:
    void addObserver(Observer* observer);
    void removeObserver(Observer* observer);
protected:
    void notify(const std::string& event);
private:
    std::vector<Observer*> observers;
};

class Particle;

class State {
public:
    virtual void update(Particle* particle) = 0;
    virtual void onEnter(Particle* particle) {}
    virtual void onExit(Particle* particle) {}
    virtual ~State() = default;
};

class Particle : public Observer {
public:
    Particle();
    ~Particle();

    void update();
    void draw();
    void onNotify(const std::string& event) override;
    void setState(State* newState);

    ofVec2f position;
    ofVec2f velocity;
    float size;
    ofColor color;
    std::string type;

private:
    State* state;
};


class NormalState : public State {
public:
    void update(Particle* particle) override;
    virtual void onEnter(Particle* particle) override;
};


class AttractState : public State {
public:
    void update(Particle* particle) override;
};

class RepelState : public State {
public:
    void update(Particle* particle) override;
};

class StopState : public State {
public:
    void update(Particle* particle) override;
};

//nuevo estado
class OrbitState : public State {
public:
    void update(Particle* particle) override;
    void onEnter(Particle* particle) override;
private:
    float angle = 0;
};

class ParticleFactory {
public:
    static Particle* createParticle(const std::string& type);
};

class ofApp : public ofBaseApp, public Subject {
public:
    void setup();
    void update();
    void draw();
    void keyPressed(int key);
private:
    std::vector<Particle*> particles;
};
```