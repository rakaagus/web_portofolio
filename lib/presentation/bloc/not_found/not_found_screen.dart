import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/widget/global_button.dart';
import 'package:web_portofolio/presentation/widget/gradient_background.dart';


class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const MeshGradientBackground(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF5EEAD4), Color(0xFFFB923C)],
                      tileMode: TileMode.clamp,
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    child: Text(
                      "404",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: isMobile ? 120 : 160,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Oops! Page Not Found",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 24 : 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      "Sepertinya kamu tersesat atau mengetik URL yang salah nih. Halaman yang kamu cari tidak ada di dalam radar.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.7),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  GlobalButton(title: "Back to Home", onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}