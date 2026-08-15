# Flutter Navigation — Routing & Navigation Pattern

## 🎯 Tujuan
Standar navigasi di project ini — mencakup routing, URL strategy, dan komponen navigasi.

## 🧭 Routing Utama

File: `lib/main.dart`

Project ini menggunakan **named routes** dengan `onGenerateRoute`.

### Daftar Route
| Route | Halaman | File |
|-------|---------|------|
| `/` | HomeScreen | `lib/presentation/bloc/home/home_screen.dart` |
| `/experience` | ExperienceScreen | `lib/presentation/bloc/experience/experience_screen.dart` |
| `/projects` | ProjectScreen | `lib/presentation/bloc/project/project_screen.dart` |
| `/blogs` | BlogScreen | `lib/presentation/bloc/blog/blog_screen.dart` |
| `*` (default) | NotFoundScreen | `lib/presentation/bloc/not_found/not_found_screen.dart` |

### Konfigurasi Routing
```dart
initialRoute: '/',
onGenerateRoute: (settings) {
  Widget page;
  switch (settings.name) {
    case '/':
      page = const HomeScreen();
      break;
    case '/experience':
      page = const ExperienceScreen();
      break;
    case '/projects':
      page = const ProjectScreen();
      break;
    case '/blogs':
      page = const BlogScreen();
      break;
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const NotFoundScreen(),
      );
  }
  // Custom transition: Slide + Fade (400ms)
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween<Offset>(
        begin: const Offset(0.0, 0.05),
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutCubic));
      return FadeTransition(
        opacity: animation,
        child: SlideTransition(position: animation.drive(tween), child: child),
      );
    },
    transitionDuration: const Duration(milliseconds: 400),
  );
},
```

## 🌐 URL Path Strategy

Project menggunakan **`usePathUrlStrategy()`** agar URL bersih tanpa `#`.

```dart
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();  // URL: /experience, bukan /#/experience
  runApp(MyPortoApp());
}
```

**Penting untuk Web Deploy**: Server harus dikonfigurasi untuk fallback ke `index.html` untuk semua routes (SPA routing).

## 🧩 Komponen Navigasi

### Sidebar (Desktop)
File: `lib/presentation/Navigation/sidebar_widget.dart`
- Liquid glass sidebar
- Expand on hover
- Digunakan untuk desktop (> 900px)

### BottomBar (Mobile)
File: `lib/presentation/Navigation/bottombar_widget.dart`
- Glass bottom bar
- Digunakan untuk mobile (< 900px)

### Item Menu
File: `lib/presentation/Navigation/item_menu_data.dart`
- Data menu items
- Menentukan label & route

### NavItem
File: `lib/presentation/Navigation/nav_item.dart`
- Widget item navigasi

## 📍 Cara Navigasi

### 1. Via `onNavigate` callback (recommended)
```dart
// Di dalam widget yang menerima callback
class HomeContent extends StatefulWidget {
  final Function(String url) onNavigate;
  // ...
}

// Penggunaan
widget.onNavigate('/experience');
```

### 2. Via Navigator langsung
```dart
Navigator.pushNamed(context, '/projects');
```

### 3. Via `GoRouter` (jika butuh)
Jika project beralih ke GoRouter, pastikan:
- Gunakan `GoRouter` sebagai `router` di `MaterialApp.router`
- Route definitions terpusat
- ShellRoute untuk layout bersama (sidebar + bottom bar)

## 🚨 Aturan Navigasi
1. **JANGAN hardcode route** di widget — gunakan konstanta atau callback `onNavigate`
2. **SELALU gunakan transition** yang sudah dikonfigurasi (Slide + Fade)
3. **JANGAN buat `Navigator.of(context).push`** jika bukan halaman baru — gunakan `onNavigate` untuk tab navigation
4. **Pastikan `NotFoundScreen`** menangani route yang tidak dikenal
5. **Untuk Flutter Web** — gunakan `usePathUrlStrategy()` dan konfigurasi server fallback
6. **State preservation** — gunakan `BaseStatefulStayAliveWidget` jika halaman perlu dipertahankan
</｜｜DSML｜｜_content>
<task_progress>
- [x] Ekstrak teks dari gambar referensi (OCR)
- [x] Analisis format/struktur referensi
- [x] Baca file kunci project
- [x] Buat .agents/AGENTS.md
- [x] Buat .agents/skills/flutter-architecture/SKILL.md
- [x] Buat .agents/skills/flutter-ui/SKILL.md
- [x] Buat .agents/skills/flutter-data/SKILL.md
- [x] Buat .agents/skills/flutter-di/SKILL.md
- [x] Buat .agents/skills/flutter-error-handling/SKILL.md
- [x] Buat .agents/skills/flutter-navigation/SKILL.md
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