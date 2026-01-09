import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:web_portofolio/utils/contant.dart';

String PortoUuidGenerator() => const Uuid().v4();

@DataClassName(KEY_TABLE_PORTO)
class PortoEntity extends Table {
  TextColumn get id => text().clientDefault(PortoUuidGenerator)();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get platform => text()();
  TextColumn get stack => text()();
  DateTimeColumn get createDate => dateTime()();
  TextColumn get link => text()();

  @override
  Set<Column> get primaryKey => {id};
}