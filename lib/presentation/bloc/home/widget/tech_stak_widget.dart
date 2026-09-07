import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HoverTechStackCard extends StatefulWidget {
  final bool isDark;
  final bool isMobile;
  final ColorScheme colorScheme;

  const HoverTechStackCard({
    super.key,
    required this.isDark,
    required this.isMobile,
    required this.colorScheme,
  });

  @override
  State<HoverTechStackCard> createState() => HoverTechStackCardState();
}

class HoverTechStackCardState extends State<HoverTechStackCard> {
  bool _isHovered = false;
  late ScrollController _scrollController;
  bool _isScrolling = false;
  final double _itemWidth = 110.0;

  final List<Map<String, dynamic>> _techItems = [
    {'name': 'Flutter', 'icon': FontAwesomeIcons.flutter},
    {'name': 'Kotlin', 'icon': 'assets/images/kotlin_logo.png'},
    {'name': 'Python', 'icon': 'assets/images/python_icon.svg'},
    {'name': 'TypeScript', 'icon': 'assets/images/typescript_icon.svg'},
    {'name': 'Android', 'icon': FontAwesomeIcons.android},
    {'name': 'NestJS', 'icon': 'assets/images/nest_icon.js.svg'},
    {'name': 'Nuxt', 'icon': 'assets/images/nuxt_icon.svg'},
    {'name': 'Flask', 'icon': 'assets/images/flask_icon.svg'},
    {'name': 'Dart', 'icon': FontAwesomeIcons.dartLang},
    {'name': 'Firebase', 'icon': 'assets/images/firebase_icon.png'},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Mulai scroll otomatis setelah frame pertama selesai dirender
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScroll();
    });
  }

  // Fungsi untuk menjalankan animasi scroll tanpa henti (Infinite Scroll)
  void _startScroll() {
    if (_isScrolling || !_scrollController.hasClients) return;
    _isScrolling = true;
    _animateScroll();
  }

  void _animateScroll() {
    if (!_isScrolling || !_scrollController.hasClients) return;

    // Scroll sejauh 100 pixel secara konstan
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(seconds: 2), // Mengatur kecepatan jalan (makin lama makin lambat)
      curve: Curves.linear,
    ).then((_) {
      if (_scrollController.hasClients) {
        final double singleSetWidth = _techItems.length * _itemWidth;

        // Jika scroll sudah melewati batas panjang satu set item asli,
        // kita kurangi offsetnya secara instan tanpa disadari oleh user.
        if (_scrollController.offset >= singleSetWidth) {
          _scrollController.jumpTo(_scrollController.offset - singleSetWidth);
        }
        _animateScroll(); // Rekursif untuk jalan terus
      }
    });
  }

  // Fungsi untuk menjeda scroll saat kursor mouse melakukan hover (opsional, sangat estetik!)
  void _pauseScroll() {
    _isScrolling = false;
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.offset,
        duration: Duration.zero,
        curve: Curves.linear,
      );
    }
  }

  @override
  void dispose() {
    _isScrolling = false;
    _scrollController.dispose();
    super.dispose();
  }

  // Helper untuk merender icon/logo.
  // Mendukung IconData (bawaan) maupun String asset path, otomatis diwarnai onSurface!
  Widget _buildTechIcon(dynamic iconData, Color color) {
    const double iconSize = 36.0; // Samakan ukuran dasar icon & gambar

    Widget child;
    if (iconData is IconData) {
      child = Icon(
        iconData,
        size: iconSize,
        color: color,
      );
    } else if (iconData is String) {
      if (iconData.endsWith('.svg')) {
        child = SvgPicture.asset(
          iconData,
          height: iconSize,
          width: iconSize,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        );
      } else {
        child = Image.asset(
          iconData,
          height: iconSize,
          width: iconSize,
          fit: BoxFit.contain,
          color: color,
          colorBlendMode: BlendMode.srcIn,
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.code,
            size: iconSize,
            color: color,
          ),
        );
      }
    } else {
      child = Icon(
        Icons.code,
        size: iconSize,
        color: color,
      );
    }

    // Bungkus dalam SizedBox berukuran tetap agar posisi teks di bawahnya 100% konsisten
    return SizedBox(
      width: 40,
      height: 40,
      child: Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    final double cardHeight = widget.isMobile ? 110.0 : 130.0;
    final double overlayWidth = widget.isMobile ? 140.0 : 200.0;
    final double leftPadding = widget.isMobile ? 16.0 : 32.0;
    final double titleFontSize = widget.isMobile ? 18.0 : 22.0;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _pauseScroll();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _startScroll(); // Jalan lagi saat kursor keluar
      },
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuart,
        height: cardHeight,
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
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(left: overlayWidth - 20),
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = _techItems[index % _techItems.length];
                      return SizedBox(
                        width: _itemWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildTechIcon(
                              item['icon'],
                              widget.colorScheme.onSurface,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item['name'],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: widget.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: overlayWidth,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        isDark ? const Color(0xFF111111) : Colors.white,
                        isDark
                            ? const Color(0xFF111111).withOpacity(0.9)
                            : Colors.white.withOpacity(0.9),
                        isDark
                            ? const Color(0xFF111111).withOpacity(0.0)
                            : Colors.white.withOpacity(0.0),
                      ],
                    ),
                  ),
                  padding: EdgeInsets.only(left: leftPadding),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tech Stack",
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: widget.colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}