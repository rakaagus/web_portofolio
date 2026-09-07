import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/domain/model/ui/project_ui_model.dart';
import 'package:web_portofolio/presentation/Navigation/app_routes.dart';
import 'package:web_portofolio/presentation/bloc/project/bloc/project_bloc.dart';
import 'package:web_portofolio/presentation/bloc/project/bloc/project_event.dart';
import 'package:web_portofolio/presentation/bloc/project/bloc/project_state.dart';
import 'package:web_portofolio/presentation/widget/empty_data_widget.dart';
import 'package:web_portofolio/presentation/widget/global_footer.dart';
import 'package:web_portofolio/presentation/widget/global_project_card.dart';
import 'package:web_portofolio/presentation/widget/gradient_background.dart';
import 'package:web_portofolio/presentation/widget/collaboration_dialog.dart';
import 'package:web_portofolio/presentation/widget/tech_chip.dart';
import 'package:web_portofolio/presentation/widget/scroll_reveal_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProjectContent extends StatefulWidget {
  final ScrollController scrollController;
  final Function(String url) onNavigate;

  const ProjectContent({
    super.key,
    required this.scrollController,
    required this.onNavigate,
  });

  @override
  State<ProjectContent> createState() => _ProjectContentState();
}

class _ProjectContentState extends State<ProjectContent> {
  String _selectedCategory = "All";
  int _currentPage = 1;
  final int _itemsPerPage = 6;

  final List<String> _categories = ["All", "Mobile", "Web", "Desktop"];

  String _getCategoryLabel(String key, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case "Mobile":
        return l10n.categoryMobile;
      case "Web":
        return l10n.categoryWeb;
      case "Desktop":
        return l10n.categoryDesktop;
      case "All":
      default:
        return l10n.categoryAll;
    }
  }

  void _changeCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _currentPage = 1;
    });
    context.read<ProjectBloc>().add(FilterProjectsByCategory(category));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      controller: widget.scrollController,
      padding: EdgeInsets.zero,
      children: [
        _buildProjectsSection(screenWidth),
        GlobalFooter(
          onNavigate: (String url) {
            widget.onNavigate(url);
          },
        ),
      ],
    );
  }

  Widget _buildProjectsSection(double screenWidth) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bool isMobile = screenWidth < 650;
    final bool isTablet = screenWidth >= 650 && screenWidth < 950;

    final int crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);
    final double mainAxisExtent = isMobile ? 570 : (isTablet ? 580 : 580);

    final l10n = AppLocalizations.of(context)!;

    return Stack(
      children: [
        const Positioned.fill(
          child: MeshGradientBackground(style: 3),
        ),
        Container(
          padding: EdgeInsets.only(
            top: isMobile ? 100 : 140,
            bottom: isMobile ? 60 : 100,
            left: isMobile ? 16 : 24,
            right: isMobile ? 16 : 24,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ScrollRevealWidget(
                    delay: Duration.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          l10n.projectsTitle,
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: isMobile ? 32 : 40,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.projectsSubTitle,
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        // --- CATEGORY FILTERS ---
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: _categories.map((category) {
                            final isSelected = _selectedCategory == category;
                            return ChoiceChip(
                              label: Text(_getCategoryLabel(category, context)),
                              selected: isSelected,
                              onSelected: (_) => _changeCategory(category),
                              selectedColor: colorScheme.onSurface,
                              backgroundColor: isDark ? colorScheme.onSurface.withOpacity(0.1) : Colors.black.withOpacity(0.04),
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurface.withOpacity(0.7),
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: 13,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: isSelected
                                      ? Colors.transparent
                                      : colorScheme.onSurface.withOpacity(0.15),
                                ),
                              ),
                              showCheckmark: false,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // --- GRID PROJECTS VIA BLOC ---
                  BlocBuilder<ProjectBloc, ProjectState>(
                    builder: (context, state) {
                      if (state is ProjectLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      List<ProjectUiModel> filteredList = [];
                      if (state is ProjectLoaded) {
                        filteredList = state.filteredProjects;
                      }

                      if (filteredList.isEmpty) {
                        return EmptyDataCardWidget(
                          title: l10n.emptyData(l10n.projectsTitle),
                          description: l10n.ctaProjectEmptyDesc(_selectedCategory),
                          isHaveButton: true,
                          iconTitle: l10n.ctaProjectEmptyBtn,
                          buttonIcon: Icons.refresh_rounded,
                          onPressButton: () => _changeCategory("All"),
                        );
                      }

                      final int totalPages = (filteredList.length / _itemsPerPage).ceil();
                      final int actualTotalPages = totalPages == 0 ? 1 : totalPages;

                      final startIndex = (_currentPage - 1) * _itemsPerPage;
                      final endIndex = startIndex + _itemsPerPage;
                      final paginatedList = startIndex >= filteredList.length
                          ? <ProjectUiModel>[]
                          : filteredList.sublist(
                              startIndex,
                              endIndex > filteredList.length ? filteredList.length : endIndex,
                            );

                      return Column(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 24,
                              mainAxisSpacing: 24,
                              mainAxisExtent: mainAxisExtent,
                            ),
                            itemCount: paginatedList.length,
                            itemBuilder: (context, index) {
                              final project = paginatedList[index];
                              return ScrollRevealWidget(
                                delay: Duration(milliseconds: (index % 6) * 80),
                                child: ProjectCard(
                                  width: double.infinity,
                                  imagePath: project.imagePath,
                                  title: project.title,
                                  description: project.description,
                                  category: project.category,
                                  techStacks: project.techStacks.map((tech) {
                                    return TechChip(label: tech);
                                  }).toList(),
                                  demoLinkText: "Case Study",
                                  onTap: () {
                                    widget.onNavigate(AppRoutes.projectDetailPath(project.slug));
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 40),
                          if (actualTotalPages > 1)
                            _buildPagination(isDark, colorScheme, actualTotalPages),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 80),
                  EmptyDataCardWidget(
                    title: l10n.ctaTitle,
                    description: l10n.ctaSubtitle,
                    isHaveButton: true,
                    iconTitle: l10n.ctaButton,
                    onPressButton: () => CollaborationDialog.show(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination(bool isDark, ColorScheme colorScheme, int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _currentPage > 1
              ? () => setState(() => _currentPage--)
              : null,
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        const SizedBox(width: 8),
        for (int i = 1; i <= totalPages; i++)
          GestureDetector(
            onTap: () => setState(() => _currentPage = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _currentPage == i
                    ? colorScheme.onSurface
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: _currentPage == i
                      ? Colors.transparent
                      : (isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.1)),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "$i",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: _currentPage == i
                      ? colorScheme.surface
                      : colorScheme.onSurface,
                ),
              ),
            ),
          ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: _currentPage < totalPages
              ? () => setState(() => _currentPage++)
              : null,
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}
