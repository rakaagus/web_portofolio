import 'package:drift/drift.dart';
import 'package:web_portofolio/utils/contant.dart';
import 'package:web_portofolio/utils/enum/platform_enum.dart';

@DataClassName(KEY_TABLE_SKILL)
class SkillEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get skillName => text()();
  TextColumn get description => text()();
  TextColumn get skillSet => text()();
  IntColumn get proficiency => integer()();
}