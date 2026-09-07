import 'package:equatable/equatable.dart';

class ProjectUiModel extends Equatable {
  final String id;
  final String slug;
  final String title;
  final String description;
  final String? overview;
  final String? architecture;
  final String? challenges;
  final String category;
  final List<String> techStacks;
  final String imagePath;
  final String? demoUrl;
  final String? githubUrl;
  final String? playStoreUrl;

  const ProjectUiModel({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    this.overview,
    this.architecture,
    this.challenges,
    required this.category,
    this.techStacks = const [],
    required this.imagePath,
    this.demoUrl,
    this.githubUrl,
    this.playStoreUrl,
  });

  factory ProjectUiModel.fromJson(Map<String, dynamic> json) {
    return ProjectUiModel(
      id: json['id']?.toString() ?? '',
      slug: json['slug'] ?? (json['title'] != null ? (json['title'] as String).toLowerCase().replaceAll(' ', '-') : ''),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      overview: json['overview'],
      architecture: json['architecture'],
      challenges: json['challenges'],
      category: json['category'] ?? 'Mobile',
      techStacks: (json['tech_stacks'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      imagePath: json['image_url'] ?? json['image_path'] ?? 'assets/project_dummy.png',
      demoUrl: json['demo_url'],
      githubUrl: json['github_url'],
      playStoreUrl: json['playstore_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'title': title,
      'description': description,
      'overview': overview,
      'architecture': architecture,
      'challenges': challenges,
      'category': category,
      'tech_stacks': techStacks,
      'image_url': imagePath,
      'demo_url': demoUrl,
      'github_url': githubUrl,
      'playstore_url': playStoreUrl,
    };
  }

  @override
  List<Object?> get props => [
        id,
        slug,
        title,
        description,
        overview,
        architecture,
        challenges,
        category,
        techStacks,
        imagePath,
        demoUrl,
        githubUrl,
        playStoreUrl,
      ];
}
