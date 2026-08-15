# Flutter Architecture — Clean Architecture & Project Structure

## 🎯 Tujuan
Standar arsitektur yang digunakan di project ini. Semua kode baru HARUS mengikuti pola ini.

## 📐 Clean Architecture — 3 Layer Utama

### 1. Data Layer (`lib/data/`)
**Tanggung jawab**: Mengelola sumber data (lokal & remote)

```
lib/data/
├── local/
│   ├── drift/          # Drift DAO (Data Access Object)
│   │   ├── education_dao.dart
│   │   ├── experience_dao.dart
│   │   ├── image_dao.dart
│   │   ├── organization_dao.dart
│   │   ├── porto_dao.dart
│   │   └── skill_dao.dart
│   ├── entity/         # Drift Table (database schema)
│   │   ├── education_entity.dart
│   │   ├── experience_entity.dart
│   │   └── ...
│   └── database/
│       └── databases.dart   # AppDatabase (DriftDatabase)
├── remote/
│   ├── call/           # API service (Retrofit/Dio)
│   └── response/       # Model response API
└── repository/         # Implementasi repository
```

**Pola Drift Table** (`lib/data/local/entity/`):
```dart
@DataClassName(KEY_TABLE_EXPERIENCES)
class ExperienceEntity extends Table {
  TextColumn get id => text().clientDefault(experienceUuIdGene)();
  TextColumn get companyName => text().withLength(min: 1, max: 100)();
  // ...
  @override
  Set<Column> get primaryKey => {id};
}
```

**Pola Drift DAO** (`lib/data/local/drift/`):
```dart
@DriftAccessor(tables: [ExperienceEntity])
class ExperienceDao extends DatabaseAccessor<AppDatabase> with _$ExperienceDaoMixin {
  ExperienceDao(AppDatabase db) : super(db);
}
```

### 2. Domain Layer (`lib/domain/`)
**Tanggung jawab**: Business logic & model yang bebas framework

```
lib/domain/
├── model/
│   ├── response/       # Model response dari API
│   └── ui/             # Model untuk UI
│       ├── experience_ui_entity.dart
│       ├── skill_ui_entity.dart
│       └── ui_data_entity.dart   # Generic wrapper
└── repository/         # Interface repository
└── usecase/            # Use cases (business logic)
```

**Pola Model UI** (`lib/domain/model/ui/`):
```dart
class UIDataEntity<T> extends Equatable {
  bool isError = false;
  String message = "";
  T? data;
  // ...
}
```

### 3. Presentation Layer (`lib/presentation/`)
**Tanggung jawab**: UI, state management, navigasi

```
lib/presentation/
├── bloc/
│   ├── home/           # Halaman Home
│   │   ├── home_screen.dart      # Entry point BLoC
│   │   ├── home_content.dart     # UI content
│   │   ├── bloc/                  # BLoC logic
│   │   └── widget/               # Widget spesifik halaman
│   ├── experience/    # Halaman Experience
│   ├── project/       # Halaman Project
│   ├── blog/          # Halaman Blog
│   ├── loading/       # Loading & transition
│   └── not_found/     # 404 page
├── Navigation/         # Sidebar, BottomBar, NavItem
└── widget/            # Global reusable widget
```

**Pola BLoC per halaman**:
```
home/
├── home_screen.dart       # Widget utama (StatefulWidget)
├── home_content.dart      # Konten UI (terpisah dari screen)
├── bloc/
│   ├── home_bloc.dart     # BLoC class
│   ├── home_event.dart    # Events
│   └── home_state.dart    # States
└── widget/
    └── *.dart             # Widget spesifik
```

## 📍 Dependency Rule
```
Presentation → Domain ← Data
     ↓            ↓
   (UI)       (Models) 
```
- **Presentation** bergantung pada **Domain**
- **Data** implements interface dari **Domain**
- **Domain** TIDAK bergantung pada layer lain (murni business logic)

## ✅ Aturan
1. **JANGAN import** `package:flutter/material.dart` di dalam `data/` atau `domain/`
2. **JANGAN** panggil database langsung dari presentation — harus lewat repository
3. **Gunakan `UIDataEntity<T>`** sebagai wrapper untuk data yang di-load dari storage/API
4. **Entity Drift** beda dengan **UI Model** — lakukan mapping
5. **Nama konstan tabel** ada di `lib/utils/contant.dart` (`KEY_TABLE_*`)

## 🔄 Alur Data (Contoh Experience)
```
HomeScreen (UI)
    ↓ emits event
HomeBloc (Presentation)
    ↓ memanggil
Repository (Domain interface)
    ↓ implements
Drift DAO (Data layer)
    ↓ query ke
AppDatabase (SQLite Web)
```
</｜｜DSML｜｜_content>
<task_progress>
- [x] Ekstrak teks dari gambar referensi (OCR)
- [x] Analisis format/struktur referensi
- [x] Baca file kunci project
- [x] Buat .agents/AGENTS.md
- [x] Buat .agents/skills/flutter-architecture/SKILL.md
- [ ] Buat .agents/skills/flutter-ui/SKILL.md
- [ ] Buat .agents/skills/flutter-data/SKILL.md
- [ ] Buat .agents/skills/flutter-di/SKILL.md
- [ ] Buat .agents/skills/flutter-error-handling/SKILL.md
- [ ] Buat .agents/skills/flutter-navigation/SKILL.md
- [ ] Buat .agents/skills/flutter-presentation/SKILL.md
- [ ] Buat .agents/skills/flutter-project/SKILL.md
- [ ] Buat .agents/skills/flutter-testing/SKILL.md
- [ ] Buat .agents/skills/flutter-web/SKILL.md
- [ ] Buat .agents/skills/diagnosing-bugs/SKILL.md
- [ ] Buat .agents/skills/mermaid-standards/SKILL.md
- [ ] Buat .agents/skills/tdd/SKILL.md
- [ ] Buat .agents/spec/AGENTS.md, PRD.md, PRD_ESTIMATION.md
- [ ] Jelaskan maksud file yang dibuat
</task_progress>
</write_to_file>