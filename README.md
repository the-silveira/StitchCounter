# 🧶 StitchCounter – Crochet Helper App

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-2.17+-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Platform](https://img.shields.io/badge/Platform-Android-blue.svg)

A simple, elegant crochet helper app for tracking stitches and rounds. Designed for crocheters who need a hands-free, easy-to-use counter while working on their projects.

---

## ✨ Features

### 🎯 Easy-to-Use Interface
- **Split-screen design**: Left side for stitches, right side for rounds
- **Full-screen tap areas**: Tap anywhere on each side to increment
- **Landscape mode**: Optimized for tablets and phones
- **Visual feedback**: Color changes on tap for confirmation

### 🎨 Beautiful Design
- **Forest green theme**: Soothing, nature-inspired color scheme
- **Material 3 design**: Modern Flutter Material 3 theming
- **Contrasting panels**: Light stitches panel vs dark rounds panel
- **Elegant app bar**: Leaf icons and clean typography

### 🔧 Functionality
- **Independent counters**: Separate stitch and round counters
- **One-tap increment**: Tap the side you want to increase
- **Quick reset**: Small reset buttons for each counter
- **Full reset**: App bar button to reset both counters
- **Persistent state**: Counters maintain their values during use

---

## 📱 Screenshots

| Stitches Counter | Rounds Counter |
|------------------|----------------|
| Light green background with dark green counter | Dark green background with light counter |

---

## 🚀 Getting Started

### Prerequisites
- Flutter 3.0.0 or higher  
- Dart 2.17.0 or higher  
- Android Studio or VS Code  

### Installation

1. Clone the repository  
   ```bash
   git clone https://github.com/yourusername/stitchcounter.git
   cd stitchcounter
   ```

2. Get dependencies  
   ```bash
   flutter pub get
   ```

3. Generate app icons (optional)  
   ```bash
   flutter pub run flutter_launcher_icons:main
   ```

4. Run the app  
   ```bash
   flutter run
   ```

---

## 📦 Building for Release

### Android APK
```bash
flutter build apk --release
```

APK location:
```
build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle (Play Store)
```bash
flutter build appbundle --release
```

AAB location:
```
build/app/outputs/bundle/release/app-release.aab
```

---

## 🏗️ Project Structure

```
lib/
├── main.dart
├── theme.dart
├── models.dart
├── controllers/
│   └── counter_controller.dart
├── screens/
│   └── main_screen.dart
└── widgets/
    ├── stitch_counter_widget.dart
    └── round_counter_widget.dart
```

---

## 🎯 How to Use

1. Launch the app (opens in landscape mode)
2. Tap the left side to add stitches
3. Tap the right side to add rounds
4. Use the small reset buttons for individual counters
5. Use the refresh icon to reset everything

Perfect for:
- Amigurumi projects
- Blankets and afghans
- Garments
- Any stitch-based crochet pattern

---

## 🎨 Theme Customization

Edit `lib/theme.dart` to change colors:

```dart
static ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFF2E7D32),
      brightness: Brightness.light,
      surface: Color(0xFFF9FBE7),
      background: Color(0xFFF9FBE7),
    ),
  );
}
```

---

## 🤝 Contributing

Contributions are welcome!

1. Fork the repository  
2. Create a feature branch  
   ```bash
   git checkout -b feature/AmazingFeature
   ```
3. Commit your changes  
   ```bash
   git commit -m "Add AmazingFeature"
   ```
4. Push to your branch  
   ```bash
   git push origin feature/AmazingFeature
   ```
5. Open a Pull Request  

### Ideas for Contributions
- Vibration feedback
- Sound feedback
- Counter history / undo
- Multiple projects
- Export count data
- Stitch pattern visualizer
- Different counter types

---

## 📄 License

This project is licensed under the **MIT License**.

MIT License means:
- ✅ Free for personal use
- ✅ Free for commercial use
- ✅ Modification allowed
- ✅ Distribution allowed
- ❌ No warranty
- ❌ No liability

See the LICENSE file for details.

---

## 🙏 Acknowledgments
- Built with Flutter
- Icons by Material Icons
- Inspired by the crochet community

---

## 📞 Support

Found a bug or have a feature request?  
Open an issue on GitHub.

---

Made with ❤️ for the crochet community  
Happy Crocheting! 🧶✨
