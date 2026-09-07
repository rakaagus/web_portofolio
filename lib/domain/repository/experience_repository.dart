import 'package:web_portofolio/domain/model/ui/experience_ui_entity.dart';
import 'package:web_portofolio/domain/model/ui/ui_data_entity.dart';

abstract class ExperienceRepository {
  Future<UIDataEntity<List<ExperienceUiEntity>>> getExperiences();
}
