import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:web_portofolio/di/injection_container.dart';
import 'package:web_portofolio/presentation/Navigation/bottombar_widget.dart' show GlassBottomBar;
import 'package:web_portofolio/presentation/Navigation/sidebar_widget.dart';
import 'package:web_portofolio/presentation/bloc/experience/bloc/experiences_bloc.dart';
import 'package:web_portofolio/presentation/bloc/experience/bloc/experiences_event.dart';
import 'package:web_portofolio/presentation/bloc/experience/experience_content.dart';
import 'package:web_portofolio/utils/base/base_stateful_widget.dart';

class ExperienceScreen extends StatefulWidget {
  final int selectedIndex;
  const ExperienceScreen({super.key, this.selectedIndex = 0});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends BaseStatefulWidget<ExperienceScreen> {
  @override
  String getTitleLabel() => "My Experiences";

  @override
  String get screenName => "Experiences";

  @override
  List<BlocProvider> getListBloc(BuildContext context) => [
    BlocProvider<ExperiencesBloc>(
      create: (_) => getIt<ExperiencesBloc>()..add(const LoadExperiencesData()),
    ),
  ];

  @override
  Widget? getRightAction() {
    return buildDefaultRightActions(context);
  }

  @override
  Widget? generateSideBar() {
    return LiquidGlassSidebar(
      selectedIndex: 1,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }

  @override
  Widget? generateBottomBar() {
    return GlassBottomBar(
      selectedIndex: 1,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }

  @override
  Widget generateBody() {
    return ExperienceContent(
      scrollController: baseScrollController,
      onNavigate: (String url) {
          customNavigateTo(context, url);
      },
    );
  }
}