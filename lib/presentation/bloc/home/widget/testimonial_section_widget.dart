import 'dart:ui';
import 'package:flutter/material.dart';

class Testimonial {
  final String name;
  final String role;
  final String quote;
  final String initials;
  final Color color;

  Testimonial({
    required this.name,
    required this.role,
    required this.quote,
    required this.initials,
    required this.color,
  });
}

class TestimonialContent extends StatefulWidget {
  final bool isMobile;

  const TestimonialContent({super.key, required this.isMobile});

  @override
  State<TestimonialContent> createState() => _TestimonialContentState();
}

class _TestimonialContentState extends State<TestimonialContent> {
  late PageController _pageController;
  late int _currentIndex;

  final List<Testimonial> _testimonials = [
    Testimonial(
      name: "John Doe",
      role: "PRODUCT MANAGER, TECHCORP",
      quote: "Raka is an exceptional developer who consistently delivers high-quality code. His expertise in Flutter helped us launch our MVP ahead of schedule.",
      initials: "JD",
      color: Colors.blue.shade100,
    ),
    Testimonial(
      name: "Alice Smith",
      role: "LEAD DESIGNER, CREATIVE STUDIO",
      quote: "The attention to detail in the UI/UX of our mobile app was outstanding. Raka's ability to bridge the gap between design and engineering is rare.",
      initials: "AS",
      color: Colors.cyan.shade100,
    ),
    Testimonial(
      name: "Michael Kim",
      role: "CTO, SOUL PARKING",
      quote: "A reliable and proactive engineer. He didn't just build what was asked; he suggested improvements that significantly enhanced our system's performance.",
      initials: "MK",
      color: Colors.grey.shade300,
    ),
    Testimonial(
      name: "Sarah Lee",
      role: "FOUNDER, STARTUP INC",
      quote: "Working with this team was a game-changer. They understand both business needs and technical constraints perfectly.",
      initials: "SL",
      color: Colors.purple.shade100,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = (_testimonials.length * 1000) + 1;

    // Inisialisasi awal PageController sesuai ukuran layar pertama kali dimuat
    _pageController = PageController(
      initialPage: _currentIndex,
      viewportFraction: widget.isMobile ? 1.0 : 0.38, // 1.0 di HP agar hanya tampil 1 card
    );
  }

  // SOLUSI BUG: Memastikan PageController di-update secara dinamis saat ukuran layar berubah
  @override
  void didUpdateWidget(covariant TestimonialContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isMobile != widget.isMobile) {
      _pageController.dispose();
      _pageController = PageController(
        initialPage: _currentIndex,
        viewportFraction: widget.isMobile ? 1.0 : 0.38,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _prevPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final containerBg = isDark ? const Color(0xFF111111) : Colors.white;

    return Center(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(maxWidth: 1440),
        padding: EdgeInsets.symmetric(
          vertical: widget.isMobile ? 32 : 80,
        ),
        decoration: BoxDecoration(
          color: containerBg,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 50,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    "Testimonials",
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: widget.isMobile ? 32 : 40,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "What colleagues and clients say about our collaboration",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),

            // AREA CAROUSEL
            LayoutBuilder(
              builder: (context, constraints) {
                final totalWidth = constraints.maxWidth;
                // Overlay blur diatur proporsional (28% dari lebar layar) agar tidak menabrak teks kartu tengah
                final double overlayWidth = totalWidth * 0.28;

                return Stack(
                  children: [
                    // 1. List Card Testimoni
                    SizedBox(
                      height: widget.isMobile ? 300 : 400,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final actualDataIndex = index % _testimonials.length;

                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1.0;
                              double opacity = 1.0;
                              if (_pageController.position.haveDimensions) {
                                double page = _pageController.page ?? 0;
                                double diff = (page - index).abs();

                                // Di mobile, kartu samping langsung tidak terlihat karena fraction = 1.0
                                value = (1 - (diff * (widget.isMobile ? 0.2 : 0.25))).clamp(0.75, 1.0);
                                opacity = (1 - (diff * (widget.isMobile ? 0.7 : 0.6))).clamp(0.2, 1.0);
                              } else {
                                value = index == _currentIndex ? 1.0 : 0.75;
                                opacity = index == _currentIndex ? 1.0 : 0.2;
                              }

                              return Center(
                                child: Transform.scale(
                                  scale: value,
                                  child: Opacity(
                                    opacity: opacity,
                                    child: child,
                                  ),
                                ),
                              );
                            },
                            child: _buildTestimonialCard(_testimonials[actualDataIndex], isDark, colorScheme),
                          );
                        },
                      ),
                    ),

                    // 2. Kiri & Kanan Blur + Gradient Masking (HANYA MUNCUL DI DESKTOP)
                    if (!widget.isMobile) ...[
                      _buildEdgeOverlay(isLeft: true, containerBg: containerBg, width: overlayWidth),
                      _buildEdgeOverlay(isLeft: false, containerBg: containerBg, width: overlayWidth),
                    ],

                    // 3. Tombol Navigasi Desktop (Melayang di sisi kanan & kiri, di atas blur)
                    if (!widget.isMobile) ...[
                      Positioned(
                        left: 24,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: _buildNavButton(
                            icon: Icons.arrow_back_rounded,
                            onPressed: _prevPage,
                            isDark: isDark,
                            colorSchema: colorScheme,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 24,
                        top: 0,
                        bottom: 0,
                        child: Center(
                          child: _buildNavButton(
                            icon: Icons.arrow_forward_rounded,
                            onPressed: _nextPage,
                            isDark: isDark,
                            colorSchema: colorScheme,
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),

            // 4. Tombol Navigasi Mobile (Dipindah ke bawah khusus mode HP agar mudah dijangkau)
            if (widget.isMobile) ...[
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildNavButton(
                    icon: Icons.arrow_back_rounded,
                    onPressed: _prevPage,
                    isDark: isDark,
                    colorSchema: colorScheme,
                  ),
                  const SizedBox(width: 16),
                  _buildNavButton(
                    icon: Icons.arrow_forward_rounded,
                    onPressed: _nextPage,
                    isDark: isDark,
                    colorSchema: colorScheme,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Widget Masking Blur & Fade (Khusus Desktop)
  Widget _buildEdgeOverlay({required bool isLeft, required Color containerBg, required double width}) {
    return Positioned(
      top: 0,
      bottom: 0,
      left: isLeft ? 0 : null,
      right: isLeft ? null : 0,
      child: IgnorePointer(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 0),
            child: Container(
              width: width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
                  end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
                  colors: [
                    containerBg,
                    containerBg.withOpacity(0.85),
                    containerBg.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(Testimonial testimonial, bool isDark, ColorScheme colorSchema) {
    final double avatarRadius = widget.isMobile ? 22 : 28;
    final double nameFontSize = widget.isMobile ? 15 : 18;
    final double paddingVal = widget.isMobile ? 18 : 32;
    final double quoteFontSize = widget.isMobile ? 13 : 16;

    return Container(
      // Margin horizontal di HP diperlebar ke 20 agar jarak card ke tepi container luar terasa lega dan seimbang
      margin: EdgeInsets.symmetric(horizontal: widget.isMobile ? 20 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundColor: testimonial.color,
                child: Text(
                  testimonial.initials,
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: widget.isMobile ? 13 : 16,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      testimonial.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: nameFontSize,
                        color: isDark ? Colors.white : colorSchema.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      testimonial.role,
                      style: TextStyle(
                        fontSize: widget.isMobile ? 10 : 12,
                        letterSpacing: 0.5,
                        color: isDark ? Colors.white54 : colorSchema.onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(paddingVal),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: isDark ? Colors.white12 : Colors.black.withOpacity(0.04)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "”",
                    style: TextStyle(
                      fontSize: widget.isMobile ? 36 : 48,
                      height: 0.5,
                      fontFamily: 'serif',
                      color: isDark ? Colors.white24 : colorSchema.onSurface.withOpacity(0.2),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Text(
                        "\"${testimonial.quote}\"",
                        style: TextStyle(
                          fontSize: quoteFontSize,
                          height: 1.5,
                          fontStyle: FontStyle.italic,
                          color: isDark ? Colors.white70 : colorSchema.onSurface.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({required IconData icon, required VoidCallback? onPressed, required bool isDark, required ColorScheme colorSchema}) {
    final isDisabled = onPressed == null;
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        padding: EdgeInsets.all(widget.isMobile ? 12 : 16),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: isDark ? Colors.white24 : Colors.black12),
          color: isDisabled ? Colors.transparent : (isDark ? Colors.white10 : Colors.white),
          boxShadow: [
            if (!isDisabled && !widget.isMobile)
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Icon(
          icon,
          size: widget.isMobile ? 20 : 24,
          color: isDisabled ? (isDark ? Colors.white24 : Colors.black26) : (isDark ? Colors.white : colorSchema.onSurface),
        ),
      ),
    );
  }
}