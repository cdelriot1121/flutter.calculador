# Guía y Documentación de la Calculadora Analítica
## Arquitectura Layer-First en Flutter


---

## 1. ¿Qué es la Arquitectura "Layer-First"?

En el desarrollo de software, organizar el código es fundamental para que no se convierta en un caos. La arquitectura **Layer-First (Capas Primero)** organiza tu proyecto dividiéndolo por **responsabilidades o capas tecnológicas**, en lugar de agruparlo por pantallas o funcionalidades individuales (que sería *Feature-First*).

Imagina una pastelería organizada por capas:
1. **La cocina (Capa de Dominio/Lógica):** Donde se mezclan los ingredientes y se preparan las recetas. No sabe quién se comerá el pastel, solo sabe cómo hacerlo a la perfección.
2. **El mesero (Capa de Proveedores/Estado):** Toma el pedido del cliente, va a la cocina, trae el pastel y avisa cuando está listo. Es el puente.
3. **Las mesas y la vajilla (Capa de Vista/UI):** Lo que el cliente ve y toca (los platos, las pantallas, los botones).

### Beneficios principales:
* **Fácil de entender:** Sabes exactamente dónde buscar. Si hay un error matemático, vas a `domain`. Si hay un botón mal diseñado, vas a `widgets` o `views`.
* **Desacoplamiento:** La lógica matemática está totalmente separada del diseño visual. ¡Podrías cambiar toda la interfaz visual y la matemática seguiría funcionando intacta!
* **Código limpio y testeable:** Es extremadamente fácil escribir pruebas unitarias para la lógica matemática porque no depende de pantallas de teléfono.

---

## 2. Estructura de Carpetas de tu Proyecto

Tu código principal vive dentro de la carpeta `lib/` y sigue esta distribución:

```text
lib/
├── main.dart                       # El punto de partida de la aplicación
├── domain/                         # Capa 1: Lógica matemática pura (Reglas de negocio)
│   └── calculator_logic.dart       
├── providers/                      # Capa 2: Gestor del Estado (El puente)
│   └── calculator_provider.dart    
├── views/                          # Capa 3: Pantallas principales de la interfaz
│   └── calculator_view.dart        
└── widgets/                        # Capa 4: Componentes visuales pequeños y reutilizables
    ├── number_analysis_card.dart   
    └── result_card.dart            
```

---

## 3. Guía de Flutter para Principiantes: ¿Qué es un Widget?

En Flutter, **"Todo es un Widget"**. Un widget es la unidad básica con la que construyes la interfaz de usuario. Son como bloques de LEGO: los combinas para crear botones, textos, formularios y pantallas completas.

Al explorar el código de Flutter, te encontrarás con dos tipos fundamentales de Widgets:

### A. StatelessWidget (Widget Sin Estado)
* **¿Qué es?** Es un widget estático. Una vez que se dibuja en la pantalla, **no cambia por sí mismo**. No recuerda nada ni tiene memoria interna de cosas que cambien en el tiempo.
* **Metáfora:** Imagina un cartel o póster impreso en una pared. Muestra información (un título, una imagen), pero si quieres cambiar lo que dice, tienes que quitar el cartel y poner uno nuevo con la nueva información.
* **En tu proyecto:** `ResultCard` (la tarjeta que muestra el resultado de la operación) y `NumberAnalysisCard` (la tarjeta que analiza las propiedades del número) son `StatelessWidgets`. Reciben datos y los muestran en pantalla de forma bonita, nada más.

### B. StatefulWidget (Widget Con Estado)
* **¿Qué es?** Es un widget dinámico. Tiene una "memoria interna" llamada **State (Estado)**. Puede cambiar su aspecto visual en respuesta a eventos del usuario (como escribir en un campo de texto, marcar una casilla o mover un control deslizante) sin necesidad de reconstruir toda la aplicación desde fuera.
* **Metáfora:** Imagina una pizarra mágica o un interruptor de luz. El interruptor recuerda si está en "encendido" o "apagado" y cambia su apariencia física en consecuencia cuando lo presionas.

### El truco inteligente de tu proyecto 💡
Te habrás dado cuenta de que tu pantalla principal `CalculatorView` es un **`StatelessWidget`**, pero... **¡la pantalla cambia y muestra nuevos resultados cuando calculamos!** ¿Cómo es posible si un `StatelessWidget` es estático?

