import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/di/injection_container.dart';
import 'package:web_portofolio/presentation/Navigation/bottombar_widget.dart';
import 'package:web_portofolio/presentation/Navigation/sidebar_widget.dart';
import 'package:web_portofolio/presentation/bloc/home/bloc/home_bloc.dart';
import 'package:web_portofolio/presentation/bloc/home/bloc/home_event.dart';
import 'package:web_portofolio/presentation/bloc/home/home_content.dart';
import 'package:web_portofolio/utils/base/base_stateful_widget.dart';


class HomeScreen extends StatefulWidget {
  final int selectedIndex;
  const HomeScreen({super.key, this.selectedIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulWidget<HomeScreen> {
  @override
  String getTitleLabel() => "AFY Dev";

  @override
  String get screenName => "Home";

  @override
  List<BlocProvider> getListBloc(BuildContext context) => [
    BlocProvider<HomeBloc>(
      create: (_) => getIt<HomeBloc>()..add(const LoadHomeData()),
    ),
  ];

  @override
  Widget? getRightAction() {
    return buildDefaultRightActions(context);
  }

  @override
  Widget? generateSideBar() {
    return LiquidGlassSidebar(
      selectedIndex: 0,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }

  @override
  Widget? generateBottomBar() {
    return GlassBottomBar(
      selectedIndex: 0,
      onNavigate: (String url) {
        customNavigateTo(context, url);
      },
    );
  }

  @override
  Widget generateBody() {
    return HomeContent(
      scrollController: baseScrollController,
      onNavigate: (String url) {
          customNavigateTo(context, url);
      },
    );
  }
}