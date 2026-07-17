import 'package:flutter/cupertino.dart';

class EducationContent extends StatefulWidget {
  final ScrollController scrollController;
  const EducationContent({super.key, required this.scrollController});

  @override
  State<EducationContent> createState() => _EducationContentState();
}

class _EducationContentState extends State<EducationContent> with SingleTickerProviderStateMixin {
  late AnimationController _arrowController;
  late Animation<double> _arrowAnimation;

  @override
  void initState() {
    super.initState();
    _arrowController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _arrowAnimation = Tween<double>(begin: 0, end: 15).animate(
      CurvedAnimation(parent: _arrowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _arrowController.dispose();
    super.dispose();
  }

  void _scrollToContent() {
    widget.scrollController.animateTo(
      MediaQuery.of(context).size.height,
      duration: const Duration(milliseconds: 750),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Halaman Education"));
  }
}
