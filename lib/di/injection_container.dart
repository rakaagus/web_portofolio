import 'package:get_it/get_it.dart';
import 'package:web_portofolio/data/local/drift/database/databases.dart';
import 'package:web_portofolio/data/local/drift/education_dao.dart';
import 'package:web_portofolio/data/local/drift/experience_dao.dart';
import 'package:web_portofolio/data/local/drift/image_dao.dart';
import 'package:web_portofolio/data/local/drift/organization_dao.dart';
import 'package:web_portofolio/data/local/drift/porto_dao.dart';
import 'package:web_portofolio/data/local/drift/skill_dao.dart';
import 'package:web_portofolio/data/remote/call/supabase_client_service.dart';
import 'package:web_portofolio/data/repository/certification_repository_impl.dart';
import 'package:web_portofolio/data/repository/experience_repository_impl.dart';
import 'package:web_portofolio/data/repository/project_repository_impl.dart';
import 'package:web_portofolio/domain/repository/certification_repository.dart';
import 'package:web_portofolio/domain/repository/experience_repository.dart';
import 'package:web_portofolio/domain/repository/project_repository.dart';
import 'package:web_portofolio/presentation/bloc/experience/bloc/experiences_bloc.dart';
import 'package:web_portofolio/presentation/bloc/home/bloc/home_bloc.dart';
import 'package:web_portofolio/presentation/bloc/project/bloc/project_bloc.dart';

final getIt = GetIt.instance;
final locator = getIt;

Future<void> setupLocator() async {
  // 1. External / Service
  final supabaseService = SupabaseClientService();
  await supabaseService.init();
  getIt.registerLazySingleton<SupabaseClientService>(() => supabaseService);

  // 2. Database (Drift)
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // 3. DAOs
  getIt.registerLazySingleton<PortoDao>(() => PortoDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<ExperienceDao>(() => ExperienceDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<EducationDao>(() => EducationDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<OrganizationDao>(() => OrganizationDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<SkillDao>(() => SkillDao(getIt<AppDatabase>()));
  getIt.registerLazySingleton<ImageDao>(() => ImageDao(getIt<AppDatabase>()));

  // 4. Repositories
  getIt.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoryImpl(supabaseService: getIt<SupabaseClientService>()),
  );
  getIt.registerLazySingleton<CertificationRepository>(
    () => CertificationRepositoryImpl(supabaseService: getIt<SupabaseClientService>()),
  );
  getIt.registerLazySingleton<ExperienceRepository>(
    () => ExperienceRepositoryImpl(supabaseService: getIt<SupabaseClientService>()),
  );

  // 5. BLoCs
  getIt.registerFactory<ProjectBloc>(
    () => ProjectBloc(projectRepository: getIt<ProjectRepository>()),
  );
  getIt.registerFactory<ExperiencesBloc>(
    () => ExperiencesBloc(
      experienceRepository: getIt<ExperienceRepository>(),
      certificationRepository: getIt<CertificationRepository>(),
    ),
  );
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(
      projectRepository: getIt<ProjectRepository>(),
      certificationRepository: getIt<CertificationRepository>(),
      experienceRepository: getIt<ExperienceRepository>(),
    ),
  );
}
