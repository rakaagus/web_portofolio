import 'package:drift/drift.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';
import 'package:web_portofolio/data/local/entity/porto_entity.dart';

part 'porto_dao.g.dart';

@DriftAccessor(tables: [PortoEntity])
class PortoDao extends DatabaseAccessor<AppDatabase> with _$PortoDaoMixin {
  PortoDao(AppDatabase db) : super(db);
}