import 'package:equatable/equatable.dart';
import 'package:web_portofolio/domain/model/ui/certification_ui_entity.dart';
import 'package:web_portofolio/domain/model/ui/experience_ui_entity.dart';
import 'package:web_portofolio/domain/model/ui/project_ui_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<ProjectUiModel> featuredProjects;
  final List<CertificationUiEntity> featuredCertifications;
  final List<ExperienceUiEntity> experiences;

  const HomeLoaded({
    required this.featuredProjects,
    required this.featuredCertifications,
    required this.experiences,
  });

  @override
  List<Object?> get props => [featuredProjects, featuredCertifications, experiences];
}

class HomeError extends HomeState {
  final String message;
  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
