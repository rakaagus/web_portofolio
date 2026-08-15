# Flutter Testing — Strategi Testing

## 🎯 Tujuan
Standar testing di project ini — mencakup unit test, widget test, dan integration test.

## 📁 Struktur Test
```
test/
├── widget_test.dart          # Test utama (sudah ada)
├── unit/                     # Unit test
│   ├── data/                 # Test data layer
│   ├── domain/               # Test domain layer
│   └── presentation/         # Test BLoC
└── integration/              # Integration test (jika ada)
```

## 🧪 Jenis Test

### 1. Unit Test
Test fungsi/business logic tanpa UI.

```dart
// test/unit/model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:web_portofolio/domain/model/ui/ui_data_entity.dart';

void main() {
  group('UIDataEntity', () {
    test('should have default values', () {
      const entity = UIDataEntity<int>();
      expect(entity.isError, false);
      expect(entity.message, '');
      expect(entity.data, isNull);
    });

    test('should set data', () {
      final entity = UIDataEntity<int>(data: 42);
      expect(entity.data, 42);
      expect(entity.isError, false);
    });
  });
}
```

### 2. Widget Test
Test widget dan interaksinya.

```dart
// test/widget/home_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:web_portofolio/main.dart';

void main() {
  testWidgets('App should render', (WidgetTester tester) async {
    await tester.pumpWidget(const MyPortoApp());
    expect(find.byType(MyPortoApp), findsOneWidget);
  });
}
```

### 3. BLoC Test
Test BLoC menggunakan `bloc_test`.

```dart
// test/bloc/home_bloc_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeBloc', () {
    blocTest<HomeBloc, HomeState>(
      'emit Loading then Loaded',
      build: () => HomeBloc(repository: mockRepository),
      act: (bloc) => bloc.add(LoadHomeData()),
      expect: () => [
        HomeLoading(),
        HomeLoaded(experiences: [...]),
      ],
    );
  });
}
```

## 📦 Package Testing

| Package | Fungsi |
|---------|--------|
| flutter_test | Testing framework wajib |
| bloc_test | Testing BLoC |
| mockito / mocktail | Mocking dependencies |
| integration_test | Integration test |

## ✅ Aturan Testing
1. **Test file per feature** — `test/<feature>_test.dart`
2. **Gunakan `group()`** untuk mengelompokkan test case
3. **Mock repository** — jangan test database asli
4. **JANGAN test implementation detail** — test behavior
5. **Coverage minimal** untuk business logic penting
6. **Jalankan secara rutin**: `flutter test`

---

**Catatan**: Project ini masih memiliki test minimal (`test/widget_test.dart`). Saat menambahkan test baru, ikuti pola di atas.