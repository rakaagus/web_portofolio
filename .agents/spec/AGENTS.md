# AGENTS.md — Panduan Kerja Agent di Project Ini

## 🎯 Tujuan
Dokumen ini berisi panduan operasional untuk agent AI yang mengerjakan task di project **Web Portofolio** ini.

## 📋 Workflow Agent

### 1. Memahami Task
- Baca task dengan teliti
- Identifikasi area yang terpengaruh: `data/`, `domain/`, `presentation/`, `utils/`
- Cek file terkait di `.agents/skills/`

### 2. Sebelum Coding
Baca dokumen berikut sesuai kebutuhan:
- `.agents/skill.md` — Overview project
- `.agents/skills/flutter-project/SKILL.md` — Konvensi project
- `.agents/skills/flutter-architecture/SKILL.md` — Struktur arsitektur
- Skill spesifik terkait task (data, UI, navigation, dll.)

### 3. Saat Coding
- Ikuti pola yang sudah ada (copy dari file sejenis)
- Gunakan widget reusable yang tersedia
- Semua string via `AppLocalizations`
- Semua warna via `Theme.of(context).colorScheme`
- Jangan hardcode apapun

### 4. Setelah Coding
- Jalankan `flutter analyze` — pastikan bersih
- Jalankan `flutter test` — pastikan lulus
- Regenerate `.g.dart` jika mengubah entity/DAO:
  ```bash
  dart run build_runner build --delete-conflicting-outputs
  ```
- Update localization di kedua ARB file jika menambah/mengubah teks
- Update dokumentasi di `.agents/` jika ada perubahan arsitektur

## 📁 File yang Sering Diubah

### Halaman & Konten
| File | Fungsi |
|------|--------|
| `lib/presentation/bloc/home/home_content.dart` | Konten halaman Home |
| `lib/presentation/bloc/experience/experience_content.dart` | Konten halaman Experience |
| `lib/presentation/bloc/blog/blog_content.dart` | Konten halaman Blog |
| `lib/presentation/bloc/project/project_content.dart` | Konten halaman Project |
| `lib/presentation/bloc/project/widget/dummy_project_data.dart` | Data dummy proyek |

### Data & Database
| File | Fungsi |
|------|--------|
| `lib/data/local/entity/*.dart` | Tabel Drift |
| `lib/data/local/drift/*_dao.dart` | DAO |
| `lib/data/local/drift/database/databases.dart` | AppDatabase |
| `lib/utils/contant.dart` | Konstanta nama tabel |
| `lib/domain/model/ui/*.dart` | Model UI |

### Utilitas
| File | Fungsi |
|------|--------|
| `lib/utils/l10n/app_id.arb` | Localization Indonesia |
| `lib/utils/l10n/app_en.arb` | Localization English |
| `lib/utils/color_theme.dart` | Color scheme |
| `lib/utils/type_theme.dart` | Typography |
| `lib/utils/enum/theme_cubit.dart` | Theme toggle |
| `lib/utils/enum/locale_cubit.dart` | Locale toggle |

### UI Widget
| File | Fungsi |
|------|--------|
| `lib/presentation/widget/liquid_glass_widget.dart` | Glass container |
| `lib/presentation/widget/hovered_card_widget.dart` | Hover cards |
| `lib/presentation/widget/gradient_background.dart` | Mesh gradient |
| `lib/presentation/widget/global_button.dart` | Tombol global |
| `lib/presentation/widget/global_footer.dart` | Footer |

## 🚨 Checklist Sebelum Submit
- [ ] `flutter analyze` — tidak ada error/warning baru
- [ ] `flutter test` — semua test lulus
- [ ] Tidak ada string hardcode (semua via localization)
- [ ] Tidak ada warna hardcode (semua via colorScheme)
- [ ] Widget reusable digunakan, bukan duplikasi
- [ ] Localization ID & EN sinkron
- [ ] Kode mengikuti Clean Architecture
- [ ] Responsive di semua breakpoint
- [ ] Dark & light theme aman

## 🔄 Siklus Kerja yang Disarankan
```mermaid
flowchart LR
    A[Baca Task] --> B[Pahami Skill]
    B --> C[Implementasi]
    C --> D[flutter analyze]
    D --> E{Ada Error?}
    E -->|Ya| C
    E -->|Tidak| F[flutter test]
    F --> G{Test Lulus?}
    G -->|Tidak| C
    G -->|Ya| H[Selesai]