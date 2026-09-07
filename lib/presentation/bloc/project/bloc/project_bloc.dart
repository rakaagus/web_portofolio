import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/domain/model/ui/project_ui_model.dart';
import 'package:web_portofolio/domain/repository/project_repository.dart';
import 'package:web_portofolio/presentation/bloc/project/bloc/project_event.dart';
import 'package:web_portofolio/presentation/bloc/project/bloc/project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository projectRepository;
  List<ProjectUiModel> _allProjects = [];

  ProjectBloc({required this.projectRepository}) : super(ProjectInitial()) {
    on<LoadProjects>(_onLoadProjects);
    on<FilterProjectsByCategory>(_onFilterProjectsByCategory);
  }

  Future<void> _onLoadProjects(LoadProjects event, Emitter<ProjectState> emit) async {
    emit(ProjectLoading());
    final result = await projectRepository.getProjects();

    if (result.isError && (result.data == null || result.data!.isEmpty)) {
      emit(ProjectError(result.message.isNotEmpty ? result.message : "Gagal memuat proyek."));
    } else {
      _allProjects = result.data ?? [];
      final filtered = _applyFilter(_allProjects, event.category);
      emit(ProjectLoaded(
        allProjects: _allProjects,
        filteredProjects: filtered,
        selectedCategory: event.category,
      ));
    }
  }

  void _onFilterProjectsByCategory(FilterProjectsByCategory event, Emitter<ProjectState> emit) {
    final filtered = _applyFilter(_allProjects, event.category);
    emit(ProjectLoaded(
      allProjects: _allProjects,
      filteredProjects: filtered,
      selectedCategory: event.category,
    ));
  }

  List<ProjectUiModel> _applyFilter(List<ProjectUiModel> list, String category) {
    if (category == "All") return list;
    return list.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
  }
}