Aquí es donde entra la magia del paquete **Provider**:
Instead de usar un `StatefulWidget` complejo que mezcle la lógica visual con la matemática, tu pantalla `CalculatorView` se mantiene como un widget simple (`StatelessWidget`) y delega toda su memoria a un objeto externo: el **`CalculatorProvider`**.
Cuando el `CalculatorProvider` detecta que un resultado cambió, le da un "toque" a la pantalla y Flutter redibuja la interfaz de forma eficiente con los nuevos datos. Esto mantiene tu código súper limpio y profesional.

---

## 4. Análisis Profundo de los Archivos y sus Funciones

A continuación, analizamos cada archivo de tu proyecto para entender qué hace y qué funciones principales contiene.

### Capa 1: Dominio (`lib/domain/calculator_logic.dart`)
Esta es la **"mente analítica"** de la calculadora. Es código Dart puro y directo. No sabe nada de teléfonos, pantallas, colores ni botones. Solo sabe matemáticas.

#### Estructuras de Datos (Clases de Apoyo):
* **`CalculationResult`:** Representa el resultado de una operación. Guarda el `value` (un número decimal) y opcionalmente un `error` (un mensaje de texto si algo sale mal, como dividir por cero).
* **`NumberProperties`:** Estructura que almacena el análisis de un número individual: si es par (`isEven`), si es primo (`isPrime`), y si pertenece a la serie de Fibonacci (`isFibonacci`).

#### Funciones Matemáticas Principales (`CalculatorLogic`):
* **`add(a, b)`**, **`subtract(a, b)`**, **`multiply(a, b)`**: Operaciones aritméticas básicas de suma, resta y multiplicación.
* **`divide(a, b)`**: Realiza la división asegurándose de que el divisor `b` no sea `0`. Si es cero, devuelve un error controlado: `"No se puede dividir por cero"`.
* **`power(base, exponent)`**: Calcula la potencia (por ejemplo $2^3 = 8$) usando matemáticas nativas de Dart.
* **`root(number, nRoot)`**: Calcula la raíz enésima de un número. Incluye reglas lógicas estrictas para evitar errores de números imaginarios (como raíces pares de números negativos).
* **`log(number, base)`**: Calcula el logaritmo de un número en una base específica mediante matemáticas de cambio de base ($\log_b(a) = \ln(a) / \ln(b)$). Valida que la base sea mayor a 0 y diferente de 1, y el argumento mayor a 0.
* **`analyzeNumber(number)`**: ¡Una de las mejores características! Toma un número y analiza tres cosas:
  1. **Si es Par:** Comprueba si el número es entero y si el residuo de dividirlo entre 2 es cero.
  2. **Si es Primo:** Si el número es un entero positivo mayor que 1, ejecuta un algoritmo eficiente de bucle para verificar si tiene divisores aparte del 1 y sí mismo.
  3. **Si es Fibonacci:** Compara el número con una lista predefinida (`fibonacci20`) que contiene los primeros 20 números de la famosa sucesión de Fibonacci (0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...).

---

### Capa 2: Gestor de Estado (`lib/providers/calculator_provider.dart`)
Este archivo actúa como el **"cerebro operativo"** o el director de orquesta. Es la clase `CalculatorProvider` y hereda de `ChangeNotifier`. Su trabajo es conectar lo que escribe el usuario con la lógica matemática y avisar a la interfaz de usuario cuando hay cambios.

#### Propiedades del Estado:
* **`num1Controller` y `num2Controller`:** Controladores especiales (`TextEditingController`) que leen en tiempo real lo que el usuario escribe en las cajas de texto de la pantalla.
* **`_result`**: Almacena el resultado del cálculo actual.
* **`_errorMessage`**: Guarda el mensaje de error si ocurre algún fallo (por ejemplo, campos vacíos o divisiones inválidas).
* **`_selectedOperation`**: Almacena la operación seleccionada actualmente (por defecto es `+`).
* **`_propsNum1` y `_propsNum2`**: Guardan los resultados del análisis matemático de ambos números ingresados.

#### Funciones Clave:
* **`setOperation(String op)`**: Cambia la operación matemática activa (como pasar de suma `+` a potencia `^`). Llama a la función especial `notifyListeners()`, que le dice a toda la interfaz de usuario: *"¡Oigan, el usuario cambió de operación! Por favor, actualicen el diseño visual"*.
* **`calculate()`**: La función principal de control. Realiza los siguientes pasos de forma secuencial:
  1. Limpia cualquier resultado o error previo.
  2. Intenta convertir los textos ingresados por el usuario en números decimales (`double.tryParse`).
  3. Si faltan datos o se escribe algo que no es un número, activa un mensaje de error y detiene el proceso.
  4. Si los números son válidos, llama a `CalculatorLogic.analyzeNumber()` para analizar detalladamente las propiedades matemáticas de ambos valores de entrada.
  5. Ejecuta un bloque `switch` según la operación seleccionada (`+`, `-`, `*`, `/`, `^`, `√`, `log`) para invocar el método matemático correcto en `CalculatorLogic`.
  6. Guarda el resultado o el mensaje de error correspondiente.
  7. Finalmente, llama a `notifyListeners()` para actualizar instantáneamente todos los widgets de la pantalla.

