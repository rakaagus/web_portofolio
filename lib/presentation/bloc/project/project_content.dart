import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/bloc/project/widget/dummy_project_data.dart';
import 'package:web_portofolio/presentation/widget/empty_data_widget.dart';
import 'package:web_portofolio/presentation/widget/global_footer.dart';
import 'package:web_portofolio/presentation/widget/global_project_card.dart';
import 'package:web_portofolio/presentation/widget/gradient_background.dart';
import 'package:web_portofolio/presentation/widget/tech_chip.dart';
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

  final List<ProjectData> _allProjects = List.generate(
    12,
        (index) => ProjectData(
      imagePath: 'assets/project_dummy.png',
      title: index % 2 == 0 ? "Smart Parking System $index" : "Wedding Platform $index",
      description: "A comprehensive solution with NFC integration, real-time monitoring, and seamless mobile payments.",
      category: index % 2 == 0 ? "Mobile" : "Web",
      techStacks: [
        TechChip(label: "Flutter", color: Colors.blue),
        TechChip(label: "Kotlin", color: Colors.orange),
        TechChip(label: "Firebase", color: Colors.amber),
      ],
      demoLinkText: index % 2 == 0 ? "Demo" : "Source",
      demoIcon: index % 2 == 0 ? Icons.open_in_new_rounded : Icons.code_rounded,
    ),
  );

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

  List<ProjectData> get _filteredProjects {
    if (_selectedCategory == "All") {
      return _allProjects;
    }
    return _allProjects.where((p) => p.category == _selectedCategory).toList();
  }

  int get _totalPages {
    int total = (_filteredProjects.length / _itemsPerPage).ceil();
    return total == 0 ? 1 : total;
  }

  List<ProjectData> get _paginatedProjects {
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    if (startIndex >= _filteredProjects.length) return [];

    return _filteredProjects.sublist(
      startIndex,
      endIndex > _filteredProjects.length ? _filteredProjects.length : endIndex,
    );
  }

  void _changeCategory(String category) {
    setState(() {
      _selectedCategory = category;
      _currentPage = 1;
    });
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
                  const SizedBox(height: 48),

                  // --- GRID PROJECTS ---
                  if (_paginatedProjects.isEmpty)
                    EmptyDataCardWidget(
                      title: l10n.emptyData(l10n.projectsTitle),
                      description: l10n.ctaProjectEmptyDesc(_selectedCategory),
                      isHaveButton: true,
                      iconTitle: l10n.ctaProjectEmptyBtn,
                      buttonIcon: Icons.refresh_rounded,
                      onPressButton: () => _changeCategory("All"),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                        mainAxisExtent: mainAxisExtent,
                      ),
                      itemCount: _paginatedProjects.length,
                      itemBuilder: (context, index) {
                        final project = _paginatedProjects[index];
                        return ProjectCard(
                          width: double.infinity, // Memastikan lebar kartu sesuai Grid
                          imagePath: project.imagePath,
                          title: project.title,
                          description: project.description,
                          category: project.category,
                          techStacks: project.techStacks,
                          demoLinkText: project.demoLinkText,
                          onTap: () {
                            widget.onNavigate(project.title);
                          },
                        );
                      },
                    ),

                  const SizedBox(height: 40),
                  if (_totalPages > 1) _buildPagination(isDark, colorScheme),

                  const SizedBox(height: 80),
                  EmptyDataCardWidget(
                    title: l10n.ctaTitle,
                    description: l10n.ctaSubtitle,
                    isHaveButton: true,
                    iconTitle: l10n.ctaButton,
                    onPressButton: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPagination(bool isDark, ColorScheme colorScheme) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left_rounded),
          onPressed: _currentPage > 1 ? () => setState(() => _currentPage--) : null,
          color: colorScheme.onSurface,
        ),
        const SizedBox(width: 12),
        Text(
          l10n.pageIndicator(_currentPage, _totalPages),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          icon: const Icon(Icons.chevron_right_rounded),
          onPressed: _currentPage < _totalPages ? () => setState(() => _currentPage++) : null,
          color: colorScheme.onSurface,
        ),
      ],
    );
  }
}

