import 'package:equatable/equatable.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';

class SkillUiEntity extends Equatable {
  String id = "";
  String skillName = "";
  String description = "";
  String skillSet = "";
  int proficiency = 0;

  SkillUiEntity({
    required this.id,
    required this.skillName,
    required this.description,
    required this.skillSet,
    required this.proficiency
  });

  factory SkillUiEntity.fromEntity(SkillData entity) {
    return SkillUiEntity(
      id: entity.id,
      skillName: entity.skillName,
      description: entity.description,
      skillSet: entity.skillSet,
      proficiency: entity.proficiency
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}