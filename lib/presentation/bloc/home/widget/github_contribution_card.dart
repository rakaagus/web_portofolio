import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubContributionCard extends StatelessWidget {
  final String githubUsername;
  final bool isDark;

  const GithubContributionCard({
    super.key,
    required this.githubUsername,
    required this.isDark,
  });

  Future<void> _launchGithubUrl() async {
    final Uri url = Uri.parse('https://github.com/$githubUsername');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark
            ? colorScheme.surface.withOpacity(0.4)
            : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- HEADER CARD ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.code_rounded, // Atau ikon GitHub jika ada
                    color: colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "GitHub Activity",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: _launchGithubUrl,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      Text(
                        "@$githubUsername",
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.open_in_new_rounded,
                        size: 14,
                        color: colorScheme.primary,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // --- GRAFIK KONTRIBUSI (SVG) ---
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Memastikan tidak overflow di layar HP kecil
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SvgPicture.network(
                  // Ubah '40c463' dengan warna hex aksen yang kamu mau
                  'https://ghchart.rshah.org/40c463/$githubUsername',
                  placeholderBuilder: (BuildContext context) => Container(
                    padding: const EdgeInsets.all(30),
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                  height: 110, // Ukuran ideal grafik
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // --- SUBTITLE ---
          Text(
            "Contributions in the last year",
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}