import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/domain/repository/certification_repository.dart';
import 'package:web_portofolio/domain/repository/experience_repository.dart';
import 'package:web_portofolio/domain/repository/project_repository.dart';
import 'package:web_portofolio/presentation/bloc/home/bloc/home_event.dart';
import 'package:web_portofolio/presentation/bloc/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProjectRepository projectRepository;
  final CertificationRepository certificationRepository;
  final ExperienceRepository experienceRepository;

  HomeBloc({
    required this.projectRepository,
    required this.certificationRepository,
    required this.experienceRepository,
  }) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    final projectsRes = await projectRepository.getProjects();
    final certsRes = await certificationRepository.getCertifications();
    final expsRes = await experienceRepository.getExperiences();

    emit(HomeLoaded(
      featuredProjects: projectsRes.data ?? [],
      featuredCertifications: certsRes.data ?? [],
      experiences: expsRes.data ?? [],
    ));
  }
}
