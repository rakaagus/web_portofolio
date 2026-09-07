import 'package:flutter/material.dart';

class TechChip extends StatelessWidget {
  final String label;
  final Color? color;

  const TechChip({
    super.key,
    required this.label,
    this.color,
  });

  static Color getTechColor(String tech) {
    switch (tech.toLowerCase().trim()) {
      case 'flutter':
      case 'flutter web':
        return const Color(0xFF38BDF8); // Sky Blue
      case 'dart':
        return const Color(0xFF2DD4BF); // Teal
      case 'kotlin':
        return const Color(0xFFFB923C); // Orange
      case 'android sdk':
      case 'android':
        return const Color(0xFF4ADE80); // Green
      case 'jetpack compose':
      case 'compose':
        return const Color(0xFF818CF8); // Indigo
      case 'firebase':
        return const Color(0xFFFBBF24); // Amber
      case 'bloc':
      case 'flutter_bloc':
        return const Color(0xFFA78BFA); // Purple
      case 'drift sqlite':
      case 'drift':
      case 'sqlite':
      case 'room db':
        return const Color(0xFFF472B6); // Rose
      case 'nfc':
      case 'hardware interop':
        return const Color(0xFF34D399); // Emerald
      case 'rest api':
      case 'retrofit':
        return const Color(0xFF60A5FA); // Blue
      case 'clean architecture':
        return const Color(0xFF2DD4BF); // Cyan/Teal
      default:
        return const Color(0xFF94A3B8); // Slate
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? getTechColor(label);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: effectiveColor.withOpacity(isDark ? 0.12 : 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: effectiveColor.withOpacity(isDark ? 0.35 : 0.25),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: effectiveColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}