import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/presentation/Navigation/bottombar_widget.dart' show GlassBottomBar;
import 'package:web_portofolio/presentation/Navigation/sidebar_widget.dart';
import 'package:web_portofolio/presentation/bloc/education/education_content.dart';
import 'package:web_portofolio/utils/base/base_stateful_widget.dart';

class EducationScreen extends StatefulWidget {
  final int selectedIndex;
  const EducationScreen({super.key, this.selectedIndex = 0});

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends BaseStatefulWidget<EducationScreen> {
  @override
  String getTitleLabel() => "Education";

  @override
  String get screenName => "Education";

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
    return LiquidGlassSidebar(selectedIndex: 2);
  }

  @override
  Widget? generateBottomBar() {
    return GlassBottomBar(selectedIndex: 2);
  }

  @override
  Widget generateBody() {
    return EducationContent(scrollController: baseScrollController);
  }
}