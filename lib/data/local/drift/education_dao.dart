import 'package:drift/drift.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';
import 'package:web_portofolio/data/local/entity/education_entity.dart';

part 'education_dao.g.dart';

@DriftAccessor(tables: [EducationEntity])
class EducationDao extends DatabaseAccessor<AppDatabase> with _$EducationDaoMixin {
  EducationDao(AppDatabase db) : super(db);
}
