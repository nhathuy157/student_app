import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../service/size_screen.dart';

class IconInside extends StatelessWidget {
  Icon iconCustom;
  Color color;
  VoidCallback onClick;
  IconInside(
      {Key? key,
      required this.iconCustom,
      required this.onClick,
      this.color = AppColors.mainColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      icon: iconCustom,
      iconSize: SizeScreen.sizeIcon + SizeScreen.sizeSpace / 1.5,
      color: color,
      onPressed: onClick,
    );
  }
}
