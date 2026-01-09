import 'package:equatable/equatable.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';

class ExperienceUiEntity extends Equatable {
  String id = "";
  String companyName = "";
  String description = "";
  String role = "";
  String startDate = "";
  String endDate = "";
  bool hasFinished = false;

  ExperienceUiEntity({
    required this.id,
    required this.companyName,
    required this.description,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.hasFinished
  });

  factory ExperienceUiEntity.fromEntity(ExperienceData entity) {
    return ExperienceUiEntity(
      id: entity.id,
      companyName: entity.companyName,
      description: entity.description,
      role: entity.role,
      startDate: entity.startDate.toString(),
      endDate: entity.endDate.toString(),
      hasFinished: entity.hasFinished
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}