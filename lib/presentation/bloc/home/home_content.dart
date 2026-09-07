import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_portofolio/presentation/bloc/home/widget/experience_card.dart';
import 'package:web_portofolio/presentation/bloc/home/widget/github_contribution_card.dart';
import 'package:web_portofolio/presentation/bloc/home/widget/tech_stak_widget.dart';
import 'package:web_portofolio/presentation/widget/global_project_card.dart';
import 'package:web_portofolio/presentation/widget/hovered_card_widget.dart' show HoverGlassCard, HoverSolidCard;
import 'package:web_portofolio/presentation/widget/global_button.dart';
import 'package:web_portofolio/presentation/widget/global_footer.dart';
import 'package:web_portofolio/presentation/widget/gradient_background.dart';
import 'package:web_portofolio/presentation/widget/tech_chip.dart';
import 'package:web_portofolio/utils/color_theme.dart';
import 'widget/testimonial_section_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/domain/model/ui/project_ui_model.dart';
import 'package:web_portofolio/presentation/Navigation/app_routes.dart';
import 'package:web_portofolio/presentation/bloc/home/bloc/home_bloc.dart';
import 'package:web_portofolio/presentation/bloc/home/bloc/home_state.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:web_portofolio/presentation/widget/scroll_reveal_widget.dart';
import 'package:web_portofolio/presentation/widget/collaboration_dialog.dart';


class HomeContent extends StatefulWidget {
  final ScrollController scrollController;
  final Function(String url) onNavigate;
  const HomeContent({super.key, required this.scrollController, required this.onNavigate});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with SingleTickerProviderStateMixin {
  late AnimationController _arrowController;
  late Animation<double> _arrowAnimation;
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactMessageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _arrowController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _arrowAnimation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: _arrowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _arrowController.dispose();
    _contactNameController.dispose();
    _contactEmailController.dispose();
    _contactMessageController.dispose();
    super.dispose();
  }

