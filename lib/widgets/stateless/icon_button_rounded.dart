// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../../service/size_screen.dart';

class IconButtonRounded extends StatelessWidget {
  bool showDecoration = false;
  bool spaceLeft = false;
  bool spaceRight = false;
  Widget customWidget;
  IconButtonRounded(
      {Key? key,
      required this.customWidget,
      this.spaceLeft = false,
      this.spaceRight = true,
      this.showDecoration = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double space = SizeScreen.sizeSpace;
    return Container(
      margin: EdgeInsets.only(
          left: spaceLeft ? space : 0, right: spaceRight ? space : 0),
      width: SizeScreen.sizeBox + space,
      height: SizeScreen.sizeAppBar,
      child: Container(
        padding: EdgeInsets.only(
          top: space,
          bottom: space,
        ),
        height: SizeScreen.sizeBox + space * 2,
        width: SizeScreen.sizeBox,
        child: Container(
          alignment: Alignment.center,
          decoration: showDecoration
              ? BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: AppColors.mainColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(14)))
              : null,
          height: SizeScreen.sizeBox,
          width: SizeScreen.sizeBox,
          child: customWidget,
        ),
      ),
    );
  }
}
