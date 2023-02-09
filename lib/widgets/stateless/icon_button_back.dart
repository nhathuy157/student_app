// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:student_app/widgets/stateless/icon_inside.dart';

import 'icon_button_rounded.dart';

class IconButtonBack extends StatelessWidget {
  IconButtonBack({
    Key? key,
    this.showDecoration = false,
  }) : super(key: key);
  bool showDecoration;

  @override
  Widget build(BuildContext context) {
    return IconButtonRounded(
      spaceLeft: true,
      customWidget: IconInside(
          iconCustom: Icon(Icons.arrow_back_ios_rounded),
          onClick: () {
            Navigator.of(context).pop();
          }),
      showDecoration: showDecoration,
    );
  }
}
