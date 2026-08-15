# Flutter UI/UX — Design System & Widget Pattern

## 🎯 Tujuan
Standar UI/UX yang digunakan di project ini. Semua tampilan baru HARUS mengikuti design system ini.

## 🎨 Design System

### 1. Glassmorphism / Liquid Glass Effect
Project ini menggunakan **glassmorphism** sebagai tema utama.

**Widget Utama**:
- `LiquidGlassContainer` — `lib/presentation/widget/liquid_glass_widget.dart`
  ```dart
  LiquidGlassContainer(
    padding: EdgeInsets.all(24),
    borderRadius: BorderRadius.circular(30),
    blur: 20,
    child: /* content */,
  )
  ```
  - Menggunakan `BackdropFilter` + `ImageFilter.blur()`
  - Border transparan (white dengan opacity)
  - Gradient linear transparan
  - Adaptif terhadap dark/light theme

- `HoverGlassCard` — `lib/presentation/widget/hovered_card_widget.dart`
  - Card glass dengan efek hover lift
  - Responsif terhadap pointer

- `HoverSolidCard` — `lib/presentation/widget/hovered_card_widget.dart`
  - Card solid dengan efek hover lift
  - Digunakan untuk section About, Education, dll.

### 2. Mesh Gradient Background
- `MeshGradientBackground` — `lib/presentation/widget/gradient_background.dart`
- 5 variasi style berbeda untuk variasi halaman
- Menggunakan `ColorScheme` untuk adaptasi tema
- Contoh penggunaan:
  ```dart
  Stack(
    children: [
      const Positioned.fill(child: MeshGradientBackground(style: 2)),
      // content
    ],
  )
  ```

### 3. Warna — Color System
**JANGAN hardcode warna** — selalu gunakan `Theme.of(context).colorScheme`

```
lib/utils/color_theme.dart
├── LightColorTheme       # primaryColor, secondaryColor, backgroundColor, textColor
└── DarkColorTheme        # surfaceColor, textPrimaryColor, textSecondaryColor
```

Akses warna:
```dart
final colorScheme = Theme.of(context).colorScheme;
// colorScheme.primary, colorScheme.secondary, colorScheme.surface, colorScheme.onSurface
```

### 4. Typography
- Font: **Plus Jakarta Sans** (PJS)
- File font: `fonts/PJS-Regular.ttf`, `PJS-Light.ttf`, `PJS-Medium.ttf`, `PJS-Bold.ttf`
- Konfigurasi: `lib/utils/type_theme.dart` → `AppTypography.getTheme(colorScheme)`

Akses typography:
```dart
Theme.of(context).textTheme.displayLarge   // Judul besar
Theme.of(context).textTheme.headlineMedium // Judul sedang
Theme.of(context).textTheme.titleMedium    // Judul kecil
Theme.of(context).textTheme.bodyLarge      // Paragraf
Theme.of(context).textTheme.bodyMedium     // Teks biasa
```

### 5. Responsive Design
**Breakpoint**:
| Device | Lebar |
|--------|-------|
| Mobile | < 650px |
| Tablet | 650–950px |
| Desktop | > 900px |

Pola responsif:
```dart
final double screenWidth = MediaQuery.of(context).size.width;
final bool isMobile = screenWidth < 900;
final bool isTablet = screenWidth >= 650 && screenWidth < 1100;
```

Layout pattern:
- **Mobile**: Column (stack vertically)
- **Tablet**: Column + Row campuran
- **Desktop**: Row dengan `Expanded` + `flex`

### 6. Dark/Light Theme
- `ThemeCubit` — `lib/utils/enum/theme_cubit.dart`
- `ThemeMode.system` default
- Automatis adaptif — widget menggunakan `colorScheme`, bukan warna hardcode

## 🧩 Widget Reusable Global (`lib/presentation/widget/`)

| Widget | File | Fungsi |
|--------|------|--------|
| `GlobalButton` | `global_button.dart` | Tombol global dengan animasi arrow |
| `GlobalFooter` | `global_footer.dart` | Footer global |
| `GlobalProjectCard` / `ProjectCard` | `global_project_card.dart` | Card proyek |
| `EmptyDataWidget` | `empty_data_widget.dart` | Empty state |
| `MeshGradientBackground` | `gradient_background.dart` | Background gradient |
| `HoverGlassCard` | `hovered_card_widget.dart` | Card glass hover |
| `HoverSolidCard` | `hovered_card_widget.dart` | Card solid hover |
| `LiquidGlassContainer` | `liquid_glass_widget.dart` | Container glass |
| `TechChip` | `tech_chip.dart` | Badge teknologi |

## 📍 Pola Halaman (Screen + Content)

Setiap halaman dipisahkan antara **Screen** dan **Content**:
```dart
// home_screen.dart — Entry point BLoC & Scaffold
class HomeScreen extends StatefulWidget { ... }

// home_content.dart — Konten UI
class HomeContent extends StatefulWidget {
  final ScrollController scrollController;
  final Function(String url) onNavigate;
  // ...
}
```

**Struktur Halaman**:
```
screen/ (Scaffold + Navigation + BlocProvider)
    ↓
content/ (Isi halaman — ListView/Section)
    ↓
widget/ (Widget spesifik halaman)
```

## 🚨 Aturan UI
1. **JANGAN hardcode warna** — gunakan `colorScheme`
2. **JANGAN hardcode string** — gunakan `AppLocalizations.of(context)!.key`
3. **SELALU gunakan `GlobalButton`** untuk tombol aksi utama
4. **Gunakan `HoverSolidCard` / `HoverGlassCard`** untuk card
5. **Ikuti responsive breakpoint** — jangan layout statis
6. **Dashboard/Content** — pisahkan `Screen` dan `Content` (`*_screen.dart` + `*_content.dart`)
7. **Perhatikan dark mode** — selalu test di kedua theme