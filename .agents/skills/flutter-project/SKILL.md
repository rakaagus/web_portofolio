# Flutter Project — Konvensi & Standar Project

## 🎯 Tujuan
Konvensi standar yang digunakan di project Flutter ini. Semua kode baru HARUS mengikuti aturan ini.

## 📋 Identitas Project
- **Nama**: `web_portofolio`
- **Deskripsi**: Web portofolio personal
- **Versi**: `1.0.0+1`
- **SDK**: Dart `^3.7.2`
- **Platform**: Flutter Web (utama), juga mendukung mobile
- **Package**: `web_portofolio`

## 📁 Struktur Folder Utama
```
web_portofolio/
├── lib/
│   ├── data/          # Data layer
│   ├── domain/        # Domain layer
│   ├── di/            # Dependency injection
│   ├── presentation/  # UI layer
│   └── utils/         # Utility, theme, l10n
├── assets/
│   └── images/        # Gambar (profile, icons)
├── fonts/
│   └── PJS-*.ttf      # Plus Jakarta Sans
├── web/
│   ├── index.html     # Entry HTML
│   ├── manifest.json  # PWA manifest
│   ├── drift_worker.js
│   └── sqlite3.wasm
└── test/
    └── widget_test.dart
```

## 🛠️ Dependencies Utama

### Runtime
| Package | Versi | Fungsi |
|---------|-------|--------|
| flutter_bloc | ^8.0.1 | State management |
| get_it | ^8.0.1 | DI |
| quipped | ^2.0.8 | Value equality |
| rxdart | ^0.28.0 | Reactive |
| dio | ^5.3.0 | HTTP client |
| drift | 2.28.1 | SQLite ORM |
| drift_flutter | ^0.2.7 | Drift + Flutter |
| url_launcher | ^6.3.0 | Link eksternal |
| shimmer | ^3.0.0 | Loading effect |
| lottie | ^3.1.2 | Animasi |
| flutter_svg | ^2.0.3 | SVG |
| font_awesome_flutter | ^10.9.1 | Icons |

### Dev
| Package | Versi | Fungsi |
|---------|-------|--------|
| flutter_lints | ^5.0.0 | Linting |
| drift_dev | 2.28.0 | Drift codegen |
| build_runner | ^2.2.0 | Codegen runner |
| retrofit_generator | ^9.1.3 | Retrofit codegen |

## 🔤 Naming Convention
| Item | Convention | Contoh |
|------|-----------|--------|
| File | snake_case | `home_content.dart` |
| Class | PascalCase | `HomeContent` |
| Method | camelCase | `_launchURL()` |
| Konstanta | SCREAMING_SNAKE | `KEY_TABLE_EXPERIENCES` |
| Private | prefix `_` | `_homeContentState` |
| Entity Drift | `*_entity.dart` | `experience_entity.dart` |
| DAO | `*_dao.dart` | `experience_dao.dart` |
| Screen | `*_screen.dart` | `home_screen.dart` |
| Content | `*_content.dart` | `home_content.dart` |

## 🗂️ Aturan Import
```dart
// 1. Package eksternal
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 2. Package internal
import 'package:web_portofolio/domain/model/...';
import 'package:web_portofolio/presentation/...';

// 3. Relative (hanya untuk widget dalam folder yang sama)
import 'widget/testimonial_section_widget.dart';
```

## 📍 Konvensi Kode

### 1. Semua Teks → Localization
- String hardcode di widget **DILARANG**
- Gunakan `AppLocalizations.of(context)!.keyName`
- File: `lib/utils/l10n/app_id.arb` & `app_en.arb`

### 2. Semua Warna → ColorScheme
- Warna hardcode di widget **DILARANG** (kecuali gradient khusus)
- Gunakan `Theme.of(context).colorScheme`
- File: `lib/utils/color_theme.dart`

### 3. Semua Ukuran → Responsive
- Jangan gunakan ukuran statis
- Gunakan `MediaQuery` + breakpoint (`< 650` mobile, `650-950` tablet, `> 900` desktop)

### 4. State → BLoC/Cubit
- Jangan gunakan `setState` untuk data dari repository
- BLoC untuk logic complex, Cubit untuk simple state

## 🔧 Perintah Penting

```bash
# Jalankan web
flutter run -d chrome

# Build production
flutter build web

# Codegen
dart run build_runner build --delete-conflicting-outputs

# Test
flutter test

# Analyze
flutter analyze

# Setup (dari repo baru)
./setup.sh
```

## 🌐 Web Config (PWA)
- `web/manifest.json` — untuk installable PWA
- `web/index.html` — meta tags SEO
- `web/sqlite3.wasm` + `web/drift_worker.js` — database web
- Gunakan `usePathUrlStrategy()` untuk URL bersih

## 🚀 Deployment
- `setup.sh` — Setup environment
- Build: `flutter build web`
- Deploy ke GitHub Pages / Firebase Hosting (konfigurasi fallback ke `index.html`)

## ✅ Checklist Project
- [x] Clean Architecture (3 layer)
- [x] BLoC state management
- [x] Localization ID & EN
- [x] Dark/Light theme
- [x] Glassmorphism UI
- [x] PWA support
- [x] Drift local database