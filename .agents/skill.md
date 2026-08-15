# Project Overview — Web Portofolio

## 📋 Deskripsi Project
Ini adalah project **Web Portofolio** pribadi yang dibangun menggunakan **Flutter Web**. Project ini berfungsi sebagai showcase portofolio online yang menampilkan profil, pengalaman kerja, proyek-proyek, dan blog.

## 🏗️ Arsitektur & Pola Desain

### Clean Architecture
Project ini mengadopsi **Clean Architecture** dengan 3 layer utama:
```
lib/
├── data/          # Data Layer
│   ├── local/     # Database lokal (Drift/SQLite)
│   ├── remote/    # API calls (Dio/Retrofit)
│   └── repository # Implementasi repository
├── domain/        # Domain Layer
│   ├── model/     # Entity & UI models
│   └── repository # Repository interfaces
└── presentation/  # Presentation Layer
    ├── bloc/      # Halaman & BLoC
    ├── Navigation # Sidebar, BottomBar
    └── widget/    # Reusable widgets
```

### State Management
- **flutter_bloc** — Manajemen state untuk setiap halaman
- **Cubit** — Untuk state sederhana (LocaleCubit, ThemeCubit)
- **get_it** — Dependency Injection
- **equatable** — Value equality untuk BLoC states/events

### Pattern
- **Repository Pattern** — Memisahkan data source dari business logic
- **BLoC Pattern** — Memisahkan UI dari business logic
- **Base Widget Pattern** — `BaseStatefulWidget` sebagai base class untuk semua halaman

## 🛠️ Teknologi & Library

### Core
| Library | Fungsi |
|---------|--------|
| Flutter SDK ^3.7.2 | Framework utama |
| flutter_web_plugins | Plugin untuk Flutter Web |
| url_launcher ^6.3.0 | Membuka link eksternal |

### State Management
| Library | Fungsi |
|---------|--------|
| flutter_bloc ^8.0.1 | State management |
| equatable ^2.0.8 | Value equality |
| rxdart ^0.28.0 | Reactive programming |
| get_it ^8.0.1 | Dependency injection |
| uuid ^4.5.2 | UUID generation |

### Networking
| Library | Fungsi |
|---------|--------|
| dio ^5.3.0 | HTTP client |
| http ^1.1.0 | HTTP requests |
| retrofit ^4.0.1 | API code generation |
| logger ^2.0.2+1 | Logging |
| json_annotation ^4.6.0 | JSON serialization |
| json_serializable ^6.3.1 | JSON code generation |

### UI Components
| Library | Fungsi |
|---------|--------|
| shimmer ^3.0.0 | Loading shimmer effect |
| lottie ^3.1.2 | Animasi Lottie |
| modal_bottom_sheet ^3.0.0-pre | Bottom sheet modal |
| flutter_svg ^2.0.3 | SVG rendering |
| showcaseview ^3.0.0 | Feature showcase/tour |
| font_awesome_flutter ^10.9.1 | Font Awesome icons |
| cupertino_icons ^1.0.8 | Cupertino icons |

### Storage
| Library | Fungsi |
|---------|--------|
| drift 2.28.1 | SQLite ORM |
| drift_flutter ^0.2.7 | Flutter integration untuk drift |
| path_provider ^2.1.5 | File system paths |
| shared_preferences ^2.0.17 | Key-value storage |
| jose ^0.3.2 | JOSE (JSON Object Signing & Encryption) |

### Utilities
| Library | Fungsi |
|---------|--------|
| flutter_dotenv ^5.0.2 | Environment variables |
| intl ^0.19.0 | Internationalization |
| app_settings ^5.0.0 | App settings |
| flutter_localizations | Localization framework |

### Dev Tools
| Library | Fungsi |
|---------|--------|
| flutter_lints ^5.0.0 | Linting rules |
| drift_dev 2.28.0 | Drift code generator |
| build_runner ^2.2.0 | Code generation runner |
| retrofit_generator ^9.1.3 | Retrofit code generator |

## 🎨 Teknik UI/UX yang Diterapkan

### 1. **Glassmorphism / Liquid Glass Effect**
- Menggunakan `BackdropFilter` dengan `ImageFilter.blur()` untuk efek kaca
- `LiquidGlassContainer` — Widget reusable untuk efek glass
- `HoverGlassCard` — Card dengan efek glass yang responsif terhadap hover
- `HoverSolidCard` — Card solid dengan efek hover lift

