import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';

class ItemCategoryShowALl extends StatefulWidget {
  String name;
  bool changeColor;
  VoidCallback onTap;

  ItemCategoryShowALl(
      {Key? key,
      required this.changeColor,
      required this.name,
      required this.onTap})
      : super(key: key);

  @override
  State<ItemCategoryShowALl> createState() => _ItemCategoryShowALlState();
}

class _ItemCategoryShowALlState extends State<ItemCategoryShowALl> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            color: widget.changeColor ? AppColors.mainColor : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Text(widget.name,
                overflow: TextOverflow.ellipsis, style: AppTextStyles.h4),
          ),
        ),
      ),
    );
  }
}
