import 'package:equatable/equatable.dart';
import 'package:web_portofolio/domain/model/ui/project_ui_model.dart';

abstract class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object?> get props => [];
}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectLoaded extends ProjectState {
  final List<ProjectUiModel> allProjects;
  final List<ProjectUiModel> filteredProjects;
  final String selectedCategory;

  const ProjectLoaded({
    required this.allProjects,
    required this.filteredProjects,
    this.selectedCategory = "All",
  });

  @override
  List<Object?> get props => [allProjects, filteredProjects, selectedCategory];
}

class ProjectError extends ProjectState {
  final String message;
  const ProjectError(this.message);

  @override
  List<Object?> get props => [message];
}
