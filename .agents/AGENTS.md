# AGENTS.md — Panduan Agent AI untuk Project Web Portofolio

## 🎯 Tujuan
Dokumen ini memberikan panduan lengkap bagi agent AI (seperti Cline, Copilot, dll.) untuk memahami, menavigasi, dan berkontribusi pada project **Web Portofolio** ini secara efektif.

## 🏗️ Ringkasan Project
- **Nama**: `web_portofolio`
- **Tipe**: Flutter Web (PWA)
- **Tujuan**: Portofolio online personal — menampilkan profil, pengalaman, proyek, dan blog
- **Arsitektur**: Clean Architecture (Data, Domain, Presentation)
- **State Management**: flutter_bloc + Cubit
- **Database**: Drift (SQLite via WebAssembly untuk web)
- **Localization**: ID & EN (ARB files)

## 📁 Struktur Folder `.agents`
```
.agents/
├── AGENTS.md                    # File ini — panduan utama
├── skill.md                     # Overview project (sudah ada)
└── skills/                      # Pengetahuan teknis per topik
    ├── flutter-architecture/    # Clean Architecture + pola project
    ├── flutter-ui/              # UI/UX pattern (glassmorphism, dll)
    ├── flutter-data/            # Data layer (Drift, DAO, entity)
    ├── flutter-di/              # Dependency injection (get_it)
    ├── flutter-error-handling/  # Error handling patterns
    ├── flutter-navigation/      # Routing & navigation
    ├── flutter-presentation/    # BLoC & presentation layer
    ├── flutter-project/         # Konvensi project Flutter
    ├── flutter-testing/         # Testing strategy
    ├── flutter-web/             # Flutter Web specific
    ├── diagnosing-bugs/         # Troubleshooting bugs
    ├── mermaid-standards/       # Standar diagram Mermaid
    └── tdd/                     # Test Driven Development
└── spec/                        # Dokumen spesifikasi
    ├── AGENTS.md                # Panduan kerja agen
    ├── PRD.md                   # Product Requirements Document
    └── PRD_ESTIMATION.md        # Estimasi timeline
```

## ⚡ Quick Start untuk Agent AI

### 1. Sebelum Memulai Task
Baca file berikut secara berurutan:
1. `.agents/skill.md` — Memahami overview project
2. `.agents/skills/flutter-project/SKILL.md` — Memahami konvensi project
3. `.agents/skills/flutter-architecture/SKILL.md` — Memahami struktur arsitektur
4. File spesifik terkait task (misal: `.agents/skills/flutter-data/SKILL.md` untuk task database)

### 2. Aturan Penting
- **JANGAN hardcode string** — Selalu gunakan `AppLocalizations.of(context)!.keyName`
- **JANGAN bypass BLoC** — Semua state management harus melalui BLoC/Cubit
- **JANGAN tinggalkan file `.g.dart` lama** — Regenerate dengan `build_runner` jika mengubah entity/DAO
- **SELALU gunakan widget reusable** yang sudah ada (HoverGlassCard, LiquidGlassContainer, dll.)
- **PERHATIKAN tema** — Semua warna dari `Theme.of(context).colorScheme`, bukan hardcode

### 3. Perintah yang Sering Digunakan
```bash
# Menjalankan app web
flutter run -d chrome

# Generate kode (drift, retrofit)
dart run build_runner build --delete-conflicting-outputs

# Menjalankan test
flutter test

# Analisis kode
flutter analyze
```

### 4. Pola yang Harus Diikuti
| Layer | Pattern | Contoh Path |
|-------|---------|-------------|
| Data (Local) | Drift Table + DAO | `lib/data/local/entity/*.dart`, `lib/data/local/drift/*.dart` |
| Data (Remote) | Retrofit/Dio Service | `lib/data/remote/call/*.dart` |
| Domain | Model + Repository interface | `lib/domain/model/ui/*.dart`, `lib/domain/repository/*.dart` |
| Presentation | BLoC + Screen + Content + Widget | `lib/presentation/bloc/*/` |
| Utility | Cubit, Theme, l10n | `lib/utils/` |

## 🚨 Checklist Kualitas
- [ ] Tidak ada hardcoded string (semua via `AppLocalizations`)
- [ ] Tidak ada hardcoded warna (semua via `colorScheme`)
- [ ] Kode mengikuti Clean Architecture layering
- [ ] Widget reusable digunakan, bukan di-duplicate
- [ ] Localization ID & EN di-update bersamaan
- [ ] `flutter analyze` bersih tanpa warning/error baru