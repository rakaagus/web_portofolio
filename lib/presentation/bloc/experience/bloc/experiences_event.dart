import 'package:equatable/equatable.dart';

abstract class ExperiencesEvent extends Equatable {
  const ExperiencesEvent();

  @override
  List<Object?> get props => [];
}

class LoadExperiencesData extends ExperiencesEvent {
  const LoadExperiencesData();
}

class SelectExperienceTab extends ExperiencesEvent {
  final int tabIndex;
  const SelectExperienceTab(this.tabIndex);

  @override
  List<Object?> get props => [tabIndex];
}
