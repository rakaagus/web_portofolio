import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_portofolio/domain/model/ui/certification_ui_entity.dart';
import 'package:web_portofolio/presentation/widget/tech_chip.dart';

class CertificateViewerDialog extends StatefulWidget {
  final CertificationUiEntity certification;
  final int initialIndex;

  const CertificateViewerDialog({
    super.key,
    required this.certification,
    this.initialIndex = 0,
  });

  static Future<void> show(
    BuildContext context,
    CertificationUiEntity cert, {
    int initialIndex = 0,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CertificateViewerDialog(
        certification: cert,
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  State<CertificateViewerDialog> createState() => _CertificateViewerDialogState();
}

class _CertificateViewerDialogState extends State<CertificateViewerDialog> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    final count = _getEffectiveAttachments().length;
    _currentIndex = widget.initialIndex.clamp(0, count > 0 ? count - 1 : 0);
  }

  List<CertificationAttachment> _getEffectiveAttachments() {
    if (widget.certification.attachments.isNotEmpty) {
      return widget.certification.attachments;
    }
    // Fallback default attachment if none specified
    return [
      CertificationAttachment(
        id: "default_pdf",
        title: "${widget.certification.title} (Official PDF)",
        type: AttachmentType.pdf,
        url: widget.certification.credentialUrl,
        pageCount: 2,
        description: "Official credential certificate issued by ${widget.certification.issuer}.",
      ),
      CertificationAttachment(
        id: "default_badge",
        title: "${widget.certification.issuer} Digital Badge",
        type: AttachmentType.image,
        url: "assets/images/kotlin_logo.png",
        description: "Verified digital credential badge.",
      ),
    ];
  }

  void _nextAttachment() {
    final attachments = _getEffectiveAttachments();
    if (_currentIndex < attachments.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  void _prevAttachment() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final attachments = _getEffectiveAttachments();
    final currentAttachment = attachments[_currentIndex];
    final bool hasNext = _currentIndex < attachments.length - 1;
    final bool hasPrev = _currentIndex > 0;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 860, maxHeight: 880),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F172A) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.08),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.45),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top App Bar / Document Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  // Attachment Type Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: currentAttachment.type == AttachmentType.pdf
                          ? Colors.redAccent.withOpacity(0.15)
                          : const Color(0xFF38BDF8).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          currentAttachment.type == AttachmentType.pdf
                              ? Icons.picture_as_pdf_rounded
                              : Icons.image_rounded,
                          size: 14,
                          color: currentAttachment.type == AttachmentType.pdf
                              ? Colors.redAccent
                              : const Color(0xFF38BDF8),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          currentAttachment.type == AttachmentType.pdf ? "CHROME PDF VIEWER" : "IMAGE ATTACHMENT",
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: currentAttachment.type == AttachmentType.pdf
                                ? Colors.redAccent
                                : const Color(0xFF38BDF8),
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      "VERIFIED",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF10B981),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Counter indicator
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "${_currentIndex + 1} / ${attachments.length}",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_rounded, color: colorScheme.onSurface.withOpacity(0.7)),
                    tooltip: "Close",
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Main Viewer Viewport
            Expanded(
              child: currentAttachment.type == AttachmentType.pdf
                  ? _buildChromePdfViewer(context, currentAttachment, isDark, colorScheme)
                  : _buildImageViewer(context, currentAttachment, isDark, colorScheme),
            ),
            const Divider(height: 1),

            // Bottom Navigation Bar & Thumbnail Strip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Thumbnails row selector
                  if (attachments.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: attachments.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final att = entry.value;
                            final isSelected = idx == _currentIndex;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentIndex = idx;
                                });
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                margin: const EdgeInsets.symmetric(horizontal: 6),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? (isDark ? const Color(0xFF1E293B) : Colors.white)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected
                                        ? (isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7))
                                        : (isDark ? Colors.white12 : Colors.black12),
                                    width: isSelected ? 1.8 : 1.0,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.1),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          )
                                        ]
                                      : null,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      att.type == AttachmentType.pdf
                                          ? Icons.picture_as_pdf_rounded
                                          : Icons.image_rounded,
                                      size: 15,
                                      color: att.type == AttachmentType.pdf ? Colors.redAccent : Colors.lightBlue,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      att.title,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                        color: isSelected
                                            ? colorScheme.onSurface
                                            : colorScheme.onSurface.withOpacity(0.6),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),

                  // Bottom Action Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Prev / Next Controls
                      Row(
                        children: [
                          _buildNavPillButton(
                            isDark: isDark,
                            icon: Icons.arrow_back_rounded,
                            label: "Previous",
                            onPressed: hasPrev ? _prevAttachment : null,
                            isForward: false,
                          ),
                          const SizedBox(width: 8),
                          _buildNavPillButton(
                            isDark: isDark,
                            icon: Icons.arrow_forward_rounded,
                            label: "Next",
                            onPressed: hasNext ? _nextAttachment : null,
                            isForward: true,
                          ),
                        ],
                      ),

                      // External link & Close
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text("Close"),
                          ),
                          if (widget.certification.credentialUrl.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            ElevatedButton.icon(
                              onPressed: () => _launchUrl(widget.certification.credentialUrl),
                              icon: const Icon(Icons.open_in_new_rounded, size: 15),
                              label: const Text("Verify Credential"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isDark ? Colors.white : const Color(0xFF0D1527),
                                foregroundColor: isDark ? Colors.black : Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavPillButton({
    required bool isDark,
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
    required bool isForward,
  }) {
    final bool isEnabled = onPressed != null;
    final bgColor = isDark
        ? (isEnabled ? const Color(0xFF1E293B) : const Color(0xFF1E293B).withOpacity(0.35))
        : (isEnabled ? const Color(0xFFE2E8F0) : const Color(0xFFF1F5F9));
    final fgColor = isDark
        ? (isEnabled ? Colors.white : Colors.white24)
        : (isEnabled ? const Color(0xFF0F172A) : Colors.black26);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isDark ? Colors.white.withOpacity(0.06) : Colors.black.withOpacity(0.04),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isForward) ...[
                Icon(icon, size: 16, color: fgColor),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: fgColor,
                ),
              ),
              if (isForward) ...[
                const SizedBox(width: 6),
                Icon(icon, size: 16, color: fgColor),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Chrome-like PDF Document Viewer with Dark Canvas & Smooth Vertical Scroll
  Widget _buildChromePdfViewer(
    BuildContext context,
    CertificationAttachment attachment,
    bool isDark,
    ColorScheme colorScheme,
  ) {
    return Container(
      color: const Color(0xFF282C34), // Standard dark Chrome PDF viewer canvas background
      child: Column(
        children: [
          // Chrome PDF Floating Toolbar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF20232A),
              border: Border(
                bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.picture_as_pdf_rounded, color: Colors.redAccent, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    attachment.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    "Page 1 / ${attachment.pageCount}",
                    style: const TextStyle(color: Colors.white70, fontSize: 11, fontFamily: 'monospace'),
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(Icons.zoom_out_rounded, color: Colors.white70, size: 18),
                const SizedBox(width: 8),
                const Text("100%", style: TextStyle(color: Colors.white70, fontSize: 11)),
                const SizedBox(width: 8),
                const Icon(Icons.zoom_in_rounded, color: Colors.white70, size: 18),
                const SizedBox(width: 12),
                const Icon(Icons.fit_screen_rounded, color: Colors.white70, size: 18),
              ],
            ),
          ),

          // Scrollable PDF Page Stack (vertical scroll like Chrome)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  // PAGE 1: Official Certificate of Completion
                  _buildPdfPageSheet(
                    pageNumber: 1,
                    child: Column(
                      children: [
                        // Certificate Top Seal & Ribbon
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.amber.shade50,
                            border: Border.all(color: Colors.amber.shade700, width: 2),
                          ),
                          child: Icon(
                            Icons.workspace_premium_rounded,
                            size: 34,
                            color: Colors.amber.shade700,
                          ),
                        ),
                        const SizedBox(height: 14),

                        Text(
                          "CERTIFICATE OF COMPLETION",
                          style: TextStyle(
                            fontSize: 11.5,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        const SizedBox(height: 12),

                        Text(
                          widget.certification.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 12),

                        const Text(
                          "This is to officially certify that",
                          style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "Raka Agus Maulana",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "has successfully demonstrated proficiency and achieved all credential standards required by ${widget.certification.issuer}.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.5,
                            color: Color(0xFF475569),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Certificate Metadata Box inside document
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Text("ISSUED DATE", style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600, letterSpacing: 0.8)),
                                  const SizedBox(height: 3),
                                  Text(widget.certification.issueDate, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                                ],
                              ),
                              if (widget.certification.credentialId.isNotEmpty)
                                Column(
                                  children: [
                                    const Text("CREDENTIAL ID", style: TextStyle(fontSize: 9.5, color: Color(0xFF64748B), fontWeight: FontWeight.w600, letterSpacing: 0.8)),
                                    const SizedBox(height: 3),
                                    Text(widget.certification.credentialId, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'monospace', color: Color(0xFF0F172A))),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Skills
                        if (widget.certification.skills.isNotEmpty)
                          Wrap(
                            spacing: 6,
                            runSpacing: 6,
                            alignment: WrapAlignment.center,
                            children: widget.certification.skills.map((skill) {
                              return TechChip(label: skill);
                            }).toList(),
                          ),
                        const SizedBox(height: 24),

                        // Signatures & Issuer Seal Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 110,
                                  height: 1,
                                  color: Colors.black26,
                                ),
                                const SizedBox(height: 4),
                                const Text("Authorized Examiner", style: TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 110,
                                  height: 1,
                                  color: Colors.black26,
                                ),
                                const SizedBox(height: 4),
                                Text(widget.certification.issuer, style: const TextStyle(fontSize: 10, color: Color(0xFF64748B), fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // PAGE 2 (If multi-page PDF): Curriculum & Competencies Breakdown
                  if (attachment.pageCount > 1) ...[
                    const SizedBox(height: 28),
                    _buildPdfPageSheet(
                      pageNumber: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "CURRICULUM TRANSCRIPT & EVALUATION",
                                style: TextStyle(
                                  fontSize: 11,
                                  letterSpacing: 2.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade900,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  "STATUS: PASSED",
                                  style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(),
                          const SizedBox(height: 12),

                          const Text(
                            "Verified Competencies & Performance Domains:",
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                          ),
                          const SizedBox(height: 12),

                          _buildCompetencyRow("Mobile System Architecture & Clean Code", "Exceeds Expectations (100%)"),
                          _buildCompetencyRow("State Management & Lifecycle Management", "Proficient (95%)"),
                          _buildCompetencyRow("Local Storage, Caching & Offline-First DB", "Proficient (92%)"),
                          _buildCompetencyRow("Network Resilience & REST/GraphQL API", "Proficient (96%)"),
                          _buildCompetencyRow("Automated Testing (Unit & Widget Tests)", "Exceeds Expectations (98%)"),

                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Note: This credential is an authentic and tamper-evident official certification issued by the governing organization. All rights reserved.",
                              style: TextStyle(fontSize: 10.5, fontStyle: FontStyle.italic, color: Color(0xFF64748B)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Realistic Paper Page Container mimicking PDF page
  Widget _buildPdfPageSheet({required int pageNumber, required Widget child}) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 680),
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          child,
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Page $pageNumber",
              style: const TextStyle(fontSize: 9.5, color: Color(0xFF94A3B8), fontFamily: 'monospace'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompetencyRow(String label, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.check_circle_rounded, size: 15, color: Color(0xFF10B981)),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF334155), fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          Text(
            status,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
        ],
      ),
    );
  }

  // High-Resolution Image Viewer
  Widget _buildImageViewer(
    BuildContext context,
    CertificationAttachment attachment,
    bool isDark,
    ColorScheme colorScheme,
  ) {
    return Container(
      color: isDark ? const Color(0xFF0B1120) : const Color(0xFFF1F5F9),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 480, maxWidth: 540),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                attachment.url,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 280,
                    width: 280,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image_outlined, size: 60, color: colorScheme.primary.withOpacity(0.5)),
                        const SizedBox(height: 12),
                        Text(
                          attachment.title,
                          style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              attachment.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            if (attachment.description != null) ...[
              const SizedBox(height: 6),
              Text(
                attachment.description!,
                style: TextStyle(fontSize: 13, color: colorScheme.onSurface.withOpacity(0.7)),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
