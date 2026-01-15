import 'dart:ui';
import 'package:flutter/material.dart';

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
      MediaQuery.of(context).size.height - 40,
      duration: const Duration(milliseconds: 800),
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
        Container(
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
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Color(0xFF5EEAD4), Color(0xFFFB923C)],
                          ).createShader(Offset.zero & bounds.size),
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
        ),

        Container(
          height: 1000,
          color: colorScheme.surface,
          child: const Center(child: Text("Content Selanjutnya di sini...")),
        ),
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
}