// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';

class ItemBottomBar extends StatelessWidget {
  final Icon iconBottomBar;
  VoidCallback onTap;
  ItemBottomBar({required this.iconBottomBar, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Tab(
        icon: Icon(
          iconBottomBar.icon,
          size: 40,
          color: AppColors.mainColor,
        ),
      ),
    );
  }
}
