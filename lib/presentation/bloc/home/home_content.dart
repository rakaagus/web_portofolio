import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web_portofolio/presentation/bloc/home/widget/experience_card.dart';
import 'package:web_portofolio/presentation/bloc/home/widget/hovered_card_widget.dart' show HoverGlassCard, HoverSolidCard;
import 'package:web_portofolio/presentation/bloc/home/widget/project_card.dart';
import 'package:web_portofolio/presentation/widget/global_button.dart';
import 'package:web_portofolio/presentation/widget/global_footer.dart';
import 'package:web_portofolio/presentation/widget/gradient_background.dart';
import 'package:web_portofolio/presentation/widget/tech_chip.dart';
import 'package:web_portofolio/presentation/bloc/home/widget/tech_stak_widget.dart';

import 'widget/testimonial_section_widget.dart';

class HomeContent extends StatefulWidget {
  final ScrollController scrollController;
  const HomeContent({super.key, required this.scrollController});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> with SingleTickerProviderStateMixin {
  late AnimationController _arrowController;
  late Animation<double> _arrowAnimation;

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
    super.dispose();
  }

  void _scrollToContent() {
    widget.scrollController.animateTo(
      MediaQuery.of(context).size.height,
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
    );
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
        const GlobalFooter()
      ],
    );
  }

  Widget _buildHeroSection(ColorScheme colorScheme, bool isMobile) {
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
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.black, Color(0xFF5EEAD4)],
                      ).createShader(Offset.zero & bounds.size),
                      child: Text(
                        "Hello, I'm ",
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF5EEAD4), Color(0xFFFB923C)],
                          tileMode: TileMode.clamp
                      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                      child: Text(
                        "Raka Agus",
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 56,
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
                    "A passionate software engineer specializing in creating user-friendly mobile and desktop solutions that meet both user needs and business objectives.",
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
                      onPressed: () {
                        // Aksi buka GitHub
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildSocialIcon(
                      icon: FontAwesomeIcons.linkedin,
                      tooltip: "LinkedIn",
                      onPressed: () {
                        // Aksi buka LinkedIn
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildSocialIcon(
                      icon: Icons.email_rounded,
                      tooltip: "Email",
                      onPressed: () {
                        // Aksi buka Email
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                GlobalButton(title: "View my work", onPressed: () {}),
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
                      color: colorScheme.onSurface.withOpacity(0.5),
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
    final profileCard = HoverSolidCard(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 320,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              image: const DecorationImage(
                image: AssetImage('assets/profile_illustration.png'),
                fit: BoxFit.contain,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                )
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            "Raka Agus",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "MOBILE & FULLSTACK DEV",
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          GlobalButton(title: "Download Resume", onPressed: () {}),
        ],
      ),
    );

    final bioCard = HoverSolidCard(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "WELCOME",
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Experienced Software Engineer with expertise in designing and building applications used by thousands of users. My primary focus has been on delivering high-performance, user-friendly solutions.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.8,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "My technical expertise includes Kotlin, Android, MVVM for mobile engineering, and Flutter, Dart, Bloc for cross-platform development.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.8,
              color: colorScheme.onSurface,
            ),
          ),
        ],
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
              horizontal: isMobile ? 24 : screenWidth * 0.1,
            ),
            child: Column(
              children: [
                Text(
                  "About Me",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Get to know a bit about my background and skills",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 60),
                if (isMobile)
                  Column(
                    children: [
                      profileCard,
                      const SizedBox(height: 24),
                      bioCard,
                      const SizedBox(height: 24),
                      techStackCard,
                    ],
                  )
                else
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 4,
                          child: profileCard,
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: bioCard,
                              ),
                              const SizedBox(height: 24),
                              techStackCard,
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
              // Header Section
              Text(
                "Experience",
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "A glimpse into my professional journey",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 60),
              Column(
                children: [
                  ExperienceCard(
                    isDark: isDark,
                    isMobile: isMobile,
                    logo: Icons.local_parking_rounded,
                    role: "Software Engineer (Mobile Specialist)",
                    company: "Soul Parking",
                    period: "Februari 2025 - Present",
                    description: "Developing and maintaining smart parking solutions using Flutter and Android. Implementing NFC payment systems and optimizing mobile app performance for thousands of daily users.",
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 24),
                  ExperienceCard(
                    isDark: isDark,
                    isMobile: isMobile,
                    logo: Icons.code_rounded,
                    role: "Junior Mobile Developer",
                    company: "Previous Company",
                    period: "2023 - 2025",
                    description: "Collaborated with cross-functional teams to build robust mobile applications. Focused on clean code architecture and responsive UI design using Kotlin and Dart.",
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 50),
              GlobalButton(title: "View full experience", onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }

// 1. KONTEN PROJECTS
  Widget _buildSectionProjectsContent(ColorScheme colorScheme, bool isMobile, double screenWidth) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            Text(
              "Projects",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Check out some of my recent work",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 60),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: [
                ProjectCard(
                  imagePath: 'assets/project_parking.png',
                  title: "Smart Parking System",
                  description: "A comprehensive parking solution with NFC integration, real-time monitoring, and seamless mobile payments.",
                  techStacks: [
                    TechChip(label: "Flutter", color: Colors.blue),
                    TechChip(label: "Kotlin", color: Colors.orange),
                    TechChip(label: "NFC", color: Colors.teal),
                    TechChip(label: "Firebase", color: Colors.amber),
                  ],
                ),
                ProjectCard(
                  imagePath: 'assets/project_booking.png',
                  title: "Wedding Reservation Platform",
                  description: "Modular wedding invitation and attendance reservation system built for high scalability and customization.",
                  techStacks: [
                    TechChip(label: "Flutter Web", color: Colors.cyan),
                    TechChip(label: "Dart", color: Colors.blue),
                    TechChip(label: "GetX", color: Colors.purple),
                  ],
                ),
                ProjectCard(
                  imagePath: 'assets/project_pos.png',
                  title: "Smart POS Handheld",
                  description: "Android-based Point of Sale system optimized for handheld devices with thermal printer and e-money support.",
                  techStacks: [
                    TechChip(label: "Android SDK", color: Colors.green),
                    TechChip(label: "Kotlin", color: Colors.orange),
                    TechChip(label: "Room DB", color: Colors.blueGrey),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 60),
            GlobalButton(title: "View all projects", onPressed: () {})
          ],
        ),
      ),
    );
  }

// 2. KONTEN GET IN TOUCH
  Widget _buildSectionGetInTouchContent(ColorScheme colorScheme, bool isMobile) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 850),
        child: Column(
          children: [
            Text(
              "Get in Touch",
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Have a project in mind? Let's work together.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 60),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 24 : 48),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF111111) : Colors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField("Name", "Your name", isDark),
                  const SizedBox(height: 28),
                  _buildInputField("Email", "Your email", isDark),
                  const SizedBox(height: 28),
                  _buildInputField("Message", "Your message", isDark, maxLines: 5),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
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
                            "Send Message",
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
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 60,
                  horizontal: isMobile ? 20 : 40,
                ),
                child: TestimonialContent(isMobile: isMobile),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 120,
                  horizontal: isMobile ? 20 : 40,
                ),
                child: _buildSectionGetInTouchContent(colorScheme, isMobile),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(String label, String hint, bool isDark, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: isDark ? const Color(0xFF111111) : const Color(0xFFF1F5F9),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(18),
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
              color: Colors.white,
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}