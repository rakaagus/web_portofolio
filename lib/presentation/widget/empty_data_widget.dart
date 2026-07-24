import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/widget/global_button.dart';

class EmptyDataCardWidget extends StatelessWidget {
  final IconData buttonIcon;
  final bool isHaveButton;
  final String title;
  final String iconTitle;
  final String description;
  final VoidCallback onPressButton;

  const EmptyDataCardWidget({
    super.key,
    required this.title,
    required this.isHaveButton,
    required this.iconTitle,
    required this.description,
    required this.onPressButton,
    this.buttonIcon = Icons.arrow_forward,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isMobile = screenWidth < 650;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 50,
        horizontal: isMobile ? 20 : 40,
      ),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.03) : Colors.black.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 13 : 15,
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 28),
          if(isHaveButton) GlobalButton(title: iconTitle, onPressed: onPressButton, icon: buttonIcon),
        ],
      ),
    );
  }
}
