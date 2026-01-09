import 'package:equatable/equatable.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';

class ImageUiEntity extends Equatable {
  String id = "";
  String src = "";

  ImageUiEntity({
    required this.id,
    required this.src
  });

  factory ImageUiEntity.fromEntity(ImageData entity) {
    return ImageUiEntity(
      id: entity.id,
      src: entity.src
    );
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}