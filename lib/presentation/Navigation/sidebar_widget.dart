import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/Navigation/nav_item.dart';

class LiquidGlassSidebar extends StatefulWidget {
  final int selectedIndex;
  final List<Map<String, dynamic>> menuData;

  const LiquidGlassSidebar({
    super.key,
    required this.selectedIndex,
    required this.menuData,
  });

  @override
  State<LiquidGlassSidebar> createState() => _LiquidGlassSidebarState();
}

class _LiquidGlassSidebarState extends State<LiquidGlassSidebar> {
  bool _isSidebarHovered = false;

  @override
  Widget build(BuildContext context) {
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
                    children: widget.menuData.asMap().entries.map((entry) {
                      var item = entry.value;
                      int idx = entry.key;
                      bool isSelected = widget.selectedIndex == idx;
                      return NavItemWidget(
                        isVertical: true,
                        iconData: isSelected ? entry.value['filledIcon'] : entry.value['outlineIcon'],
                        label: entry.value['label'],
                        isSelected: isSelected,
                        isSidebarHovered: _isSidebarHovered,
                        onTap: () => Navigator.pushReplacementNamed(context, item['route']),
                      );
                    }).toList(),
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