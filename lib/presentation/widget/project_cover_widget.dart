import 'package:flutter/material.dart';

class ProjectCoverWidget extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String category;
  final List<String> techStacks;
  final double? height;
  final bool isHero;

  const ProjectCoverWidget({
    super.key,
    this.imagePath,
    required this.title,
    required this.category,
    this.techStacks = const [],
    this.height,
    this.isHero = false,
  });

  bool get _hasCustomImage {
    if (imagePath == null || imagePath!.isEmpty) return false;
    if (imagePath!.contains('profile_image.jpeg')) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_hasCustomImage) {
      final isNetwork = imagePath!.startsWith('http://') || imagePath!.startsWith('https://');
      return Container(
        height: height,
        width: double.infinity,
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1E293B)
            : const Color(0xFFF1F5F9),
        child: isNetwork
            ? Image.network(
                imagePath!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildBrandedBanner(context),
              )
            : Image.asset(
                imagePath!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildBrandedBanner(context),
              ),
      );
    }

    return _buildBrandedBanner(context);
  }

  Widget _buildBrandedBanner(BuildContext context) {
    final lowerTitle = title.toLowerCase();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Distinct theme per project
    List<Color> gradientColors;
    IconData primaryIcon;
    IconData badgeIcon;
    String badgeText;
    Color accentColor;

    if (lowerTitle.contains('parking')) {
      gradientColors = isDark
          ? [const Color(0xFF0F172A), const Color(0xFF1E293B), const Color(0xFF0E7490)]
          : [const Color(0xFF0F172A), const Color(0xFF1E3A5F), const Color(0xFF38BDF8)];
      primaryIcon = Icons.local_parking_rounded;
      badgeIcon = Icons.nfc_rounded;
      badgeText = "NFC & IOT SOLUTION";
      accentColor = const Color(0xFF38BDF8);
    } else if (lowerTitle.contains('wedding')) {
      gradientColors = isDark
          ? [const Color(0xFF1E1B4B), const Color(0xFF4A044E), const Color(0xFF701A75)]
          : [const Color(0xFF2E1065), const Color(0xFF581C87), const Color(0xFFA855F7)];
      primaryIcon = Icons.web_rounded;
      badgeIcon = Icons.favorite_rounded;
      badgeText = "WEB PLATFORM";
      accentColor = const Color(0xFFE879F9);
    } else if (lowerTitle.contains('pos')) {
      gradientColors = isDark
          ? [const Color(0xFF064E3B), const Color(0xFF065F46), const Color(0xFF0F172A)]
          : [const Color(0xFF047857), const Color(0xFF059669), const Color(0xFF10B981)];
      primaryIcon = Icons.point_of_sale_rounded;
      badgeIcon = Icons.print_rounded;
      badgeText = "SMART HARDWARE & POS";
      accentColor = const Color(0xFF34D399);
    } else {
      gradientColors = isDark
          ? [const Color(0xFF1E293B), const Color(0xFF0F172A)]
          : [const Color(0xFF334155), const Color(0xFF1E293B)];
      primaryIcon = category.toLowerCase() == 'web' ? Icons.laptop_chromebook_rounded : Icons.phone_android_rounded;
      badgeIcon = Icons.code_rounded;
      badgeText = category.toUpperCase();
      accentColor = const Color(0xFF60A5FA);
    }

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background subtle glowing orb
          Positioned(
            right: -30,
            bottom: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accentColor.withOpacity(0.15),
              ),
            ),
          ),

          // Center Showcase Device Frame
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(isHero ? 24 : 16),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.08),
                  border: Border.all(
                    color: accentColor.withOpacity(0.4),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accentColor.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Icon(
                  primaryIcon,
                  size: isHero ? 48 : 36,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 14),

              // Floating Platform Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(badgeIcon, size: 12, color: accentColor),
                    const SizedBox(width: 6),
                    Text(
                      badgeText,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