---

### Capa 3: Interfaz de Pantalla (`lib/views/calculator_view.dart`)
Esta es la **"carcasa o estructura"** de tu calculadora. Es un `StatelessWidget` que pinta el fondo oscuro moderno, la barra superior (AppBar) y estructura toda la interfaz mediante un diseño vertical enrollable (`SingleChildScrollView`).

#### ¿Cómo interactúa con el Estado?
Utiliza un widget especial llamado **`Consumer<CalculatorProvider>`**. Este componente actúa como una antena receptora:
* Escucha atentamente al `CalculatorProvider`.
* Cada vez que el proveedor ejecuta `notifyListeners()`, el `Consumer` se entera inmediatamente y vuelve a dibujar únicamente las secciones de la interfaz que dependen de los datos modificados.

#### Widgets Internos Reutilizables en la Pantalla:
* **`_buildTextField(...)`**: Función que genera campos de entrada de texto estéticamente pulidos, con bordes redondeados, iconos morados y configuración de teclado numérico adaptado para decimales y signos negativos.
* **`_buildOperationSelector(...)`**: Genera dinámicamente un conjunto de botones interactivos tipo burbuja (`ChoiceChip`) basados en la lista de operaciones disponibles. Marca de forma resaltada en color morado la operación activa.
* **`_buildErrorCard(...)`**: Dibuja un banner rojo moderno con un icono de advertencia si la aplicación detecta una operación inválida.

---

### Capa 4: Componentes Reutilizables (`lib/widgets/`)
Son pequeñas piezas independientes de diseño que se enfocan en hacer una sola tarea visual muy bien.

* **`ResultCard` (`lib/widgets/result_card.dart`):** Un widget visualmente hermoso con un degradado lineal (morado oscuro a azul marino) y sombras elevadas que destaca el resultado final con un tamaño de letra imponente (40pt).
* **`NumberAnalysisCard` (`lib/widgets/number_analysis_card.dart`):** Una tarjeta dedicada a mostrar el análisis de propiedades de un número.
  * Muestra de forma limpia si el número analizado es par, primo o pertenece a Fibonacci.
  * Utiliza indicadores circulares verdes con un símbolo de verificación (`✓`) si es verdadero, o rojos con una cruz (`✗`) si es falso, acompañados de las palabras "Sí" o "No" coloreadas adecuadamente.

---

## 5. El Flujo de una Operación (Paso a Paso)

Para terminar de entender cómo encaja todo, sigamos el viaje de los datos cuando realizas una operación, por ejemplo, calcular **raíz cuadrada de -4**:

```text
 [ Usuario ]
      │
      ▼  (Escribe -4 e ingresa 2 en el segundo campo; selecciona raíz '√')
 1. [ calculator_view.dart ]  ──► Captura el evento del botón "Calcular"
      │
      ▼  (Llama a calculate())
 2. [ calculator_provider.dart ] ──► Lee textos (-4 y 2), los valida y parsea
      │
      ├───► Llama a CalculatorLogic.analyzeNumber(-4) y analyzeNumber(2)
      │
      ├───► Llama a CalculatorLogic.root(-4, 2)
      │          │
      │          ▼  (Lógica de negocio en calculator_logic.dart)
      │     [ CalculatorLogic ] ──► Detecta: número negativo con raíz par (2) es imaginario.
      │                             Devuelve un error: "Raíz par de un número negativo no es real".
      │
      ▼  (Recibe el error en el Provider)
 3. [ calculator_provider.dart ] ──► Guarda el error en '_errorMessage'
      │                              Llama a notifyListeners()
      │
      ▼  (Notifica a la interfaz)
 4. [ calculator_view.dart ] ──► El Consumer detecta la notificación y se redibuja.
                                 Oculta el ResultCard (porque result es null).
                                 Muestra el ErrorCard de color rojo en pantalla con el texto recibido.
```

¡Y listo! Gracias a la separación limpia de **Capas (Layer-First)** y el uso de **Provider**, el código de tu calculadora es un ejemplo excelente de arquitectura de software móvil profesional: limpio, escalable, fácil de mantener y hermoso.
