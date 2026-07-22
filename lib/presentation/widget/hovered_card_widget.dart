import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/widget/liquid_glass_widget.dart';

class HoverGlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const HoverGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
  });

  @override
  State<HoverGlassCard> createState() => _HoverGlassCardState();
}

class _HoverGlassCardState extends State<HoverGlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
        child: LiquidGlassContainer(
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          shadowBlurRadius: _isHovered ? 45 : 30,
          shadowOffset: _isHovered ? const Offset(0, 20) : const Offset(0, 10),
          child: widget.child,
        ),
      ),
    );
  }
}

class HoverSolidCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  const HoverSolidCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
  });

  @override
  State<HoverSolidCard> createState() => _HoverSolidCardState();
}

class _HoverSolidCardState extends State<HoverSolidCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
        width: widget.width,
        height: widget.height,
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}