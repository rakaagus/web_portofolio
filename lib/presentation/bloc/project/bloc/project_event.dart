import 'package:equatable/equatable.dart';

abstract class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object?> get props => [];
}

class LoadProjects extends ProjectEvent {
  final String category;
  const LoadProjects({this.category = "All"});

  @override
  List<Object?> get props => [category];
}

class FilterProjectsByCategory extends ProjectEvent {
  final String category;
  const FilterProjectsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}
