import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/presentation/Navigation/bottombar_widget.dart';
import 'package:web_portofolio/presentation/Navigation/sidebar_widget.dart';
import 'package:web_portofolio/presentation/bloc/project/project_detail_content.dart';
import 'package:web_portofolio/utils/base/base_stateful_widget.dart';

class ProjectDetailScreen extends StatefulWidget {
  final String slug;
  const ProjectDetailScreen({super.key, required this.slug});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends BaseStatefulWidget<ProjectDetailScreen> {
  @override
  void initState() {
    super.initState();
    appBarUseBackIcon = true;
  }

  @override
  String getTitleLabel() => "Case Study";

  @override
  String get screenName => "ProjectDetail";

  @override
  List<BlocProvider> getListBloc(BuildContext context) => [];

  @override
  Widget? getRightAction() {
    return buildDefaultRightActions(context);
  }

  @override
  Widget? generateSideBar() {
    return LiquidGlassSidebar(
      selectedIndex: 2,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }

  @override
  Widget? generateBottomBar() {
    return GlassBottomBar(
      selectedIndex: 2,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }

  @override
  Widget generateBody() {
    return ProjectDetailContent(
      slug: widget.slug,
      scrollController: baseScrollController,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }
}
