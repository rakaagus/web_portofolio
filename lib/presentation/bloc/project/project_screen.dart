import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:web_portofolio/di/injection_container.dart';
import 'package:web_portofolio/presentation/Navigation/bottombar_widget.dart' show GlassBottomBar;
import 'package:web_portofolio/presentation/Navigation/sidebar_widget.dart';
import 'package:web_portofolio/presentation/bloc/project/bloc/project_bloc.dart';
import 'package:web_portofolio/presentation/bloc/project/bloc/project_event.dart';
import 'package:web_portofolio/presentation/bloc/project/project_content.dart';
import 'package:web_portofolio/utils/base/base_stateful_widget.dart';

class ProjectScreen extends StatefulWidget {
  final int selectedIndex;
  const ProjectScreen({super.key, this.selectedIndex = 0});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends BaseStatefulWidget<ProjectScreen> {
  @override
  String getTitleLabel() => "My Projects";

  @override
  String get screenName => "Project";

  @override
  List<BlocProvider> getListBloc(BuildContext context) => [
    BlocProvider<ProjectBloc>(
      create: (_) => getIt<ProjectBloc>()..add(const LoadProjects()),
    ),
  ];

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
    return ProjectContent(
      scrollController: baseScrollController,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }
}