import 'package:equatable/equatable.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';

class PortoUiEntity extends Equatable{

  String id = "";
  String title = "";
  String description = "";
  String platform = "";
  String stack = "";
  String createDate = "";
  String link = "";

  PortoUiEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.platform,
    required this.stack,
    required this.createDate,
    required this.link,
  });

  // for createData using toString for a while
  factory PortoUiEntity.fromEntity(PortoData entity) {
    return PortoUiEntity(
        id: entity.id,
        title: entity.title,
        description: entity.description,
        platform: entity.platform,
        stack: entity.stack,
        createDate: entity.createDate.toString(),
        link: entity.link
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}