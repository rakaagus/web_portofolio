import 'dart:ui';
import 'package:flutter/material.dart';

import 'dart:ui';
import 'package:flutter/material.dart';

class MeshGradientBackground extends StatelessWidget {
  final int style;

  const MeshGradientBackground({
    super.key,
    this.style = 1,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ClipRect(
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          ..._buildBlobsByStyle(style, colorScheme),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
              child: Container(color: Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBlobsByStyle(int style, ColorScheme colorScheme) {
    switch (style) {
      case 5:
        return [
          Positioned(
            top: 100,
            left: -150,
            child: _buildBlob(colorScheme.tertiary.withOpacity(0.12), 650),
          ),
          Positioned(
            top: 700,
            right: -150,
            child: _buildBlob(colorScheme.primary.withOpacity(0.08), 550),
          ),
          Positioned(
            bottom: 150,
            left: -150,
            child: _buildBlob(Colors.amber.withOpacity(0.08), 600),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: _buildBlob(Colors.pink.withOpacity(0.04), 450),
          ),
        ];
      case 2:
        return [
          Positioned(
            top: -100,
            right: -100,
            child: _buildBlob(colorScheme.secondary.withOpacity(0.12), 500),
          ),
          Positioned(
            top: 400,
            left: -150,
            child: _buildBlob(colorScheme.primary.withOpacity(0.1), 450),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: _buildBlob(Colors.deepPurple.withOpacity(0.12), 400),
          ),
        ];

      case 3:
        return [
          Positioned(
            top: 200,
            left: 100,
            child: _buildBlob(colorScheme.tertiary.withOpacity(0.15), 550),
          ),
          Positioned(
            bottom: 200,
            right: 100,
            child: _buildBlob(colorScheme.primary.withOpacity(0.12), 450),
          ),
        ];

      case 4:
        return [
          Positioned(
            top: -150,
            left: -50,
            child: _buildBlob(Colors.pink.withOpacity(0.06), 600),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: _buildBlob(Colors.amber.withOpacity(0.1), 450),
          ),
          Positioned(
            bottom: -50,
            right: -100,
            child: _buildBlob(colorScheme.primary.withOpacity(0.08), 500),
          ),
        ];

      case 1:
      default:
        return [
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
        ];
    }
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