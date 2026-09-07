import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/presentation/Navigation/bottombar_widget.dart';
import 'package:web_portofolio/presentation/Navigation/sidebar_widget.dart';
import 'package:web_portofolio/presentation/bloc/blog/blog_detail_content.dart';
import 'package:web_portofolio/utils/base/base_stateful_widget.dart';

class BlogDetailScreen extends StatefulWidget {
  final String slug;
  const BlogDetailScreen({super.key, required this.slug});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends BaseStatefulWidget<BlogDetailScreen> {
  @override
  void initState() {
    super.initState();
    appBarUseBackIcon = true;
  }

  @override
  String getTitleLabel() => "Article";

  @override
  String get screenName => "BlogDetail";

  @override
  List<BlocProvider> getListBloc(BuildContext context) => [];

  @override
  Widget? getRightAction() {
    return buildDefaultRightActions(context);
  }

  @override
  Widget? generateSideBar() {
    return LiquidGlassSidebar(
      selectedIndex: 3,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }

  @override
  Widget? generateBottomBar() {
    return GlassBottomBar(
      selectedIndex: 3,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }

  @override
  Widget generateBody() {
    return BlogDetailContent(
      slug: widget.slug,
      scrollController: baseScrollController,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }
}
