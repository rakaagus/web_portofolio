import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/presentation/Navigation/bottombar_widget.dart' show GlassBottomBar;
import 'package:web_portofolio/presentation/Navigation/sidebar_widget.dart';
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
  List<BlocProvider> getListBloc(BuildContext context) => [];

  @override
  Widget? getRightAction() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
      onPressed: () {

      },
    );
  }

  @override
  Widget? generateSideBar() {
    return LiquidGlassSidebar(selectedIndex: 1);
  }

  @override
  Widget? generateBottomBar() {
    return GlassBottomBar(selectedIndex: 1);
  }

  @override
  Widget generateBody() {
    return const Center(child: Text("Halaman Experience"));
  }
}