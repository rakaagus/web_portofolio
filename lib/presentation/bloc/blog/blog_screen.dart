import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/presentation/Navigation/bottombar_widget.dart' show GlassBottomBar;
import 'package:web_portofolio/presentation/Navigation/sidebar_widget.dart';
import 'package:web_portofolio/presentation/bloc/blog/blog_content.dart';
import 'package:web_portofolio/presentation/bloc/project/project_content.dart';
import 'package:web_portofolio/utils/base/base_stateful_widget.dart';

class BlogScreen extends StatefulWidget {
  final int selectedIndex;
  const BlogScreen({super.key, this.selectedIndex = 0});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends BaseStatefulWidget<BlogScreen> {
  @override
  String getTitleLabel() => "My Blogs";

  @override
  String get screenName => "Blogs";

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
    return BlogContent(
      scrollController: baseScrollController,
      onNavigate: (String url) {
          customNavigateTo(context, url);
      },
    );
  }
}