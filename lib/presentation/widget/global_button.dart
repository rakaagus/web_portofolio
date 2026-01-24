import 'package:flutter/material.dart';

class GlobalButton extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData icon;

  const GlobalButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon = Icons.arrow_forward,
  });

  @override
  State<GlobalButton> createState() => _GlobalButtonState();
}

class _GlobalButtonState extends State<GlobalButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.onSurface,
          foregroundColor: colorScheme.surface,
          padding: const EdgeInsets.symmetric(
              horizontal: 25, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(
            (isDark ? Colors.black : Colors.white).withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text( widget.title, style: TextStyle(fontWeight: FontWeight.bold)),
            AnimatedPadding(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              padding: EdgeInsets.only(left: _isHovered ? 16.0 : 8.0),
              child: Icon(widget.icon, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
