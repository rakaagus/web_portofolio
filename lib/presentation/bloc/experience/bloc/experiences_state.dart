import 'package:equatable/equatable.dart';
import 'package:web_portofolio/domain/model/ui/certification_ui_entity.dart';
import 'package:web_portofolio/domain/model/ui/experience_ui_entity.dart';

abstract class ExperiencesState extends Equatable {
  const ExperiencesState();

  @override
  List<Object?> get props => [];
}

class ExperienceInitial extends ExperiencesState {}

class ExperienceLoading extends ExperiencesState {}

class ExperienceLoaded extends ExperiencesState {
  final List<ExperienceUiEntity> experiences;
  final List<CertificationUiEntity> certifications;
  final int activeTab; // 0 = Work, 1 = Organization, 2 = Certifications

  const ExperienceLoaded({
    required this.experiences,
    required this.certifications,
    this.activeTab = 0,
  });

  @override
  List<Object?> get props => [experiences, certifications, activeTab];
}

class ExperienceError extends ExperiencesState {
  final String message;
  const ExperienceError(this.message);

  @override
  List<Object?> get props => [message];
}
