#  ACTIVIDAD 1
## PREGUNTAS

### 1. ¿Qué son los vértices?
Los vértices son puntos que marcan las esquinas o uniones de las figuras 3D. Cada vértice tiene una posición en el espacio y sirve para construir las formas de los objetos. Por ejemplo, si unes tres vértices, formas un triángulo, y con muchos triángulos puedes hacer un modelo 3D completo.

### 2. ¿Con qué figura geométrica se dibuja en 3D?
En 3D todo se dibuja usando triángulos. Los triángulos se usan porque son figuras muy estables y fáciles de calcular. Cualquier forma más compleja se puede dividir en muchos triángulos pequeños para que la computadora pueda procesarla rápido.

### 3. ¿Qué es un shader?
Un shader es un programa pequeño que corre dentro de la tarjeta gráfica (GPU). Se encarga de hacer cálculos especiales, como mover vértices, aplicar luces o dar color a los objetos. Hay distintos tipos de shaders, dependiendo de la parte del dibujo que controlen.

### 4. ¿Cómo se le llaman a los grupos de píxeles de un mismo triángulo?
Se les llama fragmentos. Cada fragmento representa un píxel del triángulo que aparece en la pantalla. Luego, cada fragmento pasa por un proceso para saber su color y si realmente se va a mostrar o no.

### 5. ¿Qué es un fragment shader?
El fragment shader es el programa que decide el color final de cada fragmento o píxel. Ahí se aplican efectos como sombras, luces, reflejos o texturas para que el objeto se vea más realista.

### 6. ¿Qué es un vertex shader?
El vertex shader es el programa que se encarga de procesar los vértices. Toma los puntos del modelo 3D y los transforma para que aparezcan bien ubicados en la pantalla. Básicamente, convierte la posición 3D en una posición 2D visible.

### 7. ¿Al proceso de determinar qué píxeles del display va a cubrir cada triángulo de una mesh se le llama?
Ese proceso se llama rasterización. Ahí la GPU convierte los triángulos en los píxeles o fragmentos que se van a mostrar. Es como pasar de una figura 3D a una imagen 2D formada por píxeles.

### 8. ¿Qué es el render pipeline?
El render pipeline es toda la cadena de pasos que hace la GPU para transformar los modelos 3D en una imagen. Empieza con los vértices, sigue con los triángulos, luego los convierte en píxeles, y al final muestra el resultado en pantalla.

### 9. ¿Hay alguna diferencia entre aplicar un color a una superficie de una mesh o aplicar una textura?
Sí. Si aplicas solo un color, toda la superficie queda igual. En cambio, una textura es una imagen que se pega sobre la superficie y puede tener muchos detalles, como madera, metal o piel. La textura hace que se vea más real.

### 10. ¿Cuál es la diferencia entre una textura y un material?
La textura es solo una imagen, mientras que el material combina varias cosas como el color, la rugosidad, la reflexión, etc. Un material usa texturas para definir cómo se ve una superficie según la luz o el ángulo de la cámara.

### 11. ¿Qué transformaciones se requieren para mover un vértice del 3D world al View Screen?
Primero se hace la transformación del mundo (World Transform), que coloca el objeto en su posición dentro del escenario. Luego viene la vista (View Transform), que es como mover la cámara para ver desde cierto ángulo. Y por último está la proyección (Projection Transform), que convierte todo a una vista 2D para mostrarlo en la pantalla.

### 12. ¿Al proceso de convertir los triángulos en fragmentos se le llama?
Ese proceso también se llama rasterización. Es el paso donde los triángulos se transforman en fragmentos o píxeles que luego se pintan con color o textura.

### 13. ¿Qué es el framebuffer?
El framebuffer es una parte de la memoria donde la GPU guarda la imagen final antes de mostrarla. Es como un borrador donde se van acumulando los colores de cada píxel y al final se envía todo junto al monitor.

### 14. ¿Para qué se usa el Z-buffer o depth buffer en el render pipeline?
El Z-buffer se usa para saber qué objeto está más cerca de la cámara. Cuando dos triángulos se cruzan, el Z-buffer compara sus profundidades y muestra solo el que está al frente, evitando que los del fondo se vean por encima.

### 15. ¿Por qué la GPU tiene que funcionar tan rápido y de manera paralela?
Porque en una escena 3D hay millones de vértices y píxeles que se calculan al mismo tiempo. Si la GPU trabajara como la CPU (uno por uno), tardaría muchísimo. En cambio, la GPU puede procesar miles de fragmentos y vértices al mismo tiempo, lo que permite que los juegos y animaciones se vean fluidos y en tiempo real.