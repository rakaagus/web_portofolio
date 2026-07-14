import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/Navigation/nav_item.dart';

class GlassBottomBar extends StatelessWidget {
  final int selectedIndex;
  final List<Map<String, dynamic>> menuData;

  const GlassBottomBar({
    super.key,
    required this.selectedIndex,
    required this.menuData
  });

  @override
  Widget build(BuildContext context) {
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
                    children: menuData.asMap().entries.map((entry) {
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
          ),
        ),
      ),
    );
  }
}