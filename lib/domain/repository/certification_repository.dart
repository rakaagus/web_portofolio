import 'package:web_portofolio/domain/model/ui/certification_ui_entity.dart';
import 'package:web_portofolio/domain/model/ui/ui_data_entity.dart';

abstract class CertificationRepository {
  Future<UIDataEntity<List<CertificationUiEntity>>> getCertifications();
}
