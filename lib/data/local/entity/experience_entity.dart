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