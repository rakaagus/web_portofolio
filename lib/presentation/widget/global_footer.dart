import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GlobalFooter extends StatelessWidget {
  const GlobalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;

    return Container(
      width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF000000) : Colors.white,
          border: Border(
            top: BorderSide(
              color: isDark
                  ? Colors.white.withOpacity(0.09)
                  : Colors.black.withOpacity(0.08),
              width: 2,
            ),
          ),
        ),
      padding: EdgeInsets.symmetric(
        vertical: 60,
        horizontal: isMobile ? 24 : screenWidth * 0.1,
      ),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: isMobile ? double.infinity : 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Portofolio",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "A showcase of my skills, projects, and professional journey as software engineer.",
                          style: TextStyle(
                            color: (isDark ? Colors.white : Colors.black).withOpacity(0.6),
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isMobile) const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Links", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      _footerLink("About", isDark),
                      _footerLink("Experience", isDark),
                      _footerLink("Projects", isDark),
                    ],
                  ),
                  if (isMobile) const SizedBox(height: 40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Connect", style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _socialIcon(FontAwesomeIcons.github, isDark),
                          const SizedBox(width: 20),
                          _socialIcon(FontAwesomeIcons.linkedin, isDark),
                          const SizedBox(width: 20),
                          _socialIcon(FontAwesomeIcons.envelope, isDark),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 60),
          const Divider(),
          const SizedBox(height: 20),
          Text(
            "© 2026 Raka Agus. All rights reserved.",
            style: TextStyle(
              fontSize: 12,
              color: (isDark ? Colors.white : Colors.black).withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        label,
        style: TextStyle(
          color: (isDark ? Colors.white : Colors.black).withOpacity(0.6),
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, bool isDark) {
    return Icon(
      icon,
      size: 20,
      color: (isDark ? Colors.white : Colors.black).withOpacity(0.7),
    );
  }
}