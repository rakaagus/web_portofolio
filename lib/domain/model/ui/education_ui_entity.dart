import 'package:equatable/equatable.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';

class EducationUiEntity extends Equatable {
  String id = "";
  String eduName = "";
  String description = "";
  String startDate = "";
  String endDate = "";
  bool hasFinished = false;

  EducationUiEntity({
    required this.id,
    required this.eduName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.hasFinished
  });

  factory EducationUiEntity.fromEntity(EducationData entity) {
    return EducationUiEntity(
      id: entity.id,
      eduName: entity.eduName,
      description: entity.description,
      startDate: entity.startDate.toString(),
      endDate: entity.endDate.toString(),
      hasFinished: entity.hasFinished
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}