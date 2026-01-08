import 'package:drift/drift.dart';
import 'package:web_portofolio/utils/contant.dart';

@DataClassName(KEY_TABLE_PORTO)
class PortoEntity extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get platform => text()();
  TextColumn get stack => text()();
  DateTimeColumn get createDate => dateTime()();
  TextColumn get link => text()();
}