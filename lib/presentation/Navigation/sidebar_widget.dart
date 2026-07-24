import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/Navigation/nav_item.dart';
import 'package:web_portofolio/presentation/widget/liquid_glass_widget.dart';
import 'item_menu_data.dart';

class LiquidGlassSidebar extends StatefulWidget {
  final int selectedIndex;
  final Function(String url) onNavigate;

  const LiquidGlassSidebar({
    super.key,
    required this.selectedIndex,
    required this.onNavigate
  });

  @override
  State<LiquidGlassSidebar> createState() => _LiquidGlassSidebarState();
}

class _LiquidGlassSidebarState extends State<LiquidGlassSidebar> {
  bool _isSidebarHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isSidebarHovered = true),
      onExit: (_) => setState(() => _isSidebarHovered = false),
      child: Center(
        child: LiquidGlassContainer(
          width: _isSidebarHovered ? 200 : 70,
          margin: const EdgeInsets.only(right: 20),
          padding: const EdgeInsets.symmetric(vertical: 20),
          blur: 18,
          gradientBegin: Alignment.topCenter,
          gradientEnd: Alignment.bottomCenter,
          shadowBlurRadius: 30,
          shadowOffset: const Offset(0, 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: appMenuData.asMap().entries.map((entry) {
                var item = entry.value;
                int idx = entry.key;
                bool isSelected = widget.selectedIndex == idx;
                return NavItemWidget(
                  isVertical: true,
                  iconData: isSelected ? entry.value['filledIcon'] : entry.value['outlineIcon'],
                  label: entry.value['label'],
                  isSelected: isSelected,
                  isSidebarHovered: _isSidebarHovered,
                  onTap: () => widget.onNavigate(item['route']),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}