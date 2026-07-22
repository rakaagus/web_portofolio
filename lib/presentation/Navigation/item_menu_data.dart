import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const List<Map<String, dynamic>> appMenuData = [
  {
    'route': '/',
    'outlineIcon': Icons.home_outlined,
    'filledIcon': Icons.home_rounded,
    'label': 'Home',
  },
  {
    'route': '/experience',
    'outlineIcon': Icons.work_outline_rounded,
    'filledIcon': Icons.work_rounded,
    'label': 'Experience',
  },
  {
    'route': '/projects',
    'outlineIcon': Icons.rocket_launch_outlined,
    'filledIcon': Icons.rocket_launch_rounded,
    'label': 'Projects',
  },
  {
    'route': '/blogs',
    'outlineIcon': Icons.sticky_note_2_outlined,
    'filledIcon': Icons.sticky_note_2_rounded,
    'label': 'Blogs',
  },
];