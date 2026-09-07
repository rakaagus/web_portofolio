import 'package:equatable/equatable.dart';

enum AttachmentType { pdf, image }

class CertificationAttachment extends Equatable {
  final String id;
  final String title;
  final AttachmentType type;
  final String url;
  final String? thumbnailPath;
  final int pageCount;
  final String? description;

  const CertificationAttachment({
    required this.id,
    required this.title,
    required this.type,
    required this.url,
    this.thumbnailPath,
    this.pageCount = 1,
    this.description,
  });

  factory CertificationAttachment.fromJson(Map<String, dynamic> json) {
    return CertificationAttachment(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      type: json['type'] == 'image' ? AttachmentType.image : AttachmentType.pdf,
      url: json['url'] ?? '',
      thumbnailPath: json['thumbnail_path'],
      pageCount: json['page_count'] is int ? json['page_count'] : 1,
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type == AttachmentType.image ? 'image' : 'pdf',
      'url': url,
      'thumbnail_path': thumbnailPath,
      'page_count': pageCount,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        type,
        url,
        thumbnailPath,
        pageCount,
        description,
      ];
}

class CertificationUiEntity extends Equatable {
  final String id;
  final String title;
  final String issuer;
  final String issueDate;
  final String? expiryDate;
  final String credentialId;
  final String credentialUrl;
  final String? logoUrl;
  final List<String> skills;
  final List<CertificationAttachment> attachments;

  const CertificationUiEntity({
    required this.id,
    required this.title,
    required this.issuer,
    required this.issueDate,
    this.expiryDate,
    required this.credentialId,
    required this.credentialUrl,
    this.logoUrl,
    this.skills = const [],
    this.attachments = const [],
  });

  factory CertificationUiEntity.fromJson(Map<String, dynamic> json) {
    return CertificationUiEntity(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      issuer: json['issuer'] ?? '',
      issueDate: json['issue_date'] ?? '',
      expiryDate: json['expiry_date'],
      credentialId: json['credential_id'] ?? '',
      credentialUrl: json['credential_url'] ?? '',
      logoUrl: json['logo_url'],
      skills: (json['skills'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      attachments: (json['attachments'] as List<dynamic>?)
              ?.map((e) => CertificationAttachment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'issuer': issuer,
      'issue_date': issueDate,
      'expiry_date': expiryDate,
      'credential_id': credentialId,
      'credential_url': credentialUrl,
      'logo_url': logoUrl,
      'skills': skills,
      'attachments': attachments.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        issuer,
        issueDate,
        expiryDate,
        credentialId,
        credentialUrl,
        logoUrl,
        skills,
        attachments,
      ];
}
