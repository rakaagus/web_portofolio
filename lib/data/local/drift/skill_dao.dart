import 'package:drift/drift.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';
import 'package:web_portofolio/data/local/entity/skill_entity.dart';

part 'skill_dao.g.dart';

@DriftAccessor(tables: [SkillEntity])
class SkillDao extends DatabaseAccessor<AppDatabase> with _$SkillDaoMixin {
  SkillDao(AppDatabase db) : super(db);
}