  void _scrollToContent() {
    widget.scrollController.animateTo(
      MediaQuery.of(context).size.height,
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      debugPrint("Tidak dapat membuka link: $urlString");
    }
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
        _buildHeroSection(colorScheme, isMobile),
        _buildSectionAbout(colorScheme, isMobile, screenWidth),
        _buildSectionExperience(colorScheme, isMobile, screenWidth),
        _wrapThreeSectionContent(colorScheme, isMobile, screenWidth),
        GlobalFooter(
          onNavigate: (String url) {
            widget.onNavigate(url);
          },
        )
      ],
    );
  }

  Widget _buildHeroSection(ColorScheme colorScheme, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const MeshGradientBackground(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: isDark
                            ? const [Color(0xFF5EEAD4), Color(0xFFFB923C)]
                            : const [Colors.black, Color(0xFF5EEAD4)],
                      ).createShader(Offset.zero & bounds.size),
                      child: Text(
                        AppLocalizations.of(context)!.helloIntro,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: isMobile ? 45 : 56,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isDark
                              ? const [Color(0xFFFB923C), Color(0xFF5EEAD4)]
                              : const [Color(0xFF5EEAD4), Color(0xFFFB923C)],
                          tileMode: TileMode.clamp
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                      child: Text(
                        AppLocalizations.of(context)!.myName,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: isMobile ? 45 : 56,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    AppLocalizations.of(context)!.heroDescription,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(
                      icon: FontAwesomeIcons.github,
                      tooltip: "GitHub",
                      onPressed: () => _launchURL("https://github.com/rakaagus"),
                    ),
                    const SizedBox(width: 16),
                    _buildSocialIcon(
                      icon: FontAwesomeIcons.linkedin,
                      tooltip: "LinkedIn",
                      onPressed: () => _launchURL("https://www.linkedin.com/in/raka-agus-maulana/"),
                    ),
                    const SizedBox(width: 16),
                    _buildSocialIcon(
                      icon: FontAwesomeIcons.instagram,
                      tooltip: "Instagram",
                      onPressed: () => _launchURL("https://www.instagram.com/rakaagus.m/"),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GlobalButton(title: AppLocalizations.of(context)!.viewWorkBtn, onPressed: () {
                  widget.onNavigate('/experience');
                }),
              ],
            ),
          ),
          Positioned(
              bottom: isMobile ? 110 : 40,
              child: AnimatedBuilder(
                animation: _arrowAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _arrowAnimation.value),
                    child: child,
                  );
                },
                child: InkWell(
                  onTap: _scrollToContent,
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: colorScheme.onSurface,
                      size: 40,
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget _buildSectionAbout(ColorScheme colorScheme, bool isMobile, double screenWidth) {
    final bool isTablet = screenWidth >= 650 && screenWidth < 1100;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final profileCard = HoverSolidCard(
      padding: EdgeInsets.all(isMobile ? 24 : 40),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: isMobile ? 260 : 320,
              width: isMobile ? 260 : 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: const DecorationImage(
                  image: AssetImage('assets/images/profile_image.jpeg'),
                  fit: BoxFit.contain,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 12),
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              "Raka Agus",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "MOBILE ENGINEER",
              style: TextStyle(
                letterSpacing: 2,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            GlobalButton(
              title: AppLocalizations.of(context)!.downloadResume,
              icon: Icons.file_download_outlined,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );

    final bioCard = HoverSolidCard(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.welcome,
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.bioText1,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.8,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.bioText2,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.8,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );

    final educationCard = HoverSolidCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.educationTag,
                style: TextStyle(
                  letterSpacing: 2,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.schoolName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                AppLocalizations.of(context)!.degreeName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: isDark ? colorScheme.tertiary : colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "2021 - Feb 2025",
                style: TextStyle(
                  fontSize: 13,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.educationGpa,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    final blogsCard = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.onNavigate('/blogs');
        },
        child: HoverSolidCard(
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.blogsTag,
                        style: TextStyle(
                          letterSpacing: 2,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                      Icon(
                        Icons.arrow_outward_rounded,
                        color: isDark ? colorScheme.tertiary : colorScheme.primary,
                        size: 20,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.blogsTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.blogsDesc,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    final techStackCard = HoverTechStackCard(
      colorScheme: colorScheme,
      isDark: Theme.of(context).brightness == Brightness.dark,
      isMobile: isMobile,
    );

    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          const Positioned.fill(
            child: MeshGradientBackground(style: 2),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 120,
              horizontal: isMobile ? 24 : (isTablet ? 40 : screenWidth * 0.1),
            ),
            child: Column(
              children: [
                ScrollRevealWidget(
                  delay: Duration.zero,
                  offsetSlide: 25,
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.aboutTitle,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        AppLocalizations.of(context)!.aboutDesc,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                if (isMobile)
                  Column(
                    children: [
                      ScrollRevealWidget(
                        delay: const Duration(milliseconds: 0),
                        offsetSlide: 30,
                        child: profileCard,
                      ),
                      const SizedBox(height: 24),
                      ScrollRevealWidget(
                        delay: const Duration(milliseconds: 80),
                        offsetSlide: 30,
                        child: bioCard,
                      ),
                      const SizedBox(height: 24),
                      ScrollRevealWidget(
                        delay: const Duration(milliseconds: 140),
                        offsetSlide: 30,
                        child: educationCard,
                      ),
                      const SizedBox(height: 24),
                      ScrollRevealWidget(
                        delay: const Duration(milliseconds: 200),
                        offsetSlide: 30,
                        child: blogsCard,
                      ),
                      const SizedBox(height: 24),
                      ScrollRevealWidget(
                        delay: const Duration(milliseconds: 260),
                        offsetSlide: 30,
                        child: techStackCard,
                      ),
                    ],
                  )
                else if (isTablet)
                  Column(
                    children: [
                      ScrollRevealWidget(
                        delay: const Duration(milliseconds: 0),
                        offsetSlide: 30,
                        child: profileCard,
                      ),
                      const SizedBox(height: 24),
                      ScrollRevealWidget(
                        delay: const Duration(milliseconds: 80),
                        offsetSlide: 30,
                        child: bioCard,
                      ),
                      const SizedBox(height: 24),
                      ScrollRevealWidget(
                        delay: const Duration(milliseconds: 140),
                        offsetSlide: 30,
                        child: IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(child: educationCard),
                              const SizedBox(width: 24),
                              Expanded(child: blogsCard),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ScrollRevealWidget(
                        delay: const Duration(milliseconds: 200),
                        offsetSlide: 30,
                        child: techStackCard,
                      ),
                    ],
                  )
                else
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 4,
                          child: ScrollRevealWidget(
                            delay: const Duration(milliseconds: 0),
                            offsetSlide: 30,
                            child: profileCard,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ScrollRevealWidget(
                                  delay: const Duration(milliseconds: 80),
                                  offsetSlide: 30,
                                  child: bioCard,
                                ),
                              ),
                              const SizedBox(height: 24),
                              IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: ScrollRevealWidget(
                                        delay: const Duration(milliseconds: 140),
                                        offsetSlide: 30,
                                        child: educationCard,
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      child: ScrollRevealWidget(
                                        delay: const Duration(milliseconds: 200),
                                        offsetSlide: 30,
                                        child: blogsCard,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 24),
                              ScrollRevealWidget(
                                delay: const Duration(milliseconds: 260),
                                offsetSlide: 30,
                                child: techStackCard,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionExperience(ColorScheme colorScheme, bool isMobile, double screenWidth) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      color: isDark ? const Color(0xFF000000) : Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 100,
        horizontal: isMobile ? 24 : 40,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              ScrollRevealWidget(
                delay: Duration.zero,
                offsetSlide: 25,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.experienceTitle,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context)!.experienceSubTitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  ScrollRevealWidget(
                    delay: const Duration(milliseconds: 0),
                    offsetSlide: 35,
                    child: ExperienceCard(
                      isDark: isDark,
                      isMobile: isMobile,
                      logo: Icons.local_parking_rounded,
                      role: l10n.expSoulParkingRole,
                      company: "Soul Parking",
                      period: l10n.expSoulParkingPeriod,
                      description: l10n.expSoulParkingDesc,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ScrollRevealWidget(
                    delay: const Duration(milliseconds: 140),
                    offsetSlide: 35,
                    child: ExperienceCard(
                      isDark: isDark,
                      isMobile: isMobile,
                      logo: Icons.code_rounded,
                      role: l10n.expGoodevaRole,
                      company: l10n.expGoodevaCompany,
                      period: l10n.expGoodevaPeriod,
                      description: l10n.expGoodevaDesc,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              ScrollRevealWidget(
                delay: const Duration(milliseconds: 200),
                offsetSlide: 20,
                child: GlobalButton(
                  title: AppLocalizations.of(context)!.viewFullExperienceBtn,
                  onPressed: () {
                    widget.onNavigate('/experience');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionProjectsContent(ColorScheme colorScheme, bool isMobile, double screenWidth) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            ScrollRevealWidget(
              delay: Duration.zero,
              offsetSlide: 25,
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.projectsTitle,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppLocalizations.of(context)!.projectsSubTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                List<ProjectUiModel> featured = [];
                if (state is HomeLoaded) {
                  featured = state.featuredProjects;
                }

                if (featured.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  alignment: WrapAlignment.center,
                  children: featured.asMap().entries.map((entry) {
                    final index = entry.key;
                    final project = entry.value;
                    return ScrollRevealWidget(
                      delay: Duration(milliseconds: index * 130),
                      offsetSlide: 40,
                      child: ProjectCard(
                        imagePath: project.imagePath,
                        title: project.title,
                        description: project.description,
                        techStacks: project.techStacks.map((tech) {
                          return TechChip(label: tech);
                        }).toList(),
                        category: project.category,
                        demoLinkText: "Case Study",
                        onTap: () {
                          widget.onNavigate(AppRoutes.projectDetailPath(project.slug));
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 60),
            ScrollRevealWidget(
              delay: const Duration(milliseconds: 200),
              offsetSlide: 20,
              child: GlobalButton(
                title: AppLocalizations.of(context)!.viewAllProjectsBtn,
                onPressed: () {
                  widget.onNavigate('/projects');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionGetInTouchContent(ColorScheme colorScheme, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 850),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.getInTouchTitle,
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.getInTouchSubTitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 60),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 24 : 48),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F172A) : Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.06),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField(
                    "Name",
                    "Your name",
                    isDark,
                    controller: _contactNameController,
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                    "Email",
                    "Your email",
                    isDark,
                    controller: _contactEmailController,
                  ),
                  const SizedBox(height: 24),
                  _buildInputField(
                    "Message",
                    "Your message",
                    isDark,
                    maxLines: 5,
                    controller: _contactMessageController,
                  ),
                  const SizedBox(height: 36),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _handleContactSend(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? Colors.white : const Color(0xFF0D1527),
                        foregroundColor: isDark ? Colors.black : Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.sendMessageBtn,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: isDark ? Colors.black : Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.send_rounded,
                            size: 16,
                            color: isDark ? Colors.black.withOpacity(0.8) : Colors.white.withOpacity(0.9),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleContactSend(BuildContext context) async {
    final name = _contactNameController.text.trim();
    final email = _contactEmailController.text.trim();
    final message = _contactMessageController.text.trim();

    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      CollaborationDialog.show(context);
      return;
    }

    final emailUri = Uri(
      scheme: 'mailto',
      path: 'rakaagus.m@gmail.com',
      queryParameters: {
        'subject': 'Collaboration Inquiry from $name ($email)',
        'body': 'Hi Raka,\n\n$message\n\nBest regards,\n$name\n$email',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
      _contactNameController.clear();
      _contactEmailController.clear();
      _contactMessageController.clear();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Opening your email client to send message..."),
            backgroundColor: Color(0xFF10B981),
          ),
        );
      }
    } else {
      if (context.mounted) {
        CollaborationDialog.show(context);
      }
    }
  }

  Widget _wrapThreeSectionContent(ColorScheme colorScheme, bool isMobile, double screenWidth) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          const Positioned.fill(
            child: MeshGradientBackground(style: 4),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 100,
                  horizontal: isMobile ? 24 : 40,
                ),
                child: _buildSectionProjectsContent(colorScheme, isMobile, screenWidth),
              ),
              ScrollRevealWidget(
                scrollController: widget.scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 60,
                    horizontal: isMobile ? 20 : 40,
                  ),
                  child: TestimonialContent(isMobile: isMobile),
                ),
              ),
              ScrollRevealWidget(
                scrollController: widget.scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 120,
                    horizontal: isMobile ? 20 : 40,
                  ),
                  child: _buildSectionGetInTouchContent(colorScheme, isMobile),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(
    String label,
    String hint,
    bool isDark, {
    int maxLines = 1,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black87,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white38 : Colors.black38,
            ),
            filled: true,
            fillColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.08),
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.08),
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isDark ? const Color(0xFF38BDF8) : const Color(0xFF0284C7),
                width: 1.6,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon({
    required IconData icon,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    final colorTheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: colorTheme.onSurface,
          shape: BoxShape.circle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: Icon(
              icon,
              color: isDark? DarkColorTheme.backgroundColor : LightColorTheme.backgroundColor,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}