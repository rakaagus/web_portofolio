import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/bloc/home/widget/experience_card.dart';
import 'package:web_portofolio/presentation/widget/tech_chip.dart';

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
        _buildSectionExperience(colorScheme, isMobile, screenWidth)
      ],
    );
  }

  Widget _buildMeshGradient(ColorScheme colorScheme) {
    return Stack(
      children: [
        Positioned(
          top: 100,
          left: -50,
          child: _buildBlob(colorScheme.primary.withOpacity(0.15), 400),
        ),
        Positioned(
          bottom: 100,
          right: -50,
          child: _buildBlob(Colors.orange.withOpacity(0.1), 350),
        ),
        // Filter Blur Global
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }

  Widget _buildBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildHeroSection(ColorScheme colorScheme, bool isMobile) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildMeshGradient(colorScheme),
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
                const SizedBox(height: 24),
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
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.onSurface,
                    foregroundColor: colorScheme.surface,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("View my work", style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
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
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: 160,
          horizontal: isMobile ? 24 : screenWidth * 0.1
      ),
      color: colorScheme.surface,
      child: Column(
        children: [
          Text(
            "About Me",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Get to know a bit about my background and skills",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 50,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 24 : 60),
              child: Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: isMobile ? 0 : 1,
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage('assets/profile_illustration.png'),
                          fit: BoxFit.contain,
                        ),
                        border: Border.all(
                          color: colorScheme.primary.withOpacity(0.1),
                          width: 8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    flex: isMobile ? 0 : 2,
                    child: Column(
                      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Software Engineer based in Indonesia",
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: isMobile ? TextAlign.center : TextAlign.start,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Experienced Software Engineer with expertise in designing and building applications used by thousands of users. My primary focus has been on delivering high-performance, user-friendly solutions.",
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            color: colorScheme.onSurface.withOpacity(0.7),
                          ),
                          textAlign: isMobile ? TextAlign.center : TextAlign.start,
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Android Tech Stack",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                          children: [
                            TechChip(label: "Kotlin", color: Colors.orange.shade700),
                            TechChip(label: "Android", color: Colors.green.shade600),
                            TechChip(label: "MVVM", color: Colors.blueGrey),
                            TechChip(label: "Room", color: Colors.teal),
                            TechChip(label: "RxJava", color: Colors.deepPurpleAccent),
                            TechChip(label: "Hilt", color: Colors.blueAccent),
                            TechChip(label: "OkHttp", color: Colors.indigo),
                            TechChip(label: "Retrofit", color: Colors.cyan),
                            TechChip(label: "Mockito", color: Colors.redAccent),
                            TechChip(label: "Espresso", color: Colors.brown),
                          ],
                        ),
                        const SizedBox(height: 30),
                        Text(
                          "Flutter Tech Stack",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                          children: [
                            TechChip(label: "Dart", color: Colors.cyan.shade600),
                            TechChip(label: "Flutter", color: Colors.blue.shade400),
                            TechChip(label: "Cupertino", color: Colors.grey.shade700),
                            TechChip(label: "Floor", color: Colors.teal.shade400),
                            TechChip(label: "Bloc", color: Colors.indigo.shade400),
                            TechChip(label: "GetX", color: Colors.purple.shade400),
                          ],
                        )
                      ],
                    ),
                  ),
                  if (!isMobile) const SizedBox(width: 80),
                  if (isMobile) const SizedBox(height: 40),
                ],
              ),
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

              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.onSurface,
                  foregroundColor: colorScheme.surface,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("View full experience", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}