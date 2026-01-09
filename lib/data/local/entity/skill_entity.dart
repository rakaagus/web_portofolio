import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:web_portofolio/utils/contant.dart';

String SkillUuidGenerator() => const Uuid().v4();

@DataClassName(KEY_TABLE_SKILL)
class SkillEntity extends Table {
  TextColumn get id => text().clientDefault(SkillUuidGenerator)();
  TextColumn get skillName => text()();
  TextColumn get description => text()();
  TextColumn get skillSet => text()();
  IntColumn get proficiency => integer()();

  @override
  Set<Column> get primaryKey => {id};
}