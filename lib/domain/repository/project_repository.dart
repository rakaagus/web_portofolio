import 'package:web_portofolio/domain/model/ui/project_ui_model.dart';
import 'package:web_portofolio/domain/model/ui/ui_data_entity.dart';

abstract class ProjectRepository {
  Future<UIDataEntity<List<ProjectUiModel>>> getProjects({String? category});
  Future<UIDataEntity<ProjectUiModel>> getProjectBySlug(String slug);
}
