# MyCalculator (UIKit · MVVM · Clean Architecture)
Home screen:  
<img width="1290" height="2796" alt="image" src="https://github.com/user-attachments/assets/60a63571-28a4-4144-abf2-48b814a2311d" />


Calcultor:  
<img width="1290" height="2796" alt="image" src="https://github.com/user-attachments/assets/756d1222-f032-47a0-8588-9101b3cd0592" />


Units converter:  
<img width="1290" height="2796" alt="image" src="https://github.com/user-attachments/assets/223972d7-9adf-4029-878f-a1e37b60eaf3" />


Select units screen:  
<img width="1290" height="2796" alt="image" src="https://github.com/user-attachments/assets/99e02cc8-8c86-4066-9320-42d9c6511c4a" />



**MyCalculator** es una aplicación construida con **UIKit**, pensada como una base limpia y escalable para el desarrollo de proyectados pensados en tener pantallas reactivas con las entradas del usuario.  
El objetivo es crear una aplicación capaz de calcular una expresion ingresada por el usuario con los botones que se muestran en su pantalla, estos calculos se hacen al momento por lo que el usuario puede recibir una respuesta instantanea a sus cambios. Tambien se tiene un modo para convertir unidades, dentro de la aplicacion se tiene un catalogo de unidades con las cuales el usuario puede visualizar al momento su conversion en otra unidad. Al utilizar una misma pantalla y un selector se busca que la rapidez y efectividad en los calculos o la conversion.  

Demo of the app:
- [demo](https://youtube.com/shorts/IPpVPeTg1tI)

---

## Tech Stack 🚀
- **Language:** Swift
- **UI Framework:** UIKit (Storyboard)
- **Architecture:** MVVM + Clean-ish Layers (Domain / Data / Presentation)
- **Reactive:** Combine (para bindings de ViewModel → ViewController)
- **Testing:** XCTest (unit tests para UseCases, ViewModel y Repositorios)
- **Dependency Injection:** DIContainer simple por constructor/inyección posterior

---

## Features (versión offline) 🧩
- Conversor de unidades offline (datos mock).
- Arquitectura modular preparada para añadir una capa remota (API) sin cambiar UI.
- Calculo de expresiones matematicas con operaciones sencillas ( +, -, *, /) al momento.
- Selector para cambiar modos de calculadora, por el momento se tienen dos modos disponibles que son el de la calculadora y el conversor de unidades.
- UI llamativa utilizando un diseño moderno y minimalista.
- Tests unitarios para la lógica de conversión y el ViewModel.
- Coordinator (`AppCoordinator`) para orquestar flujos de navegación.
- Formateo localizable.

---

## Que se busca en esta aplicación ✅
- **Separación clara de responsabilidades:** Presentation (VC/VM), Domain (UseCases), Data (Repositories).
- **Test coverage** incluye lógica crítica (conversiones, calculo) y bindings (ViewModel).
- **DI-friendly design** — fácil de sustituir mocks por implementaciones reales en CI.
- **Scalable foundation** — preparada para autenticación, cache, sincronización y features avanzadas.
- **Responsive UI** - fuerte comunicacion entre capas para actualizar UI con cada cambio. 

---

## Project Structure (resumen) 🗂
CurrencyConverter/  
├── App/ # AppDelegate, SceneDelegate, AppCoordinator, DIContainer  
├── Presentation/ # Modules: Calculator (VC / ViewModel / Views)  
├── Domain/ # Entities, UseCases, Repository interfaces  
├── Data/ # Repositories (Mock / Remote future)  
├── Resources/ # Assets, Storyboards  
└── Tests/ # Unit tests (XCTest)  

---

## Cómo ejecutar 🛠️
- Se recomienda utilizar Xcode 14+.
- Ejecutar con Xcode.
- Para correr tests: `⌘U` o desde el menú `Product → Test`.

---

## Tests incluidos 🧪
- `MyCalculatorTests` — pruebas de conversion de unidades y de calculo de expresiones matematicas.

---

## Autor ✒️
- Ian Axel de la Torre - Desarrollo completo - [IandelaTorre](https://github.com/IandelaTorre).

---

## Próximos pasos / mejoras 📈
- Integrar `RemoteUnitsRepository` (URLSession/async-await).
- Mejora visual de botones para seleccionar unidades y validaciones de seleccion de unidades.
- Boton para cambiar posicion de unidades que fueron seleccionadas para la conversion.
- Mejoras visuales en la UI contemplando los casos para el modo oscuro. 
- CI: GitHub Actions pipeline para ejecutar tests en cada PR.

---

⌨️ con ❤️ por [IandelaTorre](https://github.com/IandelaTorre) 😊

