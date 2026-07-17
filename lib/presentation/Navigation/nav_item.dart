import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class NavItemWidget extends StatelessWidget {
  final IconData iconData;
  final String label;
  final bool isSelected;
  final bool isVertical;
  final bool isSidebarHovered;
  final VoidCallback onTap;

  const NavItemWidget({
    super.key,
    required this.iconData,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.isVertical = false,
    this.isSidebarHovered = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: isVertical ? 6 : 0,
        horizontal: isVertical ? 8 : 2,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          constraints: BoxConstraints(
            minWidth: isVertical ? (isSidebarHovered ? 160 : 50) : 70,
            maxWidth: isVertical ? (isSidebarHovered ? 160 : 50) : 80,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.onSurface.withOpacity(0.15) : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: colorScheme.onSurface,
                size: 22,
              ),
              if (isVertical && isSidebarHovered)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected ? colorScheme.onSurface : colorScheme.onSurface.withOpacity(.8),
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
  }
}