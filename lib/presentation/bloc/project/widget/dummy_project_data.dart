import 'dart:ui';

import 'package:flutter/material.dart';

class ProjectData {
  final String imagePath;
  final String title;
  final String description;
  final String category;
  final List<Widget> techStacks;
  final String demoLinkText;
  final IconData demoIcon;

  ProjectData({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.category,
    required this.techStacks,
    required this.demoLinkText,
    required this.demoIcon,
  });
}