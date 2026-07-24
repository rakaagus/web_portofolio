import 'package:flutter/material.dart';

class PremiumPageTransitionOverlay extends StatefulWidget {
  final bool isLoading;
  final Color? color;

  const PremiumPageTransitionOverlay({
    super.key,
    required this.isLoading,
    this.color,
  });

  @override
  State<PremiumPageTransitionOverlay> createState() => _PremiumPageTransitionOverlayState();
}

class _PremiumPageTransitionOverlayState extends State<PremiumPageTransitionOverlay>
    with TickerProviderStateMixin {

  late AnimationController _slideInController;
  late AnimationController _slideOutController;
  bool _isOverlayActive = false;

  @override
  void initState() {
    super.initState();

    _slideInController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideInController.addListener(() => setState(() {}));
    _slideOutController.addListener(() => setState(() {}));

    _slideOutController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isOverlayActive = false;
        });
      }
    });

    if (widget.isLoading) {
      _isOverlayActive = true;
      _slideInController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(PremiumPageTransitionOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Deteksi perubahan state isLoading dari widget induk
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        // Mulai Fase Masuk
        setState(() {
          _isOverlayActive = true;
        });
        _slideOutController.reset();
        _slideInController.forward(from: 0.0);
      } else {
        // Mulai Fase Keluar
        _slideInController.reset();
        _slideOutController.forward(from: 0.0);
      }
    }
  }

  @override
  void dispose() {
    _slideInController.dispose();
    _slideOutController.dispose();
    super.dispose();
  }

  // Helper matematika interval progress
  double _getIntervalProgress(double globalProgress, double start, double end,
      {Curve curve = Curves.linear}) {
    if (globalProgress < start) return 0.0;
    if (globalProgress > end) return 1.0;
    return curve.transform(((globalProgress - start) / (end - start)).clamp(0.0, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    // Jika tidak sedang transisi, kembalikan widget kosong (menghemat memori)
    if (!_isOverlayActive) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;

    // Menentukan warna balok transisi
    final blockColor = widget.color ??
        (isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC));

    const int totalBlocks = 3;
    final double pIn = _slideInController.value;
    final double pOut = _slideOutController.value;

    final List<double> blockOffsets = [];
    for (int i = 0; i < totalBlocks; i++) {
      double slideOffset = 0.0;

      if (widget.isLoading) {
        final double bp = _getIntervalProgress(
          pIn,
          i * 0.12,
          (i * 0.12) + 0.60,
          curve: Curves.easeInOutQuint,
        );
        slideOffset = -(1.0 - bp) * width;
      } else {
        final double ep = _getIntervalProgress(
          pOut,
          i * 0.12,
          (i * 0.12) + 0.60,
          curve: Curves.easeInOutQuint,
        );
        slideOffset = ep * width;
      }
      blockOffsets.add(slideOffset);
    }

    final double individualHeight = screenSize.height / totalBlocks;

    return AbsorbPointer(
      absorbing: true,
      child: Stack(
        children: List.generate(totalBlocks, (index) {
          return Positioned(
            top: (index * individualHeight) - (index > 0 ? 1 : 0),
            left: 0,
            right: 0,
            height: individualHeight + 2,
            child: Transform.translate(
              offset: Offset(blockOffsets[index], 0),
              child: Container(
                width: double.infinity,
                color: blockColor,
              ),
            ),
          );
        }),
      ),
    );
  }
}