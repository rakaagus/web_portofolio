import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_portofolio/di/injection_container.dart';
import 'package:web_portofolio/domain/model/ui/project_ui_model.dart';
import 'package:web_portofolio/domain/repository/project_repository.dart';
import 'package:web_portofolio/presentation/widget/global_button.dart';
import 'package:web_portofolio/presentation/widget/global_footer.dart';
import 'package:web_portofolio/presentation/widget/gradient_background.dart';
import 'package:web_portofolio/presentation/widget/hovered_card_widget.dart';
import 'package:web_portofolio/presentation/widget/project_cover_widget.dart';
import 'package:web_portofolio/presentation/widget/scroll_reveal_widget.dart';
import 'package:web_portofolio/presentation/widget/tech_chip.dart';

class ProjectDetailContent extends StatefulWidget {
  final String slug;
  final ScrollController scrollController;
  final Function(String url) onNavigate;

  const ProjectDetailContent({
    super.key,
    required this.slug,
    required this.scrollController,
    required this.onNavigate,
  });

  @override
  State<ProjectDetailContent> createState() => _ProjectDetailContentState();
}

class _ProjectDetailContentState extends State<ProjectDetailContent> {
  ProjectUiModel? _project;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProject();
  }

  Future<void> _loadProject() async {
    try {
      final repo = locator<ProjectRepository>();
      final result = await repo.getProjectBySlug(widget.slug);
      if (mounted) {
        setState(() {
          _project = result.data;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _launchExternalUrl(String urlString) async {
    if (urlString.isEmpty) return;
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final project = _project;
    if (project == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Project not found"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => widget.onNavigate('/projects'),
              child: const Text("Back to Projects"),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        const Positioned.fill(
          child: MeshGradientBackground(style: 2),
        ),
        ListView(
          controller: widget.scrollController,
          padding: EdgeInsets.zero,
          children: [
            SizedBox(height: isMobile ? 90 : 120),
            Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1100),
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScrollRevealWidget(
                      delay: Duration.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Breadcrumbs
                          Row(
                            children: [
                              InkWell(
                                onTap: () => widget.onNavigate('/projects'),
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.arrow_back_rounded, size: 16, color: colorScheme.primary),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Projects",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text("  /  ", style: TextStyle(color: colorScheme.onSurface.withOpacity(0.4))),
                              Flexible(
                                child: Text(
                                  project.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: colorScheme.onSurface.withOpacity(0.7),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Title
                          Text(
                            project.title,
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: isMobile ? 32 : 44,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Tech stacks chips (Consistently styled matching the Card!)
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: project.techStacks.map((tech) {
                              return TechChip(label: tech);
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Project Image / Hero Card (Consistently matching the Card!)
                    ScrollRevealWidget(
                      delay: const Duration(milliseconds: 100),
                      child: HoverSolidCard(
                        padding: EdgeInsets.zero,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: ProjectCoverWidget(
                            imagePath: project.imagePath,
                            title: project.title,
                            category: project.category,
                            techStacks: project.techStacks,
                            height: isMobile ? 260 : 420,
                            isHero: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Case Study Details (Two column or responsive vertical)
                    ScrollRevealWidget(
                      delay: const Duration(milliseconds: 150),
                      child: Flex(
                        direction: isMobile ? Axis.vertical : Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Left Column: Overview & Architecture
                          Expanded(
                            flex: isMobile ? 0 : 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionCard(
                                  context: context,
                                  icon: Icons.lightbulb_outline_rounded,
                                  title: "Project Overview",
                                  content: (project.overview != null && project.overview!.isNotEmpty)
                                      ? project.overview!
                                      : project.description,
                                ),
                                const SizedBox(height: 24),
                                _buildSectionCard(
                                  context: context,
                                  icon: Icons.architecture_rounded,
                                  title: "Technical Architecture & Decisions",
                                  content: (project.architecture != null && project.architecture!.isNotEmpty)
                                      ? project.architecture!
                                      : "Engineered following Clean Architecture separation of concerns: Presentation layer with BLoC state management, Domain layer with business use cases, and Data layer with repository caching.",
                                ),
                                const SizedBox(height: 24),
                                _buildSectionCard(
                                  context: context,
                                  icon: Icons.bolt_rounded,
                                  title: "Key Engineering Challenges",
                                  content: (project.challenges != null && project.challenges!.isNotEmpty)
                                      ? project.challenges!
                                      : "Ensuring low-latency UI responsiveness, offline data consistency, robust error boundaries, and seamless cross-platform rendering across viewports.",
                                ),
                              ],
                            ),
                          ),
                          if (!isMobile) const SizedBox(width: 32),
                          if (isMobile) const SizedBox(height: 24),

                          // Right Column: Project Meta & Actions
                          Expanded(
                            flex: isMobile ? 0 : 4,
                            child: HoverSolidCard(
                              padding: const EdgeInsets.all(28),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Project Info",
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  _buildMetaRow(context, "Role", "Lead Mobile / Fullstack Engineer"),
                                  const Divider(height: 24),
                                  _buildMetaRow(context, "Category", project.category),
                                  const Divider(height: 24),
                                  _buildMetaRow(context, "Core Platform", project.category == "Web" ? "Flutter Web (PWA)" : "Android SDK / Kotlin"),
                                  const Divider(height: 24),
                                  _buildMetaRow(context, "Tech Stacks", project.techStacks.join(", ")),
                                  const SizedBox(height: 32),
                                  GlobalButton(
                                    title: "Live Preview / Demo",
                                    icon: Icons.open_in_new_rounded,
                                    onPressed: () => _launchExternalUrl(project.demoUrl ?? ""),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton.icon(
                                      onPressed: () => _launchExternalUrl(project.githubUrl ?? ""),
                                      icon: const Icon(FontAwesomeIcons.github, size: 18),
                                      label: const Text("View Source Code"),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
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
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            GlobalFooter(
              onNavigate: (String url) {
                widget.onNavigate(url);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String content,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return HoverSolidCard(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: colorScheme.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.7,
              color: colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaRow(BuildContext context, String label, String value) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface.withOpacity(0.5),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
