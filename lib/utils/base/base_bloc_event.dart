import 'package:equatable/equatable.dart' show Equatable;
import 'package:web_portofolio/domain/model/ui/ui_data_entity.dart';

abstract class BaseBlocEvent extends Equatable { }

abstract class BaseBlocState extends Equatable { }

class LoadingState extends BaseBlocState {
  @override
  List<Object> get props => [];
}

abstract class ReturnDataState<T> extends BaseBlocState {
  UIDataEntity<T> entity = UIDataEntity();

  ReturnDataState(this.entity);

  @override
  List<Object> get props => [entity];
}