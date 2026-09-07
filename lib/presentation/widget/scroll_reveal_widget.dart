import 'package:flutter/material.dart';

class ScrollRevealWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final double offsetSlide;
  final AxisDirection direction;
  final ScrollController? scrollController;
  final Curve curve;

  const ScrollRevealWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 750),
    this.delay = Duration.zero,
    this.offsetSlide = 40.0,
    this.direction = AxisDirection.down,
    this.scrollController,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<ScrollRevealWidget> createState() => _ScrollRevealWidgetState();
}

class _ScrollRevealWidgetState extends State<ScrollRevealWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _revealed = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    Offset startOffset;
    switch (widget.direction) {
      case AxisDirection.down:
        startOffset = Offset(0, widget.offsetSlide);
        break;
      case AxisDirection.up:
        startOffset = Offset(0, -widget.offsetSlide);
        break;
      case AxisDirection.left:
        startOffset = Offset(widget.offsetSlide, 0);
        break;
      case AxisDirection.right:
        startOffset = Offset(-widget.offsetSlide, 0);
        break;
    }

    _slideAnimation = Tween<Offset>(
      begin: startOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    widget.scrollController?.addListener(_checkVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_revealed && widget.scrollController == null) {
      _scrollPosition?.removeListener(_checkVisibility);
      _scrollPosition = Scrollable.maybeOf(context)?.position;
      _scrollPosition?.addListener(_checkVisibility);
    }
  }

  @override
  void dispose() {
    widget.scrollController?.removeListener(_checkVisibility);
    _scrollPosition?.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (_revealed || !mounted) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final position = renderBox.localToGlobal(Offset.zero);
      final screenHeight = MediaQuery.of(context).size.height;

      // Trigger when the top of the element is within 92% of screen height
      if (position.dy < screenHeight * 0.92) {
        _revealed = true;
        widget.scrollController?.removeListener(_checkVisibility);
        _scrollPosition?.removeListener(_checkVisibility);

        if (widget.delay > Duration.zero) {
          Future.delayed(widget.delay, () {
            if (mounted) _controller.forward();
          });
        } else {
          _controller.forward();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value.clamp(0.0, 1.0),
            child: Transform.translate(
              offset: _slideAnimation.value,
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
