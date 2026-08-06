import 'dart:ui';
import 'package:flutter/material.dart';

class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius borderRadius;
  final double blur;
  final AlignmentGeometry gradientBegin;
  final AlignmentGeometry gradientEnd;
  final double shadowBlurRadius;
  final Offset shadowOffset;
  final Duration duration;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = const BorderRadius.all(Radius.circular(30)),
    this.blur = 20,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.shadowBlurRadius = 30,
    this.shadowOffset = const Offset(0, 10),
    this.duration = const Duration(milliseconds: 400), // Default durasi animasi smooth
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return RepaintBoundary(
      child: AnimatedContainer(
        duration: duration,
        curve: Curves.fastOutSlowIn,
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: Colors.white.withOpacity(isDark ? 0.12 : 0.4),
            width: 1.2,
          ),
          gradient: LinearGradient(
            begin: gradientBegin,
            end: gradientEnd,
            colors: [
              Colors.white.withOpacity(isDark ? 0.08 : 0.25),
              Colors.white.withOpacity(isDark ? 0.02 : 0.1),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.35 : 0.1),
              blurRadius: shadowBlurRadius,
              offset: shadowOffset,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur.clamp(0, 12), sigmaY: blur.clamp(0, 12)),
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}