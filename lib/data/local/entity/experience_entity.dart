import 'package:drift/drift.dart';
import 'package:web_portofolio/utils/contant.dart';

@DataClassName(KEY_TABLE_EXPERIENCES)
class ExperienceEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get companyName => text().withLength(min: 1, max: 100)();
  TextColumn get description => text()();
  TextColumn get role => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  BoolColumn get hasFinished => boolean().withDefault(const Constant(false))();
}