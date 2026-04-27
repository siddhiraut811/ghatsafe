# 🛡️ GhatSafe

> A modern, responsive Flutter mobile application with a comprehensive theming system and Material Design UI

![Flutter](https://img.shields.io/badge/Flutter-3.38.4-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-SDK-blue?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-Active%20Development-brightgreen)

---

## 🎯 About The Project

GhatSafe is a **secure, feature-rich mobile application** built with Flutter and Dart, designed to provide users with a seamless cross-platform experience. The project demonstrates modern mobile development practices with emphasis on **responsive design, theming, and clean architecture**.

### ✨ Key Highlights
- ✅ **Cross-Platform**: Works on Android & iOS from single codebase
- ✅ **Responsive Design**: Adapts perfectly to all screen sizes
- ✅ **Professional Theming**: Light & Dark mode with Material Design
- ✅ **Clean Architecture**: Well-organized, maintainable code structure
- ✅ **Production-Ready**: Includes deployment instructions

---

## 🚀 Features

### Core Features
- 📱 **Cross-Platform Support** - Android & iOS
- 🎨 **Advanced Theming System** - Light/Dark modes with customizable colors
- 📐 **Responsive Design** - Works seamlessly on phones, tablets, and tablets
- 🔄 **State Management** - Efficient data flow and management
- 🎯 **Navigation System** - Smooth routing between screens
- 📦 **Material Design** - Modern, professional UI components

### Technical Features
- 🏗️ **Modular Architecture** - Organized code structure (core, presentation, theme)
- 🎯 **Reusable Widgets** - Component-based UI development
- 🔧 **Easy Configuration** - Simple setup and customization
- 📱 **Device Optimization** - Sizer package for responsive layouts
- ⚙️ **Build Tools** - Ready for production builds

---

## 📦 Tech Stack

| Technology | Purpose |
|-----------|---------|
| **Flutter** | Mobile App Framework |
| **Dart** | Programming Language |
| **Material Design** | UI Design System |
| **Rocket.new** | Development Tools |
| **Sizer** | Responsive Design |

---

## 📋 Prerequisites

Before you begin, make sure you have the following installed:

- ✅ **Flutter SDK** (v3.38.4 or higher)
- ✅ **Dart SDK** (comes with Flutter)
- ✅ **Android Studio** or **VS Code** with Flutter extensions
- ✅ **Android SDK** / **Xcode** (for iOS development)
- ✅ **Git**

### Install Flutter
```bash
# Download from https://flutter.dev/docs/get-started/install
# Or use your package manager
brew install flutter  # macOS
sudo apt-get install flutter  # Linux
```

---

## 🔧 Installation

### Step 1: Clone the Repository
```bash
git clone https://github.com/siddhiraut811/ghatsafe.git
cd ghatsafe
```

### Step 2: Install Dependencies
```bash
flutter pub get
```

### Step 3: Run the Application
```bash
flutter run
```

### Step 4: Build for Production

#### For Android
```bash
flutter build apk --release
```

#### For iOS
```bash
flutter build ios --release
```

---

## 📂 Project Structure

```
ghatsafe/
├── lib/
│   ├── core/                 # Core utilities and constants
│   │   └── utils/           # Utility classes & functions
│   ├── presentation/         # UI & Screens
│   │   └── splash_screen/   # App splash screen
│   ├── routes/              # App navigation routes
│   ├── theme/               # Theme configuration (light/dark)
│   ├── widgets/             # Reusable UI components
│   └── main.dart            # App entry point
├── assets/                  # Images, fonts, and static files
├── pubspec.yaml             # Project dependencies
└── README.md                # Documentation
```

### Folder Descriptions
- **core/** - Business logic, utilities, and constants
- **presentation/** - UI screens and pages
- **routes/** - Navigation and routing configuration
- **theme/** - Material theme, colors, and typography
- **widgets/** - Reusable custom widgets

---

## 🎨 Theming System

GhatSafe includes a **comprehensive theming system** with light and dark modes:

### Access Theme in Code
```dart
// Get current theme
ThemeData theme = Theme.of(context);

// Use theme colors
Color primaryColor = theme.colorScheme.primary;
```

### Theme Configuration Includes
- 🎨 Color schemes (primary, secondary, background)
- 📝 Typography styles
- 🔘 Button themes
- 📝 Input decoration themes
- 🎁 Card and dialog themes

### Toggle Theme
The app automatically supports system theme settings and can be configured to allow manual theme switching.

---

## 📐 Responsive Design

The app uses the **Sizer package** for responsive layouts:

```dart
// Example: 50% of screen width
Container(
  width: 50.w,      // 50% width
  height: 20.h,     // 20% height
  child: Text('Responsive Container'),
)
```

---

## 🗺️ Adding Routes

To add new routes to the application, update `lib/routes/app_routes.dart`:

```dart
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  
  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    // Add more routes here
  };
}
```

---

## 🚀 Deployment

### Android Deployment

1. Generate signing key:
```bash
keytool -genkey -v -keystore ~/key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

2. Create `android/key.properties`:
```properties
storePassword=<password>
keyPassword=<password>
keyAlias=key
storeFile=<path-to-key.jks>
```

3. Build signed APK:
```bash
flutter build apk --release
```

### iOS Deployment

1. Open Xcode:
```bash
open ios/Runner.xcworkspace
```

2. Configure signing and build settings
3. Build for App Store:
```bash
flutter build ios --release
```

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📝 Code Style

This project follows Flutter's official style guidelines:
- Use meaningful variable names
- Add comments for complex logic
- Keep functions small and focused
- Follow the existing code structure

---

## 🙏 Acknowledgments

- Built with ❤️ using **Flutter** & **Dart**
- UI Design: **Material Design**
- Development: **Android Studio / VS Code**
- Built on **Rocket.new**
- Responsive sizing with **Sizer package**

---

## 📧 Contact & Support

- **Author**: @siddhiraut811
- **GitHub**: https://github.com/siddhiraut811/ghatsafe
- **Issues**: [Create an issue](https://github.com/siddhiraut811/ghatsafe/issues)

---

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🎓 Learn More

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design](https://material.io/design)
- [Flutter Best Practices](https://flutter.dev/docs/testing/best-practices)

---

<div align="center">

**Made with 💜 for hackathons**

⭐ If you find this useful, please star the repository!

</div>

