import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_portofolio/domain/model/ui/certification_ui_entity.dart';
import 'package:web_portofolio/presentation/widget/certificate_viewer_dialog.dart';
import 'package:web_portofolio/presentation/widget/hovered_card_widget.dart';
import 'package:web_portofolio/presentation/widget/tech_chip.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CertificationCard extends StatelessWidget {
  final CertificationUiEntity certification;
  final bool isDark;
  final bool isMobile;

  const CertificationCard({
    super.key,
    required this.certification,
    required this.isDark,
    required this.isMobile,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return HoverSolidCard(
      padding: EdgeInsets.all(isMobile ? 20 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: colorScheme.primary.withOpacity(0.15),
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(0.3),
                  ),
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: colorScheme.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      certification.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 16 : 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.verified_rounded,
                          size: 15,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            certification.issuer,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface.withOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Attachments Section with Visual Thumbnails & Dark Hover Overlay
          _buildAttachmentsSection(context, isDark, colorScheme),
          const SizedBox(height: 16),

          // Date & Credential ID
          Row(
            children: [
              Icon(Icons.calendar_today_rounded, size: 14, color: colorScheme.onSurface.withOpacity(0.5)),
              const SizedBox(width: 6),
              Text(
                "Issued ${certification.issueDate}${certification.expiryDate != null ? ' · Expires ${certification.expiryDate}' : ''}",
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
          if (certification.credentialId.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                Icon(Icons.tag_rounded, size: 14, color: colorScheme.onSurface.withOpacity(0.5)),
                const SizedBox(width: 6),
                Text(
                  "${l10n.credentialIdLabel}${certification.credentialId}",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),

          // Skills
          if (certification.skills.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: certification.skills.map((skill) {
                return TechChip(
                  label: skill,
                  color: colorScheme.primary,
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],

          // Action Button: Only Show Credential (Preview Document button removed as requested)
          if (certification.credentialUrl.isNotEmpty)
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () => _launchUrl(certification.credentialUrl),
                icon: const Icon(Icons.open_in_new_rounded, size: 15),
                label: Text(
                  l10n.viewCredentialBtn,
                  style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? Colors.white : const Color(0xFF0D1527),
                  foregroundColor: isDark ? Colors.black : Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAttachmentsSection(BuildContext context, bool isDark, ColorScheme colorScheme) {
    final attachments = certification.attachments.isNotEmpty
        ? certification.attachments
        : [
            CertificationAttachment(
              id: "def_pdf",
              title: "${certification.title} (PDF)",
              type: AttachmentType.pdf,
              url: certification.credentialUrl,
              pageCount: 2,
            ),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.attach_file_rounded, size: 14, color: colorScheme.onSurface.withOpacity(0.6)),
            const SizedBox(width: 4),
            Text(
              "Attachments (${attachments.length})",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface.withOpacity(0.6),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: attachments.asMap().entries.map((entry) {
            final index = entry.key;
            final attachment = entry.value;

            return _AttachmentThumbnailWidget(
              attachment: attachment,
              isDark: isDark,
              colorScheme: colorScheme,
              onTap: () {
                CertificateViewerDialog.show(
                  context,
                  certification,
                  initialIndex: index,
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _AttachmentThumbnailWidget extends StatefulWidget {
  final CertificationAttachment attachment;
  final bool isDark;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _AttachmentThumbnailWidget({
    required this.attachment,
    required this.isDark,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  State<_AttachmentThumbnailWidget> createState() => _AttachmentThumbnailWidgetState();
}

class _AttachmentThumbnailWidgetState extends State<_AttachmentThumbnailWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isPdf = widget.attachment.type == AttachmentType.pdf;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 190,
          height: 110,
          decoration: BoxDecoration(
            color: widget.isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered
                  ? (widget.isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7))
                  : (widget.isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.08)),
              width: _isHovered ? 1.6 : 1.0,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Miniature Thumbnail Graphic
              if (isPdf)
                _buildPdfMiniature(widget.isDark)
              else
                _buildImageMiniature(),

              // Dark Hover Overlay ("ketika di hover itu menjadi agak sedikit gelap")
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isHovered ? 1.0 : 0.0,
                child: Container(
                  color: Colors.black.withOpacity(0.55), // Dark overlay on hover
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.fullscreen_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Click to view",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Label Tag
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.isDark ? const Color(0xFF0F172A).withOpacity(0.9) : Colors.white.withOpacity(0.9),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isPdf ? Icons.picture_as_pdf_rounded : Icons.image_rounded,
                        size: 11,
                        color: isPdf ? Colors.redAccent : Colors.lightBlue,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.attachment.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: widget.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPdfMiniature(bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 24),
      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "PDF",
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.redAccent),
                ),
              ),
              const Icon(Icons.workspace_premium_rounded, size: 14, color: Colors.amber),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 4,
            width: 80,
            decoration: BoxDecoration(
              color: isDark ? Colors.white24 : Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 3,
            width: 100,
            decoration: BoxDecoration(
              color: isDark ? Colors.white12 : Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 3,
            width: 60,
            decoration: BoxDecoration(
              color: isDark ? Colors.white12 : Colors.black12,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageMiniature() {
    return Image.asset(
      widget.attachment.url,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            Icons.image_outlined,
            size: 32,
            color: widget.colorScheme.primary.withOpacity(0.5),
          ),
        );
      },
    );
  }
}
