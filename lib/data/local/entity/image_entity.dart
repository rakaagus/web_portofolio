import 'package:drift/drift.dart';
import 'package:web_portofolio/utils/contant.dart';

@DataClassName(KEY_TABLE_IMAGE)
class ImageEntity extends Table {
 IntColumn get id => integer().autoIncrement()();
 TextColumn get src => text()();
}