import 'package:equatable/equatable.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';

class OrganizationUiEntity extends Equatable {
  String id = "";
  String orgName = "";
  String description = "";
  String startDate = "";
  String endDate = "";
  bool hasFinished = false;

  OrganizationUiEntity({
    required this.id,
    required this.orgName,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.hasFinished
  });

  factory OrganizationUiEntity.fromEntity(OrganizationData entity) {
    return OrganizationUiEntity(
      id: entity.id,
      orgName: entity.orgName,
      description: entity.description,
      startDate: entity.startDate.toString(),
      endDate: entity.endDate.toString(),
      hasFinished: entity.hasFinished
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}