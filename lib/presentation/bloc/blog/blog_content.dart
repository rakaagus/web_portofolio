import 'package:flutter/cupertino.dart';

class BlogContent extends StatefulWidget {
  final ScrollController scrollController;
  const BlogContent({super.key, required this.scrollController});

  @override
  State<BlogContent> createState() => _BlogContentState();
}

class _BlogContentState extends State<BlogContent> with SingleTickerProviderStateMixin  {
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
    return const Center(child: Text("Halaman Blogs"));
  }
}
