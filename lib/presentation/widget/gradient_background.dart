import 'dart:ui';
import 'package:flutter/material.dart';

class MeshGradientBackground extends StatelessWidget {
  const MeshGradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      children: [
        Positioned(
          top: 100,
          left: -50,
          child: _buildBlob(colorScheme.primary.withOpacity(0.15), 400),
        ),
        Positioned(
          bottom: 100,
          right: -50,
          child: _buildBlob(Colors.orange.withOpacity(0.1), 350),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }

  Widget _buildBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}