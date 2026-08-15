# Flutter Data Layer — Drift Database, DAO, & Repository

## 🎯 Tujuan
Standar pengelolaan data di project ini — mencakup database lokal (Drift), DAO, entity, dan repository pattern.

## 🗄️ Database: Drift (SQLite)

Project ini menggunakan **Drift** untuk database lokal. Di Flutter Web, Drift menggunakan **SQLite via WebAssembly** (`sqlite3.wasm`).

### Konfigurasi Database
File: `lib/data/local/drift/database/databases.dart`

```dart
@DriftDatabase(
  tables: [
    PortoEntity,
    EducationEntity,
    ExperienceEntity,
    ImageEntity,
    OrganizationEntity,
    SkillEntity,
  ],
  daos: [
    PortoDao,
    EducationDao,
    ExperienceDao,
    OrganizationDao,
    SkillDao,
    ImageDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'web_portofolio.db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  }
}
```

**Penting untuk Web**:
- `sqlite3Wasm` dan `driftWorker` W Ajib diarahkan ke file yang ada di `web/`
- File: `web/sqlite3.wasm`, `web/drift_worker.js`

## 📝 Entity (Tabel Database)

File: `lib/data/local/entity/*.dart`

### Pola Entity
```dart
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:web_portofolio/utils/contant.dart';

String experienceUuIdGene() => const Uuid().v4();

@DataClassName(KEY_TABLE_EXPERIENCES)
class ExperienceEntity extends Table {
  TextColumn get id => text().clientDefault(experienceUuIdGene)();
  TextColumn get companyName => text().withLength(min: 1, max: 100)();
  TextColumn get description => text()();
  TextColumn get role => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  BoolColumn get hasFinished => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
```

### Konvensi Nama Tabel
Konstanta `KEY_TABLE_*` ada di `lib/utils/contant.dart`:
```dart
const String KEY_TABLE_PORTO = "PortoData";
const String KEY_TABLE_SKILL = "SkillData";
const String KEY_TABLE_EDUCATION = "EducationData";
const String KEY_TABLE_ORGANIZATION = "OrganizationData";
const String KEY_TABLE_EXPERIENCES = "ExperienceData";
const String KEY_TABLE_IMAGE = "ImageData";
```

### Tabel yang Ada
| Entity | File | Deskripsi |
|--------|------|-----------|
| `PortoEntity` | `porto_entity.dart` | Data portofolio |
| `EducationEntity` | `education_entity.dart` | Pendidikan |
| `ExperienceEntity` | `experience_entity.dart` | Pengalaman kerja |
| `ImageEntity` | `image_entity.dart` | Gambar/download |
| `OrganizationEntity` | `organization_entity.dart` | Organisasi |
| `SkillEntity` | `skill_entity.dart` | Skill/keahlian |

## 🔌 DAO (Data Access Object)

File: `lib/data/local/drift/*_dao.dart`

### Pola DAO
```dart
import 'package:drift/drift.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';
import 'package:web_portofolio/data/local/entity/experience_entity.dart';

part 'experience_dao.g.dart';

@DriftAccessor(tables: [ExperienceEntity])
class ExperienceDao extends DatabaseAccessor<AppDatabase> with _$ExperienceDaoMixin {
  ExperienceDao(AppDatabase db) : super(db);
}
```

### Contoh Query di DAO
```dart
// Select all
Future<List<ExperienceData>> getAllExperiences() {
  return (select(experienceEntity)..orderBy((t) => t.startDate)).get();
}

// Watch (reactive)
Stream<List<ExperienceData>> watchExperiences() {
  return (select(experienceEntity)).watch();
}

// Insert
Future<int> insertExperience(ExperiencesCompanion entry) {
  return into(experienceEntity).insert(entry);
}

// Update
Future<bool> updateExperience(ExperiencesCompanion entry) {
  return update(experienceEntity).replace(entry);
}

// Delete
Future<int> deleteExperience(String id) {
  return (delete(experienceEntity)..where((t) => t.id.equals(id))).go();
}
```

## 🔄 Repository Pattern

### Interface (Domain Layer)
File: `lib/domain/repository/*.dart`

```dart
abstract class ExperienceRepository {
  Future<UIDataEntity<List<ExperienceData>>> getExperiences();
  Future<UIDataEntity<bool>> addExperience(ExperienceData data);
  // ...
}
```

### Implementasi (Data Layer)
File: `lib/data/repository/*.dart`

```dart
class ExperienceRepositoryImpl implements ExperienceRepository {
  final ExperienceDao _experienceDao;

  ExperienceRepositoryImpl(this._experienceDao);

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

## 📍 Alur Data Lengkap
```
UI (Presentation)
    ↓ memanggil
Repository Interface (Domain)
    ↓ implements
Repository Impl (Data) [mapping entity → model]
    ↓ memanggil
DAO (Drift) [query]
    ↓ mengakses
AppDatabase (SQLite)
```

## 🔨 Code Generation

Setelah mengubah entity/DAO, **WAJIB regenerate** file `.g.dart`:
```bash
dart run build_runner build --delete-conflicting-outputs
```

File generated:
- `*_dao.g.dart` — untuk DAO
- `databases.g.dart` — untuk database
- `*.g.dart` — untuk entity (jika ada)

## ✅ Aturan
1. **JANGAN panggil DAO langsung dari UI** — selalu lewat repository
2. **Entity Drift ≠ UI Model** — buat model terpisah di `lib/domain/model/ui/`
3. **Gunakan `UIDataEntity<T>`** untuk wrapper hasil query
4. **ID menggunakan UUID** (`Uuid().v4()`) sebagai `clientDefault`
5. **Regenerate `.g.dart`** setelah mengubah entity/DAO
6. **Sesuaikan `AppDatabase.schemaVersion`** jika ada perubahan schema
7. **Migration** dengan `MigrationStrategy` jika schema berubah