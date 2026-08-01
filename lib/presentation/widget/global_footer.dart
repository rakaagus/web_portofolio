import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GlobalFooter extends StatelessWidget {
  final Function(String url) onNavigate;
  const GlobalFooter({
    super.key,
    required this.onNavigate
  });

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
                          AppLocalizations.of(context)!.footerPortfolioDescription,
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
                      _FooterLink(label: "Experience", isDark: isDark, onTap: () => onNavigate('/experience')),
                      _FooterLink(label: "Projects", isDark: isDark, onTap: () => onNavigate('/projects')),
                      _FooterLink(label: "Blogs", isDark: isDark, onTap: () => onNavigate('/blogs')),
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
                          _SocialIconButton(
                            icon: FontAwesomeIcons.github,
                            onTap: () => _launchURL("https://github.com/rakaagus"),
                          ),
                          const SizedBox(width: 8),
                          _SocialIconButton(
                            icon: FontAwesomeIcons.linkedin,
                            onTap: () => _launchURL("https://www.linkedin.com/in/raka-agus-maulana/"),
                          ),
                          const SizedBox(width: 8),
                          _SocialIconButton(
                            icon: FontAwesomeIcons.instagram,
                            onTap: () => _launchURL("https://www.instagram.com/rakaagus.m/"),
                          ),
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
            AppLocalizations.of(context)!.footerCopyright,
            style: TextStyle(
              fontSize: 12,
              color: (isDark ? Colors.white : Colors.black).withOpacity(0.4),
            ),
          ),
          if (isMobile) const SizedBox(height: 60),
        ],
      ),
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
}

class _FooterLink extends StatefulWidget {
  final String label;
  final bool isDark;
  final VoidCallback? onTap;

  const _FooterLink({
    required this.label,
    required this.isDark,
    this.onTap,
  });

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color textColor;
    FontWeight fontWeight = FontWeight.normal;

    if (widget.isDark) {
      textColor = _isHovered ? Colors.white : Colors.white.withOpacity(0.6);
    } else {
      textColor = _isHovered ? Colors.black : Colors.black.withOpacity(0.6);
      if (_isHovered) {
        fontWeight = FontWeight.bold;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: textColor,
              fontWeight: fontWeight,
              fontSize: 14,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _SocialIconButton({
    required this.icon,
    this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;

    final Color containerBg = _isHovered
        ? colorScheme.onSurface
        : Colors.transparent;
    final Color iconColor = _isHovered
        ? (isDark ? Colors.black : Colors.white)
        : (isDark ? Colors.white.withOpacity(0.7) : Colors.black.withOpacity(0.7));

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: containerBg,
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.icon,
            size: 18,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}