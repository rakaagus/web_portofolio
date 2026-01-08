import 'package:drift/drift.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';
import 'package:web_portofolio/data/local/entity/image_entity.dart';

part 'image_dao.g.dart';

@DriftAccessor(tables: [ImageEntity])
class ImageDao extends DatabaseAccessor<AppDatabase> with _$ImageDaoMixin {
  ImageDao(AppDatabase db) : super(db);
}
