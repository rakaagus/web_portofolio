# Flutter Error Handling — Pola Penanganan Error

## 🎯 Tujuan
Standar penanganan error di project ini agar konsisten di seluruh layer.

## 🧱 Tingkatan Error Handling

### 1. Data Layer — Repository & DAO
**Pola**: Tangkap exception dan kembalikan `UIDataEntity` dengan `isError = true`.

```dart
class ExperienceRepositoryImpl implements ExperienceRepository {
  final ExperienceDao _experienceDao;

  @override
  Future<UIDataEntity<List<ExperienceData>>> getExperiences() async {
    try {
      final data = await _experienceDao.getExperiences();
      return UIDataEntity(data: data, isError: false);
    } catch (e) {
      return UIDataEntity(isError: true, message: e.toString());
    }
  }
}
```

### 2. Presentation Layer — BLoC
**Pola**: BLoC menerima `UIDataEntity`, emit state `Error` jika `isError`.

```dart
class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  final ExperienceRepository _repository;

  Future<void> _onLoadExperiences(LoadExperiences event, Emitter<ExperienceState> emit) async {
    emit(ExperienceLoading());
    final result = await _repository.getExperiences();

    if (result.isError) {
      emit(ExperienceError(message: result.message));
    } else {
      emit(ExperienceLoaded(data: result.data ?? []));
    }
  }
}
```

### 3. UI Layer — Feedback ke User
**Pola**: Tampilkan pesan error yang ramah, jangan raw exception.

```dart
// Di widget
BlocBuilder<ExperienceBloc, ExperienceState>(
  builder: (context, state) {
    if (state is ExperienceError) {
      return EmptyDataWidget(
        message: 'Terjadi kesalahan: ${state.message}',
      );
    }
    // ...
  },
)
```

## 🚨 Error yang Sering Terjadi

### 1. Drift/SQLite Error
- **Penyebab**: Query salah, schema mismatch, file `.g.dart` outdated
- **Solusi**:
  - Regenerate: `dart run build_runner build --delete-conflicting-outputs`
  - Cek `schemaVersion` di `AppDatabase`
  - Cek migration strategy

### 2. Networking Error (Dio)
- **Penyebab**: Koneksi gagal, timeout, HTTP error
- **Solusi**:
  ```dart
  try {
    final response = await _dio.get('/api/data');
  } on DioException catch (e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        // timeout
      case DioExceptionType.badResponse:
        // HTTP error status
        // e.response?.statusCode
    }
  }
  ```

### 3. Localization Error
- **Penyebab**: Key tidak ada di ARB file
- **Solusi**: Tambahkan key ke `app_id.arb` DAN `app_en.arb` bersamaan
- **Cek**: `AppLocalizations.of(context)!.keyName`

### 4. Null Safety / Casting Error
- **Penyebab**: Casting model gagal, data null
- **Solusi**:
  - Gunakan `result.data ?? []`
  - Cek nullable dengan `?.` dan `??`
  - Jangan gunakan `!` tanpa alasan kuat

## 🧪 Debugging Tools

### `debugPrint` — untuk log
```dart
debugPrint("Tidak dapat membuka link: $urlString");
```

### `flutter analyze` — untuk static analysis
```bash
flutter analyze
```

### Error di UI
- Widget `EmptyDataWidget` — `lib/presentation/widget/empty_data_widget.dart`
- Dapat digunakan untuk empty state dan error state

## ✅ Aturan
1. **SELALU gunakan `try-catch`** di repository/DAO
2. **JANGAN lemparkan error mentah ke UI** — gunakan `UIDataEntity.isError`
3. **JANGAN tampilkan `e.toString()`** langsung ke user — beri pesan ramah
4. **SELALU handle empty state** dengan `EmptyDataWidget`
5. **Cek kedua localization file** jika ada error terkait teks
6. **JANGAN gunakan `print()`** untuk log — gunakan `debugPrint` atau package `logger`