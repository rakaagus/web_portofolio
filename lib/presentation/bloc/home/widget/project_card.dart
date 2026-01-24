import 'dart:ui';
import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;
  final List<Widget> techStacks;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.techStacks,
    this.onTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;

    final double horizontalPadding = isMobile ? 48.0 : 80.0;
    final double safeWidth = screenWidth - horizontalPadding;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
        width: isMobile ? safeWidth : 380,
        margin: const EdgeInsets.only(bottom: 20),
        transform: Matrix4.translationValues(0, _isHovered ? -12 : 0, 0),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF111111) : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: _isHovered
                ? (isDark ? Colors.white.withOpacity(0.2) : Colors.black.withOpacity(0.1))
                : (isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05)),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_isHovered ? 0.12 : 0.05),
              blurRadius: _isHovered ? 40 : 30,
              offset: Offset(0, _isHovered ? 25 : 15),
            ),
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: isMobile ? 0 : 620,
          ),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: Container(
                          color: isDark ? Colors.white.withOpacity(0.02) : Colors.black.withOpacity(0.02),
                          child: Image.asset(
                            widget.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, e, s) => const Icon(Icons.code, size: 40, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.description,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.6,
                              color: (isDark ? Colors.white : Colors.black).withOpacity(0.6),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: widget.techStacks,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Row(
                    children: [
                      Text("View project",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white70 : Colors.black87
                          )
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}