import 'package:drift/drift.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';
import 'package:web_portofolio/data/local/entity/experience_entity.dart';

part 'experience_dao.g.dart';

@DriftAccessor(tables: [ExperienceEntity])
class ExperienceDao extends DatabaseAccessor<AppDatabase> with _$ExperienceDaoMixin {
  ExperienceDao(AppDatabase db) : super(db);
}
