import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/presentation/bloc/home/home_content.dart';
import 'package:web_portofolio/utils/base/base_stateful_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseStatefulWidget<HomeScreen> {
  int _selectedIndex = 0;
  bool _isSidebarHovered = false;

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) => setState(() => _isSidebarHovered = true),
      onExit: (_) => setState(() => _isSidebarHovered = false),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn,
          width: _isSidebarHovered ? 200 : 70,
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(isDark ? 0.12 : 0.4),
              width: 1.2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(isDark ? 0.08 : 0.2),
                Colors.white.withOpacity(isDark ? 0.02 : 0.1),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
                blurRadius: 30,
                offset: const Offset(0, 15),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _navMenuItems(isVertical: true),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget? generateBottomBar() {
    return _buildGlassBottomBar();
  }

  @override
  Widget generateBody() {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        HomeContent(scrollController: baseScrollController),
        const Center(child: Text("Halaman Project")),
        const Center(child: Text("Halaman Education")),
        const Center(child: Text("Halaman Experience")),
        const Center(child: Text("Halaman Contact Me")),
      ],
    );
  }

  List<Widget> _navMenuItems({bool isVertical = false}) {
    List<Map<String, dynamic>> items = [
      {'icon': Icons.home_rounded, 'label': 'Home'},
      {'icon': Icons.work_rounded, 'label': 'Experience'},
      {'icon': Icons.school_rounded, 'label': 'Education'},
      {'icon': Icons.rocket_launch_rounded, 'label': 'Projects'},
    ];

    return items.asMap().entries.map((entry) {
      int idx = entry.key;
      bool isSelected = _selectedIndex == idx;

      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: isVertical ? 6 : 0,
          horizontal: isVertical ? 8 : 2,
        ),
        child: InkWell(
          onTap: () => setState(() => _selectedIndex = idx),
          borderRadius: BorderRadius.circular(15),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            constraints: BoxConstraints(
              minWidth: isVertical ? (_isSidebarHovered ? 160 : 50) : 70,
              maxWidth: isVertical ? (_isSidebarHovered ? 160 : 50) : 80,
            ),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  entry.value['icon'],
                  color: isSelected ? Colors.blue : Colors.grey.shade400,
                  size: 22,
                ),
                if (isVertical && _isSidebarHovered)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        entry.value['label'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isSelected ? Colors.blue : Colors.grey.shade600,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildGlassBottomBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: IntrinsicWidth(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 65,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(isDark ? 0.08 : 0.25),
                        Colors.white.withOpacity(isDark ? 0.03 : 0.15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(isDark ? 0.15 : 0.5),
                      width: 1.2,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _navMenuItems(isVertical: false),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}