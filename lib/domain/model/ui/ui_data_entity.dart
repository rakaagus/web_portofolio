import 'package:equatable/equatable.dart';

class UIDataEntity<T> extends Equatable{
  bool isError = false;
  String message = "";
  T? data;

  UIDataEntity({this.isError = false, this.message = "", this.data});

  factory UIDataEntity.fromDynamic(UIDataEntity<dynamic> dynamicModel) {
    return UIDataEntity(isError: dynamicModel.isError, message: dynamicModel.message, data: null);
  }

  @override
  List<Object?> get props => [isError, message, data];
}