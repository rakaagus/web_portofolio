import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/Navigation/nav_item.dart';
import 'package:web_portofolio/presentation/widget/liquid_glass_widget.dart';
import 'item_menu_data.dart';

class GlassBottomBar extends StatelessWidget {
  final int selectedIndex;

  const GlassBottomBar({
    super.key,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: IntrinsicWidth(
          child: LiquidGlassContainer(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            blur: 20,
            shadowBlurRadius: 20,
            shadowOffset: const Offset(0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: appMenuData.asMap().entries.map((entry) {
                var item = entry.value;
                int idx = entry.key;
                bool isSelected = selectedIndex == idx;
                return NavItemWidget(
                  iconData: isSelected ? entry.value['filledIcon'] : entry.value['outlineIcon'],
                  label: entry.value['label'],
                  isSelected: isSelected,
                  onTap: () => Navigator.pushReplacementNamed(context, item['route']),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}