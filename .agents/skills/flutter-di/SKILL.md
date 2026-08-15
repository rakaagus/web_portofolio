# Flutter Dependency Injection — get_it

## 🎯 Tujuan
Standar dependency injection (DI) di project ini menggunakan **get_it**.

## 📦 Package: get_it
- Versi: `^8.0.1`
- Fungsi: Service locator untuk dependency injection

## 🏗️ Struktur DI

Folder `lib/di/` berisi registrasi dependency.

### Pola Registrasi
```dart
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Singleton — satu instance untuk seluruh app
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // DAO
  getIt.registerLazySingleton<ExperienceDao>(
    () => ExperienceDao(getIt<AppDatabase>()),
  );

  // Repository
  getIt.registerLazySingleton<ExperienceRepository>(
    () => ExperienceRepositoryImpl(getIt<ExperienceDao>()),
  );

  // BLoC — factory, dibuat setiap kali dibutuhkan
  getIt.registerFactory<HomeBloc>(() => HomeBloc(getIt<ExperienceRepository>()));
}
```

## 📍 Cara Menggunakan

### 1. Dapatkan instance
```dart
// Di dalam widget/BLoC
final repository = getIt<ExperienceRepository>();
```

### 2. Registrasi di main.dart
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();  // <-- Inisialisasi DI
  runApp(MyPortoApp());
}
```

## 🚨 Aturan DI
1. **JANGAN buat instance** class secara manual di widget — selalu gunakan `getIt`
2. **JANGAN panggil `getIt` di dalam `build()`** — panggil di `initState()` atau constructor
3. **Gunakan `registerLazySingleton`** untuk service yang berat (database, repository)
4. **Gunakan `registerFactory`** untuk BLoC/Cubit
5. **Satu file DI** untuk semua registrasi, atau pecah per feature jika perlu

---

**Catatan**: Folder `lib/di/` saat ini masih kosong di project ini. Jika menambahkan DI, ikuti pola di atas.