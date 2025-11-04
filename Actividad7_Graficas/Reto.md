# OBJETIVO
Para este reto voy a hacer una especie de caleidoscopio utilizando como base el ejemplo 4 de ejercicios, la idea es que se aleje y se acerque la imagen, cambie el patron y se distorcione con el movimiento de mouse.

Este codigo crea el efecto visual que parece un caleidoscopio en movimiento, como un arte psicodelico. Lo que hago es tomar una imagen y repetirla en forma circular, como si se reflejara en varios espejos. Cuando muevo el mouse, la imagen se deforma con ondas y cambia el zoom, y con las flechas arriba o abajo puedo aumentar o reducir el numero de partes del caleidoscopio. Con el paso del tiempo el fondo se va moviendo solo, y eso hace que todo se vea vivo y cambiante. La idea de mi reto es hacer un arte que se vea colorido y hipnotico, que se mueva y cambie constantemente

## PRUEBAS:
<video controls src="caleido.mp4" title="Title"></video>
<video controls src="clalie.mp4" title="Title"></video>
### ESTE VIDEO DE AQUI ES UN EXPERIMENTO QUE HICE, DONDE LE PUSE UNA CANCION Y LUCECITAS PARA QUE SE MUEVA SOLO LAS ONDAS:
<video controls src="Grabación 2025-10-29 220827.mp4" title="Title"></video>
En el codigo se puede hacer cargando una cancion con ofSoundPlayer y usando ofSoundGetSpectrum() para leer el volumen del audio. Ese valor se usa para reemplazar el movimiento del mouse, por ejemplo cambiando la intensidad de las ondas o el zoom segun el ritmo. Pero solo pondre el codigo de la version sin la cancion.

code: 
ofapp.cpp
```
#include "ofApp.h"

void ofApp::setup() {
    ofSetFrameRate(60);
    ofBackground(0);

    ofDisableArbTex();

    if (ofIsGLProgrammableRenderer()) {
        shader.load("shadersGL3/shader");
    }
    else {
        shader.load("shadersGL2/shader");
    }

    if (img.load("img.jpg")) {
        img.getTexture().setTextureWrap(GL_REPEAT, GL_REPEAT);
    }
    else {
        ofLogError("ofApp::setup") << "No se pudo cargar la imagen 'img.jpg'.";
        img.allocate(512, 512, OF_IMAGE_COLOR);
        img.setColor(255);
        img.update();
        img.getTexture().setTextureWrap(GL_REPEAT, GL_REPEAT);
    }

    plane.set(ofGetWidth(), ofGetHeight(), 2, 2);
    plane.mapTexCoords(0, 0, 1, 1);

    numSegments = 6.0;
    angleOffset = 0.0;
}

void ofApp::update() {

    angleOffset = ofGetElapsedTimef() * 0.1;
}

void ofApp::draw() {

    img.getTexture().bind();

    shader.begin();


    float normalizedMouseX = ofMap(mouseX, 0, ofGetWidth(), 0.0, 1.0, true);
    float normalizedMouseY = ofMap(mouseY, 0, ofGetHeight(), 0.0, 1.0, true);

    // Uniforms para el shader
    shader.setUniform2f("mouse", normalizedMouseX, normalizedMouseY);
    shader.setUniform1f("time", ofGetElapsedTimef()); 
    shader.setUniform1f("numSegments", numSegments);
    shader.setUniform1f("angleOffset", angleOffset);
    shader.setUniform2f("resolution", ofGetWidth(), ofGetHeight());

    ofPushMatrix();
    ofTranslate(ofGetWidth() / 2, ofGetHeight() / 2);
    plane.draw();
    ofPopMatrix();

    shader.end();
    img.getTexture().unbind();

    ofSetColor(255);
    string info = "FPS: " + ofToString(ofGetFrameRate(), 2) + "\n";
    info += "Segments (UP/DOWN): " + ofToString(numSegments, 0) + "\n";
    info += "Mouse X: Wave Intensity | Mouse Y: Zoom";
    ofDrawBitmapString(info, 20, 20);
}

void ofApp::keyPressed(int key) {

    if (key == OF_KEY_UP) {
        numSegments++;
    }
    if (key == OF_KEY_DOWN) {
        numSegments = max(3.0f, numSegments - 1.0f);
    }
}

void ofApp::keyReleased(int key) {}
void ofApp::mouseMoved(int x, int y) {}
void ofApp::mouseDragged(int x, int y, int button) {}
void ofApp::mousePressed(int x, y, int button) {}
void ofApp::mouseReleased(int x, y, int button) {}

void ofApp::windowResized(int w, int h) {

    plane.set(w, h, 2, 2);
    plane.mapTexCoords(0, 0, 1, 1);
}

void ofApp::gotMessage(ofMessage msg) {}
void ofApp::dragEvent(ofDragInfo dragInfo) {}
```
ofapp.h
```
#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp {
public:

    void setup();
    void update();
    void draw();

    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y);
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    void windowResized(int w, int h);
    void dragEvent(ofDragInfo dragInfo);
    void gotMessage(ofMessage msg);

    ofShader shader;
    ofPlanePrimitive plane;
    ofImage img;

    // Parámetros de control para el caleidoscopio
    float numSegments; // Número de segmentos (controlado por teclado)
    float angleOffset; // Desplazamiento de ángulo (para rotación en el tiempo)
};
```
shader.vert
```
#version 150

in vec4 position;
in vec2 texcoord;

out vec2 vTexCoord;

// Uniforms
uniform mat4 modelViewProjectionMatrix;
// Aunque no se usa aquí, se declara si se pasa por el pipeline (es mejor ponerlo en el frag)
// uniform float time; 

void main() {
    gl_Position = modelViewProjectionMatrix * position;

    vTexCoord = texcoord;
}
```
shader.frag
```
#version 150

in vec2 vTexCoord;

// Uniforms
uniform sampler2D tex0;         
uniform vec2 resolution;        
uniform vec2 mouse;             
uniform float numSegments;      
uniform float angleOffset;      
uniform float time;      
desde ofApp.cpp

out vec4 fragColor;

const float PI = 3.14159265359;

void main() {
    
    vec2 pos = vTexCoord - 0.5;
    pos.x *= resolution.x / resolution.y; 

    //mouse interaccion
    
    float waveIntensity = mouse.x * 0.15; 

    float zoomFactor = 0.5 + 2.5 * mouse.y; 
    vec2 distortedPos = pos;
    
    distortedPos.x += cos(pos.y * 15.0 + time * 3.0) * waveIntensity;

    distortedPos.y += sin(pos.x * 12.0 + time * 2.5) * waveIntensity;

    pos = distortedPos;

    
    // Desplazamiento del centro
    vec2 centerOffset = (mouse - 0.5) * 0.7; 
    pos -= centerOffset; 

    //zoom
    pos *= zoomFactor; 
    
    float r = length(pos); 
    float a = atan(pos.y, pos.x); 

    float segmentAngle = 2.0 * PI / numSegments;
    a = mod(a + angleOffset, 2.0 * PI); 
    a = abs(a - segmentAngle * floor(a / segmentAngle + 0.5));
    a = abs(a - segmentAngle * 0.5);

    vec2 finalTexCoord = vec2(r * cos(a), r * sin(a));

    finalTexCoord = finalTexCoord + 0.5; 

    fragColor = texture(tex0, finalTexCoord);
}
```