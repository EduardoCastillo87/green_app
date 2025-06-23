# GreenApp - Tu Guía de Alimentación Saludable

Una aplicación Flutter moderna y elegante diseñada para ayudarte a mantener una alimentación saludable y equilibrada.

## Características

- **Login Seguro**: Interfaz de inicio de sesión con validación de formularios
- **Diseño Moderno**: UI/UX atractiva con gradientes y animaciones suaves
- **Tema Verde**: Paleta de colores inspirada en la naturaleza y la salud
- **Responsive**: Diseño adaptable a diferentes tamaños de pantalla

## Funcionalidades Implementadas

### Pantalla de Login
- Validación de correo electrónico
- Validación de contraseña (mínimo 6 caracteres)
- Mostrar/ocultar contraseña
- Indicador de carga durante el proceso de login
- Enlaces para registro y recuperación de contraseña

### Pantalla Principal
- Dashboard con tarjetas de funcionalidades
- Navegación intuitiva
- Botón de logout
- Diseño de cuadrícula responsive

## Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada de la aplicación
├── constants/
│   └── app_colors.dart      # Constantes de colores
├── screens/
│   ├── login_screen.dart    # Pantalla de login
│   └── home_screen.dart     # Pantalla principal
├── widgets/                 # Widgets reutilizables (futuro)
├── models/                  # Modelos de datos (futuro)
└── services/               # Servicios y APIs (futuro)
```

## Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo multiplataforma
- **Dart**: Lenguaje de programación
- **Material Design**: Sistema de diseño de Google

## Instalación y Ejecución

1. Asegúrate de tener Flutter instalado en tu sistema
2. Clona este repositorio
3. Ejecuta `flutter pub get` para instalar las dependencias
4. Ejecuta `flutter run` para iniciar la aplicación

## Próximas Funcionalidades

- [ ] Sistema de registro de usuarios
- [ ] Base de datos de recetas saludables
- [ ] Calculadora de calorías
- [ ] Seguimiento de progreso nutricional
- [ ] Lista de compras inteligente
- [ ] Notificaciones de recordatorio
- [ ] Integración con APIs de nutrición

## Contribución

¡Las contribuciones son bienvenidas! Por favor, abre un issue o un pull request para sugerir mejoras o reportar bugs.

## Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.
