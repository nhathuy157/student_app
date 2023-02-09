import 'package:flutter/material.dart';

class SizeScreen {
  static late final double sizeWidthScreen;
  static late final double sizeHeightFullScreen;
  static late final double sizeHeightFull;
  static late final double sizeHeightScreen;
  static late final double sizeIcon;
  static late final double sizeSpace;
  static late final double sizeBox;
  static late final double sizeAppBar;
  static late final double sizeWidthCategory;
  static late final double sizeHeightStatusBar;
  static bool isSet = false;

  void getSize(BuildContext context) {
    if (isSet) return;
    isSet = true;
    sizeHeightFullScreen = MediaQuery.of(context).size.height;
    sizeHeightFull =
        sizeHeightFullScreen - MediaQuery.of(context).viewPadding.top;
    sizeWidthScreen = MediaQuery.of(context).size.width;
    sizeAppBar = AppBar().preferredSize.height;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    sizeHeightScreen =
        sizeHeightFullScreen - padding.top - padding.bottom - sizeAppBar;
    _getSizeSpace(sizeWidthScreen / 47);
    _getSizeIcon(sizeWidthScreen * (3 / 47));
    _getSizeBox(sizeAppBar - sizeSpace * 1.5);
    _getSizeShopCategory(sizeWidthScreen * (8 / 47));
  }

  _getSizeSpace(double getSize) {
    const double minSize = 8;
    const double maxSize = minSize / 1.125;
    if (getSize < minSize) {
      sizeSpace = minSize;
    } else if (getSize > maxSize) {
      sizeSpace = maxSize;
    } else {
      sizeSpace = getSize;
    }
  }

  _getSizeIcon(double getSize) {
    const double minSize = 24;
    const double maxSize = minSize / 1.125;
    if (getSize < minSize) {
      sizeIcon = minSize;
    } else if (getSize > maxSize) {
      sizeIcon = maxSize;
    } else {
      sizeIcon = getSize;
    }
  }

  _getSizeBox(double getSize) {
    const double minSize = 40;
    const double maxSize = minSize / 1.125;
    if (getSize < minSize) {
      sizeBox = minSize;
    } else if (getSize > maxSize) {
      sizeBox = maxSize;
    } else {
      sizeBox = getSize;
    }
  }

  _getSizeShopCategory(double getSize) {
    const double minSize = 64;
    const double maxSize = minSize / 1.125;
    if (getSize < minSize) {
      sizeWidthCategory = minSize;
    } else if (getSize > maxSize) {
      sizeWidthCategory = maxSize;
    } else {
      sizeWidthCategory = getSize;
    }
  }
}
