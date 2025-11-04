# RETO
Para este reto planteare crear un jardin interactivo en donde uno pueda cambiar el estado de las flores, ya sea que sean semillas, tallos, que florescan o marchitarlas.
### PRUEBAS:
<video controls src="al,dam,,amd.mp4" title="Title"></video>

<video controls src="Grabación 2025-10-09 082946.mp4" title="Title"></video>

### FINAL
<video controls src="awdhb flkamd.mp4" title="Title"></video>
```
#include "ofApp.h"

void Subject::addObserver(Observer* observer) {
    observers.push_back(observer);
}

void Subject::removeObserver(Observer* observer) {
    observers.erase(remove(observers.begin(), observers.end(), observer), observers.end());
}

void Subject::notify(const std::string& event) {
    for (auto& obs : observers) {
        obs->onNotify(event);
    }
}


// Plant
Plant::Plant() {
    growth = 0.0f;
    size = 10.0f;
    color = ofColor::green;
    position.set(ofRandomWidth(), ofRandomHeight());
    state = new SeedState();
    state->onEnter(this);
}

Plant::~Plant() {
    delete state;
}

void Plant::update() {
    if (state) state->update(this);
}

void Plant::draw() {
    if (state) state->draw(this);
}

void Plant::onNotify(const std::string& event) {
    if (event == "grow") {
        setState(new GrowingState());
    }
    else if (event == "bloom") {
        setState(new BloomingState());
    }
    else if (event == "wither") {
        setState(new WitheredState());
    }
}

void Plant::setState(PlantState* newState) {
    delete state;
    state = newState;
    state->onEnter(this);
}


// Estados
void SeedState::onEnter(Plant* plant) {
    plant->growth = 0.0f;
    plant->color = ofColor::brown;
}

void SeedState::update(Plant* plant) {
    plant->growth += 0.01f;
    if (plant->growth > 1.0f) {
        plant->setState(new GrowingState());
    }
}

void SeedState::draw(Plant* plant) {
    ofSetColor(plant->color);
    ofDrawCircle(plant->position, plant->size * 0.5);
}

void GrowingState::update(Plant* plant) {
    plant->growth += 0.02f;
    if (plant->growth > 3.0f) {
        plant->setState(new BloomingState());
    }
}

void GrowingState::draw(Plant* plant) {
    ofSetColor(0, 255, 0);
    ofDrawRectangle(plant->position.x - 2, plant->position.y - plant->growth * 20, 4, plant->growth * 20);
}

void BloomingState::update(Plant* plant) {
    plant->growth += 0.01f;
    if (plant->growth > 5.0f) {
        plant->setState(new WitheredState());
    }
}

void BloomingState::draw(Plant* plant) {
    // Tallo
    ofSetColor(0, 200, 0);
    ofDrawRectangle(plant->position.x - 2, plant->position.y - 60, 4, 60);

    // Flor
    ofSetColor(ofColor::fromHsb(ofRandom(0, 255), 255, 255));
    ofDrawCircle(plant->position.x, plant->position.y - 70, 15);
}

void WitheredState::update(Plant* plant) {
    plant->growth -= 0.01f;
    if (plant->growth < 0.5f) {
        plant->setState(new SeedState());
    }
}

void WitheredState::draw(Plant* plant) {
    ofSetColor(139, 69, 19);
    ofDrawRectangle(plant->position.x - 2, plant->position.y - 40, 4, 40);
}


// PlantFactory
Plant* PlantFactory::createPlant(const std::string& type) {
    Plant* plant = new Plant();
    plant->type = type;
    return plant;
}


//Environment y EnvironmentFactory
class Environment {
public:
    void drawBackground() {
        ofBackground(135, 206, 235); //color fondo
    }

    void drawSun() {
        float t = ofGetElapsedTimef();
        float radius = 50 + sin(t * 2) * 5; //respiracion sol
        ofSetColor(255, 255, 0);
        ofDrawCircle(ofGetWidth() - 100, 100, radius);
    }
};

class EnvironmentFactory {
public:
    static Environment* createEnvironment() {
        return new Environment();
    }
};


// ofApp
std::vector<Environment*> environments; 

void ofApp::setup() {
    // Crear entorno
    Environment* env = EnvironmentFactory::createEnvironment();
    environments.push_back(env);

    // Crear algunas plantas
    for (int i = 0; i < 5; i++) {
        Plant* plant = PlantFactory::createPlant("generic");
        addObserver(plant);
        plants.push_back(plant);
    }
}

void ofApp::update() {
    for (auto& plant : plants) {
        plant->update();
    }
}

void ofApp::draw() {
    // Dibuja el entorno
    for (auto& env : environments) {
        env->drawBackground();
        env->drawSun();
    }

    // Dibuja las plantas
    for (auto& plant : plants) {
        plant->draw();
    }
}

void ofApp::keyPressed(int key) {
    if (key == '1') notify("grow");
    if (key == '2') notify("bloom");
    if (key == '3') notify("wither");
}


```
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


class Plant; 

class PlantState {
public:
    virtual void update(Plant* plant) = 0;
    virtual void draw(Plant* plant) {}
    virtual void onEnter(Plant* plant) {}
    virtual ~PlantState() = default;
};

//Clase Planta 
class Plant : public Observer {
public:
    Plant();
    ~Plant();

    void update();
    void draw();
    void onNotify(const std::string& event) override;
    void setState(PlantState* newState);

    ofVec2f position;
    float size;
    ofColor color;
    float growth;
    std::string type;

private:
    PlantState* state;
};

//Estados de la planta
class SeedState : public PlantState {
public:
    void update(Plant* plant) override;
    void draw(Plant* plant) override;
    void onEnter(Plant* plant) override;
};

class GrowingState : public PlantState {
public:
    void update(Plant* plant) override;
    void draw(Plant* plant) override;
};

class BloomingState : public PlantState {
public:
    void update(Plant* plant) override;
    void draw(Plant* plant) override;
};

class WitheredState : public PlantState {
public:
    void update(Plant* plant) override;
    void draw(Plant* plant) override;
};

//Patrón Factory
class PlantFactory {
public:
    static Plant* createPlant(const std::string& type);
};

//Clase Principal
class ofApp : public ofBaseApp, public Subject {
public:
    void setup();
    void update();
    void draw();
    void keyPressed(int key);

private:
    std::vector<Plant*> plants;
};

```