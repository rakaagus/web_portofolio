# Diagnosing Bugs — Troubleshooting Guide

## 🎯 Tujuan
Panduan troubleshooting untuk masalah umum yang sering terjadi di project ini.

## 🐛 Bug Umum & Solusi

### 1. Build Runner Error (Code Generation)
**Gejala**: Error saat `dart run build_runner build`

**Penyebab & Solusi**:
```bash
# 1. Hapus file .g.dart lama
find . -name "*.g.dart" -delete

# 2. Clean build
dart run build_runner clean

# 3. Rebuild dengan force
dart run build_runner build --delete-conflicting-outputs
```

**Error umum**:
```
[SEVERE] build_runner: Build failed due to invalid outputs
```
→ Hapus file `.g.dart` dan rebuild.

### 2. Drift Database Error
**Gejala**: `Table 'xxx' does not exist` atau `Schema version mismatch`

**Penyebab & Solusi**:
- Cek `schemaVersion` di `AppDatabase` — apakah sudah sesuai?
- Jika ada perubahan schema, update `schemaVersion` dan tambahkan `MigrationStrategy`
- Regenerate file `.g.dart`
- Cek apakah entity sudah terdaftar di `@DriftDatabase(tables: [...])`

### 3. Localization Error
**Gejala**: `The getter 'xxx' isn't defined for type 'AppLocalizations'`

**Penyebab & Solusi**:
- Key tidak ada di ARB file
- Belum regenerate localization
```bash
# Regenerate localization
flutter gen-l10n
```
- Pastikan key ada di **kedua** file: `app_id.arb` DAN `app_en.arb`

### 4. Flutter Web Error
**Gejala**: Blank page, atau error `Failed to load sqlite3.wasm`

**Penyebab & Solusi**:
- Cek file `web/sqlite3.wasm` dan `web/drift_worker.js` ada
- Cek path di `DriftWebOptions` — harus `Uri.parse('sqlite3.wasm')`
- Cek console browser (F12) untuk error detail
- Pastikan server fallback ke `index.html`

### 5. Import Error
**Gejala**: `Target of URI doesn't exist`

**Penyebab & Solusi**:
- File yang di-import belum dibuat
- Path salah (gunakan `package:web_portofolio/...`)
- File `.g.dart` belum digenerate

### 6. BLoC Error
**Gejala**: `BlocProvider.of() called with a context that does not contain a Bloc`

**Penyebab & Solusi**:
- BLoC belum di-provide di widget tree
- Pastikan `BlocProvider` ada di parent widget
- Cek apakah `context` sudah benar (jangan panggil sebelum widget build)

### 7. Theme/Color Error
**Gejala**: Warna tidak sesuai, atau error `Theme.of(context).colorScheme`

**Penyebab & Solusi**:
- Pastikan `MaterialApp` sudah memiliki `theme` dan `darkTheme`
- Gunakan `Theme.of(context).colorScheme` bukan hardcode
- Cek `Brightness` — dark/light mode

## 🔍 Debugging Steps

### Step 1: Cek Console
```bash
# Flutter analyze — static analysis
flutter analyze

# Cek error spesifik
flutter run -d chrome 2>&1 | grep -i error
```

### Step 2: Cek File Generated
```bash
# Apakah file .g.dart ada?
ls -la lib/data/local/drift/*.g.dart
ls -la lib/data/local/drift/database/*.g.dart
```

### Step 3: Cek Localization
```bash
# Apakah file ARB lengkap?
cat lib/utils/l10n/app_id.arb | grep -c '"'
cat lib/utils/l10n/app_en.arb | grep -c '"'
```

### Step 4: Cek Dependencies
```bash
# Versi dependencies
flutter pub outdated

# Resolve dependencies
flutter pub get
```

## 🧪 Checklist Debugging
- [ ] `flutter analyze` — tidak ada error
- [ ] File `.g.dart` sudah digenerate
- [ ] Localization key ada di kedua ARB file
- [ ] `schemaVersion` sesuai dengan entity terbaru
- [ ] `web/sqlite3.wasm` dan `web/drift_worker.js` ada
- [ ] `usePathUrlStrategy()` dipanggil di `main()`
- [ ] `BlocProvider` ada di parent widget
- [ ] `Theme.of(context).colorScheme` digunakan, bukan hardcode
- [ ] `AppLocalizations.of(context)!.key` digunakan, bukan hardcode string
- [ ] Responsive breakpoint sudah benar