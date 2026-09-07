import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/domain/model/ui/certification_ui_entity.dart';
import 'package:web_portofolio/domain/model/ui/experience_ui_entity.dart';
import 'package:web_portofolio/domain/repository/certification_repository.dart';
import 'package:web_portofolio/domain/repository/experience_repository.dart';
import 'package:web_portofolio/presentation/bloc/experience/bloc/experiences_event.dart';
import 'package:web_portofolio/presentation/bloc/experience/bloc/experiences_state.dart';

class ExperiencesBloc extends Bloc<ExperiencesEvent, ExperiencesState> {
  final ExperienceRepository experienceRepository;
  final CertificationRepository certificationRepository;

  List<ExperienceUiEntity> _experiences = [];
  List<CertificationUiEntity> _certifications = [];
  int _activeTab = 0;

  ExperiencesBloc({
    required this.experienceRepository,
    required this.certificationRepository,
  }) : super(ExperienceInitial()) {
    on<LoadExperiencesData>(_onLoadExperiencesData);
    on<SelectExperienceTab>(_onSelectExperienceTab);
  }

  Future<void> _onLoadExperiencesData(LoadExperiencesData event, Emitter<ExperiencesState> emit) async {
    emit(ExperienceLoading());

    final expResult = await experienceRepository.getExperiences();
    final certResult = await certificationRepository.getCertifications();

    _experiences = expResult.data ?? [];
    _certifications = certResult.data ?? [];

    emit(ExperienceLoaded(
      experiences: _experiences,
      certifications: _certifications,
      activeTab: _activeTab,
    ));
  }

  void _onSelectExperienceTab(SelectExperienceTab event, Emitter<ExperiencesState> emit) {
    _activeTab = event.tabIndex;
    emit(ExperienceLoaded(
      experiences: _experiences,
      certifications: _certifications,
      activeTab: _activeTab,
    ));
  }
}
