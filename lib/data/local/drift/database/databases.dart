import 'package:drift_flutter/drift_flutter.dart';
import 'package:drift/drift.dart';
import 'package:web_portofolio/data/local/drift/education_dao.dart';
import 'package:web_portofolio/data/local/drift/experience_dao.dart';
import 'package:web_portofolio/data/local/drift/image_dao.dart';
import 'package:web_portofolio/data/local/drift/organization_dao.dart';
import 'package:web_portofolio/data/local/drift/porto_dao.dart';
import 'package:web_portofolio/data/local/drift/skill_dao.dart';
import 'package:web_portofolio/data/local/entity/education_entity.dart';
import 'package:web_portofolio/data/local/entity/experience_entity.dart';
import 'package:web_portofolio/data/local/entity/image_entity.dart';
import 'package:web_portofolio/data/local/entity/organization_entity.dart';
import 'package:web_portofolio/data/local/entity/porto_entity.dart';
import 'package:web_portofolio/data/local/entity/skill_entity.dart';

part 'databases.g.dart';

@DriftDatabase(tables: [
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
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      // onUpgrade: (m, from, to) async {
      //   if (from == 1) {
      //     await m.createTable(PortoEntity);
      //   }
      // }
    );
  }

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