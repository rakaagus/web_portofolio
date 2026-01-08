import 'package:drift/drift.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';
import 'package:web_portofolio/data/local/entity/organization_entity.dart';

part 'organization_dao.g.dart';

@DriftAccessor(tables: [OrganizationEntity])
class OrganizationDao extends DatabaseAccessor<AppDatabase> with _$OrganizationDaoMixin {
  OrganizationDao(AppDatabase db) : super(db);
}