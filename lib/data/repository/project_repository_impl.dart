import 'package:web_portofolio/data/remote/call/supabase_client_service.dart';
import 'package:web_portofolio/domain/model/ui/project_ui_model.dart';
import 'package:web_portofolio/domain/model/ui/ui_data_entity.dart';
import 'package:web_portofolio/domain/repository/project_repository.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final SupabaseClientService supabaseService;

  ProjectRepositoryImpl({required this.supabaseService});

  final List<ProjectUiModel> _defaultProjects = [
    const ProjectUiModel(
      id: "1",
      slug: "smart-parking-system",
      title: "Smart Parking System",
      description: "A comprehensive parking solution with NFC integration, real-time monitoring, and seamless mobile payments.",
      overview: "Smart Parking System is designed to modernize vehicle management across large commercial areas. Features include fast NFC gate tapping, automated ticketless plate recognition, and live lot occupancy monitoring.",
      architecture: "Engineered with Clean Architecture and MVI pattern on Android using Kotlin & Jetpack Compose, paired with a Flutter Web dashboard for parking operators.",
      challenges: "Low-latency NFC communication with hardware turnstiles, offline transactional queueing when parking lot connectivity drops, and real-time WebSocket state syncing.",
      category: "Mobile",
      techStacks: ["Flutter", "Kotlin", "NFC", "Firebase", "Jetpack Compose"],
      imagePath: "",
      demoUrl: "https://github.com/rakaagus",
      githubUrl: "https://github.com/rakaagus",
    ),
    const ProjectUiModel(
      id: "2",
      slug: "wedding-reservation-platform",
      title: "Wedding Reservation Platform",
      description: "Modular wedding invitation and attendance reservation system built for high scalability and customization.",
      overview: "A responsive digital invitation and reservation platform allowing couples to customize themes, manage RSVP lists in real-time, and verify guest arrivals with QR codes.",
      architecture: "Built with Flutter Web utilizing responsive breakpoints, Bloc state management, and Cloud Firestore for live guest check-in counters.",
      challenges: "Rendering smooth animations across varying mobile browser engines and handling concurrent RSVP spikes.",
      category: "Web",
      techStacks: ["Flutter Web", "Dart", "BLoC", "Firebase"],
      imagePath: "",
      demoUrl: "https://github.com/rakaagus",
      githubUrl: "https://github.com/rakaagus",
    ),
    const ProjectUiModel(
      id: "3",
      slug: "smart-pos-handheld",
      title: "Smart POS Handheld",
      description: "Android-based Point of Sale system optimized for handheld devices with thermal printer and e-money support.",
      overview: "An enterprise-grade Android POS application deployed on dedicated mobile terminals (Sunmi / Pax) with integrated thermal printing and multi-payment gateways.",
      architecture: "Kotlin Android SDK, Room DB offline-first persistence, Coroutines & Flow, and direct hardware ESC/POS printer driver integration.",
      challenges: "Bluetooth/USB printer spooling stability, fast barcode scanning, and multi-tenant ledger reconciliations.",
      category: "Mobile",
      techStacks: ["Android SDK", "Kotlin", "Room DB", "Hardware Interop"],
      imagePath: "",
      demoUrl: "https://github.com/rakaagus",
      githubUrl: "https://github.com/rakaagus",
    ),
  ];

  @override
  Future<UIDataEntity<List<ProjectUiModel>>> getProjects({String? category}) async {
    try {
      if (supabaseService.isInitialized) {
        final data = await supabaseService.fetchTable('projects');
        if (data.isNotEmpty) {
          var projects = data.map((json) => ProjectUiModel.fromJson(json)).toList();
          if (category != null && category != "All") {
            projects = projects.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
          }
          return UIDataEntity(isError: false, data: projects);
        }
      }

      // Fallback data
      var list = _defaultProjects;
      if (category != null && category != "All") {
        list = list.where((p) => p.category.toLowerCase() == category.toLowerCase()).toList();
      }
      return UIDataEntity(isError: false, data: list);
    } catch (e) {
      return UIDataEntity(isError: true, message: e.toString(), data: _defaultProjects);
    }
  }

  @override
  Future<UIDataEntity<ProjectUiModel>> getProjectBySlug(String slug) async {
    try {
      if (supabaseService.isInitialized) {
        final data = await supabaseService.fetchSingle('projects', 'slug', slug);
        if (data != null) {
          return UIDataEntity(isError: false, data: ProjectUiModel.fromJson(data));
        }
      }

      final matched = _defaultProjects.firstWhere(
        (p) => p.slug == slug || p.title.toLowerCase().replaceAll(' ', '-') == slug,
        orElse: () => _defaultProjects.first,
      );
      return UIDataEntity(isError: false, data: matched);
    } catch (e) {
      return UIDataEntity(isError: true, message: e.toString(), data: _defaultProjects.first);
    }
  }
}
