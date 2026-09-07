import 'package:web_portofolio/data/remote/call/supabase_client_service.dart';
import 'package:web_portofolio/domain/model/ui/certification_ui_entity.dart';
import 'package:web_portofolio/domain/model/ui/ui_data_entity.dart';
import 'package:web_portofolio/domain/repository/certification_repository.dart';

class CertificationRepositoryImpl implements CertificationRepository {
  final SupabaseClientService supabaseService;

  CertificationRepositoryImpl({required this.supabaseService});

  final List<CertificationUiEntity> _defaultCertifications = const [
    CertificationUiEntity(
      id: "1",
      title: "Google Associate Android Developer",
      issuer: "Google Developers Certification",
      issueDate: "2023",
      expiryDate: "2026",
      credentialId: "AAD-8492048",
      credentialUrl: "https://developers.google.com/certification/directory",
      skills: ["Android", "Kotlin", "Jetpack", "Testing", "Clean Architecture"],
      attachments: [
        CertificationAttachment(
          id: "att_1_1",
          title: "Certificate of Completion (Official PDF)",
          type: AttachmentType.pdf,
          url: "https://developers.google.com/certification/directory/AAD-8492048.pdf",
          pageCount: 2,
          description: "Official 2-page credential certificate issued by Google Developers.",
        ),
        CertificationAttachment(
          id: "att_1_2",
          title: "Google Developer Digital Badge",
          type: AttachmentType.image,
          url: "assets/images/kotlin_logo.png",
          description: "Verified digital credential badge for Associate Android Developer.",
        ),
        CertificationAttachment(
          id: "att_1_3",
          title: "Examination Performance Scorecard",
          type: AttachmentType.image,
          url: "assets/images/profile_image.jpeg",
          description: "Official examination performance scorecard and core competencies breakdown.",
        ),
      ],
    ),
    CertificationUiEntity(
      id: "2",
      title: "Menjadi Android Developer Expert (MADE)",
      issuer: "Dicoding Indonesia",
      issueDate: "2023",
      credentialId: "DICODING-MADE-91823",
      credentialUrl: "https://www.dicoding.com/certificates",
      skills: ["Kotlin", "Coroutines", "Room Database", "Dagger/Hilt", "Clean Architecture"],
      attachments: [
        CertificationAttachment(
          id: "att_2_1",
          title: "Dicoding Graduate Certificate (PDF)",
          type: AttachmentType.pdf,
          url: "https://www.dicoding.com/certificates/DICODING-MADE-91823.pdf",
          pageCount: 2,
          description: "Full graduate certificate and curriculum verification from Dicoding Indonesia.",
        ),
        CertificationAttachment(
          id: "att_2_2",
          title: "Dicoding Android Expert Digital Badge",
          type: AttachmentType.image,
          url: "assets/images/firebase_icon.png",
          description: "Official Dicoding Indonesia verified graduate badge.",
        ),
      ],
    ),
    CertificationUiEntity(
      id: "3",
      title: "Belajar Fundamental Aplikasi Flutter",
      issuer: "Dicoding Indonesia",
      issueDate: "2024",
      credentialId: "DICODING-FLUTTER-77124",
      credentialUrl: "https://www.dicoding.com/certificates",
      skills: ["Flutter", "Dart", "BLoC", "State Management", "REST API"],
      attachments: [
        CertificationAttachment(
          id: "att_3_1",
          title: "Flutter Fundamental Certificate (PDF)",
          type: AttachmentType.pdf,
          url: "https://www.dicoding.com/certificates/DICODING-FLUTTER-77124.pdf",
          pageCount: 1,
          description: "Verified certificate for Flutter architecture and state management.",
        ),
        CertificationAttachment(
          id: "att_3_2",
          title: "Course Completion Badge",
          type: AttachmentType.image,
          url: "assets/images/profile_image.jpeg",
          description: "Digital badge of completion.",
        ),
      ],
    ),
    CertificationUiEntity(
      id: "4",
      title: "Jetpack Compose: Building Modern Android Apps",
      issuer: "Android Developers",
      issueDate: "2024",
      credentialId: "JC-ANDROID-2024",
      credentialUrl: "https://developer.android.com/courses/pathways/compose",
      skills: ["Declarative UI", "Compose State", "Material 3", "Animations"],
      attachments: [
        CertificationAttachment(
          id: "att_4_1",
          title: "Android Developers Compose Pathway PDF",
          type: AttachmentType.pdf,
          url: "https://developer.android.com/courses/pathways/compose.pdf",
          pageCount: 1,
          description: "Official Android Developers Pathway Certificate.",
        ),
        CertificationAttachment(
          id: "att_4_2",
          title: "Pathway Completion Badge",
          type: AttachmentType.image,
          url: "assets/images/kotlin_logo.png",
          description: "Modern Android Development digital badge.",
        ),
      ],
    ),
  ];

  @override
  Future<UIDataEntity<List<CertificationUiEntity>>> getCertifications() async {
    try {
      if (supabaseService.isInitialized) {
        final data = await supabaseService.fetchTable('certifications');
        if (data.isNotEmpty) {
          final list = data.map((json) => CertificationUiEntity.fromJson(json)).toList();
          return UIDataEntity(isError: false, data: list);
        }
      }
      return UIDataEntity(isError: false, data: _defaultCertifications);
    } catch (e) {
      return UIDataEntity(isError: true, message: e.toString(), data: _defaultCertifications);
    }
  }
}
