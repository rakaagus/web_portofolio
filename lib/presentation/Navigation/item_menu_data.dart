import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/Navigation/app_routes.dart';

List<Map<String, dynamic>> getAppMenuData(BuildContext context) => [
  {
    'route': AppRoutes.home,
    'outlineIcon': Icons.home_outlined,
    'filledIcon': Icons.home_rounded,
    'label': 'Home',
  },
  {
    'route': AppRoutes.experience,
    'outlineIcon': Icons.work_outline_rounded,
    'filledIcon': Icons.work_rounded,
    'label': 'Experience',
  },
  {
    'route': AppRoutes.projects,
    'outlineIcon': Icons.rocket_launch_outlined,
    'filledIcon': Icons.rocket_launch_rounded,
    'label': 'Projects',
  },
  {
    'route': AppRoutes.blogs,
    'outlineIcon': Icons.sticky_note_2_outlined,
    'filledIcon': Icons.sticky_note_2_rounded,
    'label': 'Blogs',
  },
];

const List<Map<String, dynamic>> appMenuData = [
  {
    'route': AppRoutes.home,
    'outlineIcon': Icons.home_outlined,
    'filledIcon': Icons.home_rounded,
    'label': 'Home',
  },
  {
    'route': AppRoutes.experience,
    'outlineIcon': Icons.work_outline_rounded,
    'filledIcon': Icons.work_rounded,
    'label': 'Experience',
  },
  {
    'route': AppRoutes.projects,
    'outlineIcon': Icons.rocket_launch_outlined,
    'filledIcon': Icons.rocket_launch_rounded,
    'label': 'Projects',
  },
  {
    'route': AppRoutes.blogs,
    'outlineIcon': Icons.sticky_note_2_outlined,
    'filledIcon': Icons.sticky_note_2_rounded,
    'label': 'Blogs',
  },
];