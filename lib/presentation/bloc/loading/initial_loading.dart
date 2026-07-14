import 'package:flutter/material.dart';

class PremiumLoadingWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback onComplete;

  const PremiumLoadingWrapper({
    super.key,
    required this.child,
    required this.onComplete,
  });

  @override
  State<PremiumLoadingWrapper> createState() => _PremiumLoadingWrapperState();
}

class _PremiumLoadingWrapperState extends State<PremiumLoadingWrapper> with TickerProviderStateMixin {
  late AnimationController _loadingController;
  late AnimationController _revealController;
  bool _showChild = false;

  @override
  void initState() {
    super.initState();
    _loadingController = AnimationController(vsync: this, duration: const Duration(milliseconds: 4000));
    _revealController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    _loadingController.addListener(() => setState(() {}));
    _revealController.addListener(() => setState(() {}));

    _loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _showChild = true);
        _revealController.forward();
      }
    });

    _revealController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete(); // Picu induk untuk mematikan _isInitialLoading
      }
    });

    _loadingController.forward();
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _revealController.dispose();
    super.dispose();
  }

  double _getIntervalProgress(double globalProgress, double start, double end, {Curve curve = Curves.linear}) {
    if (globalProgress < start) return 0.0;
    if (globalProgress > end) return 1.0;
    return curve.transform(((globalProgress - start) / (end - start)).clamp(0.0, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;

    final initialBgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFF1E293B);
    final finalBgColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
    final brightCyan = const Color(0xFF22D3EE);

    final double p = _loadingController.value;
    final double revP = _revealController.value;

    // Timeline configuration
    final double gradientFadeInStart = 0.10;
    final double gradientFadeInEnd = 0.40;
    final double gradientFadeOutStart = 0.55;
    final double gradientFadeOutEnd = 0.70;
    final double textChangeStart = 0.0;
    final double textChangeEnd = 0.50;
    final double textFadeStart = 0.45;
    final double textFadeEnd = 0.65;
    final double blocksStart = 0.55;
    const int totalBlocks = 3;
    final double blockDuration = 0.25;
    final double blockStagger = 0.08;

    final List<String> loadingPhrases = ["Connecting...", "Analyzing...", "Optimizing...", "Ready..."];
    int phraseIndex = (_getIntervalProgress(p, textChangeStart, textChangeEnd) * loadingPhrases.length).toInt().clamp(0, loadingPhrases.length - 1);

    final double textOpacity = 1.0 - _getIntervalProgress(p, textFadeStart, textFadeEnd, curve: Curves.easeIn);
    final double textYOffset = -_getIntervalProgress(p, textFadeStart, textFadeEnd, curve: Curves.easeIn) * 40;
    final double gradientOpacity = p <= gradientFadeOutStart
        ? _getIntervalProgress(p, gradientFadeInStart, gradientFadeInEnd)
        : 1.0 - _getIntervalProgress(p, gradientFadeOutStart, gradientFadeOutEnd);

    final List<double> blockOffsets = [];
    for (int i = 0; i < totalBlocks; i++) {
      if (!_showChild) {
        final double bp = _getIntervalProgress(p, blocksStart + (i * blockStagger), blocksStart + (i * blockStagger) + blockDuration, curve: Curves.easeInOutQuint);
        blockOffsets.add(-(1.0 - bp) * width);
      } else {
        final double ep = _getIntervalProgress(revP, i * 0.08, (i * 0.08) + 0.45, curve: Curves.easeInOutQuint);
        blockOffsets.add(ep * width);
      }
    }

    // Menggunakan Stack murni agar bisa ditaruh di dalam Positioned.fill parent
    return Stack(
      children: [
        if (_showChild) widget.child,
        if (!_showChild) ...[
          Container(color: initialBgColor),
          Positioned(
            left: 0, right: 0, bottom: 0, height: screenSize.height * 0.6,
            child: Opacity(
              opacity: gradientOpacity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter, end: Alignment.topCenter,
                    colors: [brightCyan.withOpacity(0.35), brightCyan.withOpacity(0.05), Colors.transparent],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Opacity(
              opacity: textOpacity,
              child: Transform.translate(
                offset: Offset(0, textYOffset),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ColorFiltered(
                      colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      child: FlutterLogo(size: 75),
                    ),
                    const SizedBox(height: 28),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 450),
                      child: Text(
                        loadingPhrases[phraseIndex],
                        key: ValueKey<String>(loadingPhrases[phraseIndex]),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white70, letterSpacing: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        Positioned.fill(
          child: Column(
            children: List.generate(totalBlocks, (index) {
              return Expanded(
                child: Transform.translate(
                  offset: Offset(blockOffsets[index], 0),
                  child: Container(width: double.infinity, color: finalBgColor),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}