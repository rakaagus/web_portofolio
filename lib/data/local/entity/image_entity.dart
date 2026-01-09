import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:web_portofolio/utils/contant.dart';

String imageUuIdGene() => const Uuid().v4();

@DataClassName(KEY_TABLE_IMAGE)
class ImageEntity extends Table {
 TextColumn get id => text().clientDefault(imageUuIdGene)();
 TextColumn get src => text()();

 @override
 Set<Column> get primaryKey => {id};
}