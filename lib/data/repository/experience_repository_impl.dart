import 'package:web_portofolio/data/remote/call/supabase_client_service.dart';
import 'package:web_portofolio/domain/model/ui/experience_ui_entity.dart';
import 'package:web_portofolio/domain/model/ui/ui_data_entity.dart';
import 'package:web_portofolio/domain/repository/experience_repository.dart';

class ExperienceRepositoryImpl implements ExperienceRepository {
  final SupabaseClientService supabaseService;

  ExperienceRepositoryImpl({required this.supabaseService});

  final List<ExperienceUiEntity> _defaultExperiences = [
    ExperienceUiEntity(
      id: "1",
      companyName: "Soul Parking",
      role: "Lead Mobile Engineer",
      description: "Developing scalable Android & Flutter parking system applications with NFC integration and real-time backend sync.",
      startDate: "Feb 2025",
      endDate: "Present",
      hasFinished: false,
    ),
    ExperienceUiEntity(
      id: "2",
      companyName: "Goodeva Technology",
      role: "Android Developer",
      description: "Built and maintained multiple client native Android applications, implemented responsive UI and clean architecture.",
      startDate: "Nov 2021",
      endDate: "Jun 2022",
      hasFinished: true,
    ),
  ];

  @override
  Future<UIDataEntity<List<ExperienceUiEntity>>> getExperiences() async {
    try {
      if (supabaseService.isInitialized) {
        final data = await supabaseService.fetchTable('experiences');
        if (data.isNotEmpty) {
          final list = data.map((json) => ExperienceUiEntity(
            id: json['id']?.toString() ?? '',
            companyName: json['company_name'] ?? '',
            role: json['role'] ?? '',
            description: json['description'] ?? '',
            startDate: json['start_date'] ?? '',
            endDate: json['end_date'] ?? '',
            hasFinished: json['has_finished'] ?? false,
          )).toList();
          return UIDataEntity(isError: false, data: list);
        }
      }
      return UIDataEntity(isError: false, data: _defaultExperiences);
    } catch (e) {
      return UIDataEntity(isError: true, message: e.toString(), data: _defaultExperiences);
    }
  }
}
