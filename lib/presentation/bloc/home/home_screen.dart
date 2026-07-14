import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/presentation/Navigation/bottombar_widget.dart';
import 'package:web_portofolio/presentation/Navigation/sidebar_widget.dart';
import 'package:web_portofolio/presentation/bloc/home/home_content.dart';
import 'package:web_portofolio/utils/base/base_stateful_widget.dart';
import 'package:web_portofolio/presentation/Navigation/item_menu_data.dart';

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
    return LiquidGlassSidebar(
      selectedIndex: widget.selectedIndex,
      menuData: appMenuData,
    );
  }

  @override
  Widget? generateBottomBar() {
    return GlassBottomBar(
      selectedIndex: widget.selectedIndex,
      menuData: appMenuData,
    );
  }

  @override
  Widget generateBody() {
    switch (widget.selectedIndex) {
      case 0:
        return HomeContent(scrollController: baseScrollController);
      case 1:
        return const Center(child: Text("Halaman Experience"));
      case 2:
        return const Center(child: Text("Halaman Education"));
      case 3:
        return const Center(child: Text("Halaman Project"));
      default:
        return HomeContent(scrollController: baseScrollController);
    }
  }
}