### 2. **Mesh Gradient Background**
- `MeshGradientBackground` — Background dengan blob-blob gradient yang di-blur
- 5 variasi style berbeda untuk variasi halaman
- Menggunakan `ColorScheme` untuk adaptasi tema

### 3. **Responsive Design**
- Breakpoint: Mobile (< 650px), Tablet (650-950px), Desktop (> 900px)
- Layout berbeda untuk setiap ukuran layar
- `LayoutBuilder` dan `MediaQuery` untuk adaptasi

### 4. **Animasi & Transisi**
- **Page Transition** — Slide + Fade transition antar halaman (400ms)
- **Premium Loading** — Animasi loading awal dengan block reveal effect
- **Page Transition Overlay** — Block slide animation saat navigasi
- **Hover Animations** — Card lift, button arrow slide, sidebar expand
- **Scroll Animations** — Auto-hide app bar, back-to-top button
- **Infinite Scroll** — Tech stack auto-scroll dengan loop

### 5. **Dark/Light Theme**
- `ThemeCubit` untuk toggle theme
- `LightColorTheme` & `DarkColorTheme` — Color scheme terpisah
- Semua widget adaptif terhadap theme

### 6. **Localization (i18n)**
- Dukungan Bahasa Indonesia (ID) dan English (EN)
- `LocaleCubit` untuk toggle bahasa
- Menggunakan `flutter_localizations` + ARB files
- `AppLocalizations` untuk akses string terjemahan

### 7. **Navigation**
- **URL Path Strategy** — `usePathUrlStrategy()` untuk URL bersih tanpa `#`
- **Sidebar** — Liquid glass sidebar untuk desktop (expand on hover)
- **Bottom Bar** — Glass bottom bar untuk mobile
- **Routing** — `onGenerateRoute` dengan named routes

## 📄 Halaman & Routing

| Route | Halaman | Deskripsi |
|-------|---------|-----------|
| `/` | HomeScreen | Hero, About, Experience, Projects, Testimonials, Contact |
| `/experience` | ExperienceScreen | Timeline pengalaman kerja |
| `/projects` | ProjectScreen | Grid proyek dengan filter & pagination |
| `/blogs` | BlogScreen | Blog posts (masih empty state) |
| `*` | NotFoundScreen | 404 page |

## 🌐 Web Configuration
- **PWA Support** — `manifest.json` dengan icons untuk installable web app
- **SQLite Web** — `drift_worker.js` + `sqlite3.wasm` untuk database lokal di browser
- **SEO** — Meta tags di `index.html`
- **Favicon** — Custom favicon

## 📁 Struktur File Lengkap

```
web_portofolio/
├── pubspec.yaml              # Dependencies & project config
├── l10n.yaml                 # Localization config
├── analysis_options.yaml     # Linting rules
├── setup.sh                  # Setup script
├── deploy.sh                 # Deployment script
├── assets/
│   └── images/               # Profile image, icons
├── fonts/
│   └── PJS-*.ttf             # Plus Jakarta Sans font
├── lib/
│   ├── main.dart             # Entry point
│   ├── data/                 # Data layer
│   ├── domain/               # Domain layer
│   ├── di/                   # Dependency injection
│   └── presentation/         # UI layer
├── web/
│   ├── index.html            # Entry HTML
│   ├── manifest.json         # PWA manifest
│   ├── drift_worker.js       # SQLite Web worker
│   └── sqlite3.wasm          # SQLite WebAssembly
└── test/
    └── widget_test.dart      # Unit test
```

## 🔑 Catatan Penting untuk AI Agent
- Project ini **Flutter Web**, bukan Flutter Mobile biasa
- Menggunakan **Drift** untuk database lokal (SQLite via WebAssembly)
- Semua teks menggunakan **localization** (jangan hardcode string)
- UI menggunakan **glassmorphism** sebagai tema utama
- **BLoC** adalah pattern utama untuk state management
- Beberapa BLoC files masih kosong (belum diimplementasikan)
- Blog page masih dalam keadaan **empty state** (belum ada data)
- Project data menggunakan **dummy data** (belum dari API/database)