import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/bloc/experience/widget/job_entity.dart'
    show CompanyExperience, JobRole, OrganizationExperience;
import 'package:web_portofolio/presentation/widget/global_footer.dart';
import 'package:web_portofolio/presentation/widget/gradient_background.dart';
import 'package:web_portofolio/presentation/bloc/experience/widget/work_experience.dart';
import 'package:web_portofolio/presentation/bloc/experience/widget/organization_experience.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExperienceContent extends StatefulWidget {
  final ScrollController scrollController;
  final Function(String url) onNavigate;
  const ExperienceContent({super.key, required this.scrollController, required this.onNavigate});

  @override
  State<ExperienceContent> createState() => _ExperienceContentState();
}

class _ExperienceContentState extends State<ExperienceContent> {
  String _selectedCategory = "Work";

  List<CompanyExperience> getExperiences(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return [
      CompanyExperience(
        companyName: "Soul Parking",
        location: "Jakarta, Indonesia",
        totalPeriod: "Feb 2025 - Present",
        logo: Icons.local_parking_rounded,
        jobs: [
          JobRole(
            title: l10n.spRole1Title,
            type: l10n.typeFullTime,
            period: l10n.spRole1Period,
            responsibilities: [
              l10n.spRole1Resp1,
              l10n.spRole1Resp2,
              l10n.spRole1Resp3,
              l10n.spRole1Resp4,
            ],
            skills: [
              "Kotlin",
              "Jetpack Compose",
              "Android Development",
              "API Integration",
              "Cross-Team Collaboration"
            ],
          ),
          JobRole(
            title: l10n.spRole2Title,
            type: l10n.typeFullTime,
            period: l10n.spRole2Period,
            responsibilities: [
              l10n.spRole2Resp1,
              l10n.spRole2Resp2,
              l10n.spRole2Resp3,
            ],
            skills: [
              "Kotlin",
              "Android SDK",
              "UI Slicing",
              "Bug Fixing",
              "Teamwork"
            ],
          ),
        ],
      ),
      CompanyExperience(
        companyName: "Goodeva Technology",
        location: "Bekasi, Indonesia",
        totalPeriod: "Nov 2021 - Jun 2022",
        logo: Icons.business_center_rounded,
        jobs: [
          JobRole(
            title: l10n.gtRole1Title,
            type: l10n.typePartTime,
            period: l10n.gtRole1Period,
            responsibilities: [
              l10n.gtRole1Resp1,
              l10n.gtRole1Resp2,
              l10n.gtRole1Resp3,
            ],
            skills: [
              "Java",
              "Android Development",
              "UI Slicing",
              "Feature Development"
            ],
          ),
          JobRole(
            title: l10n.gtRole2Title,
            type: l10n.typeInternship,
            period: l10n.gtRole2Period,
            responsibilities: [
              l10n.gtRole2Resp1,
              l10n.gtRole2Resp2,
              l10n.gtRole2Resp3,
            ],
            skills: [
              "Java",
              "Android SDK",
              "Bug Fixing",
              "Collaboration"
            ],
          ),
        ],
      ),
    ];
  }

  List<OrganizationExperience> getOrganizations(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return [
      OrganizationExperience(
        orgName: l10n.orgDummy1Name,
        position: l10n.orgDummy1Position,
        period: l10n.orgDummy1Period,
        description: l10n.orgDummy1Desc,
        achievements: [
          l10n.orgDummy1Achv1,
          l10n.orgDummy1Achv2,
          l10n.orgDummy1Achv3,
        ],
        logo: Icons.groups_rounded,
      ),
      OrganizationExperience(
        orgName: l10n.orgDummy2Name,
        position: l10n.orgDummy2Position,
        period: l10n.orgDummy2Period,
        description: l10n.orgDummy2Desc,
        achievements: [
          l10n.orgDummy2Achv1,
          l10n.orgDummy2Achv2,
          l10n.orgDummy2Achv3,
        ],
        logo: Icons.rocket_launch_rounded,
      ),
      OrganizationExperience(
        orgName: l10n.orgDummy3Name,
        position: l10n.orgDummy3Position,
        period: l10n.orgDummy3Period,
        description: l10n.orgDummy3Desc,
        achievements: [
          l10n.orgDummy3Achv1,
          l10n.orgDummy3Achv2,
          l10n.orgDummy3Achv3,
        ],
        logo: Icons.event_rounded,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      controller: widget.scrollController,
      padding: EdgeInsets.zero,
      children: [
        _buildExperienceSection(colorScheme, isMobile, screenWidth),
        GlobalFooter(
          onNavigate: (String url) {
            widget.onNavigate(url);
          },
        ),
      ],
    );
  }

  Widget _buildExperienceSection(ColorScheme colorScheme, bool isMobile, double screenWidth) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final experiences = getExperiences(context);
    final organizations = getOrganizations(context);

    return Stack(
      children: [
        const Positioned.fill(
          child: MeshGradientBackground(style: 4),
        ),
        Container(
          padding: EdgeInsets.only(
            top: isMobile ? 100 : 140,
            bottom: isMobile ? 40 : 80,
            left: isMobile ? 16 : 24,
            right: isMobile ? 16 : 24,
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 950),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    l10n.experienceTitle,
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
                    l10n.experienceSubTitlePage,
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
                    children: ["Work", "Organization"].map((category) {
                      final isSelected = _selectedCategory == category;
                      return ChoiceChip(
                        label: Text(
                          category == "Work" ? l10n.categoryWork : l10n.categoryOrganization,
                        ),
                        selected: isSelected,
                        onSelected: (_) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
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

                  if (_selectedCategory == "Work")
                    ...experiences.asMap().entries.map((entry) {
                      final index = entry.key;
                      final exp = entry.value;
                      return ExperienceTimelineRow(
                        experience: exp,
                        colorScheme: colorScheme,
                        isLast: index == experiences.length - 1,
                        isMobile: isMobile,
                      );
                    })
                  else
                    ...organizations.asMap().entries.map((entry) {
                      final index = entry.key;
                      final org = entry.value;
                      return OrganizationTimelineRow(
                        organization: org,
                        colorScheme: colorScheme,
                        isLast: index == organizations.length - 1,
                        isMobile: isMobile,
                      );
                    }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}