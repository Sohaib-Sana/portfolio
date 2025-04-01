# Sohaib Portfolio

A responsive Flutter portfolio application implementing a modern UI.

## Features

- 🔄 **Responsive Design**: Adapts to mobile, tablet, and desktop screens
- 🎨 **Modern UI**: Clean and elegant design with animations
- 🌙 **Dark/Light Mode**: Toggle between dark and light themes
- 🧱 **BLoC Architecture**: Proper state management using the BLoC pattern
- ⚡ **Optimized Performance**: Memory-efficient implementation with minimal widget rebuilds
- 📱 **Cross Platform**: Works on web, Android, iOS, and desktop
- 🔧 **Modular Code**: Well-structured and maintainable codebase

## Getting Started

### Prerequisites

- Flutter SDK (3.0 or above)
- Dart SDK (3.0 or above)
- An IDE (VS Code, Android Studio, etc)

### Installation

1. Clone the repository:

```bash
git clone https://github.com/Sohaib-Sana/sohaib_portfolio.git
```

2. Navigate to the project folder:

```bash
cd sohaib_portfolio
```

3. Install dependencies:

```bash
flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Project Structure

The project follows a clean architecture with proper separation of concerns:

```
lib/
├── core/                  # Core functionalities
│   ├── constants/         # App constants (colors, styles, etc.)
│   ├── theme/             # Theme configuration
│   └── utils/             # Utilities and helpers
├── data/                  # Data layer
│   └── models/            # Data models
├── presentation/          # UI layer
│   ├── bloc/              # BLoC state management
│   ├── widgets/           # Reusable widgets
│   └── screens/           # App screens
└── main.dart              # App entry point
```

## Key Components

### Responsive Design

The app uses a custom responsive framework that adapts the UI based on screen size:

- `ResponsiveHelper`: Utility class for responsive layouts
- `Responsive` widget: Wrapper to display different widgets based on screen size

### BLoC State Management

State is managed using the BLoC pattern with events and states:

- `ThemeBloc`: Manages app theme (dark/light mode)
- `PortfolioBloc`: Manages portfolio data (projects, experience, etc.)

### Animations

The app includes several optimized animations:

- Type-writer animation for text
- Hover effects on cards
- Staggered animations for lists
- Fade and slide transitions

### Performance Optimization

Several optimizations are implemented:

- Lazy loading
- Minimal rebuilds with const widgets
- Memory-efficient image loading
- Optimized animations

## Customization

### Changing Content

To update the portfolio content, modify the following files:

- `data/models/project_model.dart`: Update project details
- `data/models/experience_model.dart`: Update work experience
- Replace images in `assets/images/` directory

### Theming

To customize the app's theme:

- `core/constants/app_colors.dart`: Update the color palette
- `core/constants/app_text_styles.dart`: Update typography
- `core/theme/app_theme.dart`: Modify theme settings

## License

No license is issued yet

## Acknowledgements

- Design inspiration: [Menna Allah Mohamed's Portfolio](https://mennamohamed97.github.io/)
