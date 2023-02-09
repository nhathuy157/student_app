import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:student_app/controller/job_fliter.dart';
import 'package:student_app/model/job/category_job_fields_model.dart';
import 'package:student_app/model/other/location_category.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../controller/category_controller.dart';
import '../../../service/size_screen.dart';

class ItemCategoryWidget extends StatefulWidget {
  String name;
  String? img;
  bool changeColor;
  VoidCallback onTab;
  bool center;
  double sizeItem;

  late List<String> selectedLocation;
  ItemCategoryWidget(
      {Key? key,
      this.img,
      required this.sizeItem,
      required this.onTab,
      required this.name,
      required this.center,
      this.changeColor = false,
      required this.selectedLocation})
      : super(key: key);
  @override
  State<ItemCategoryWidget> createState() => _ItemCategoryWidgetState();
}

class _ItemCategoryWidgetState extends State<ItemCategoryWidget> {
  double sizeText = 20;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTab,
      child: Container(
        height: widget.sizeItem,
        decoration: BoxDecoration(
            color: widget.changeColor ? AppColors.mainColor : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.img == null
                  ? Container()
                  : Container(
                      height: (widget.sizeItem - sizeText) * 0.75,
                      margin: EdgeInsets.all(4),
                      child: Image.asset(
                        widget.img!,
                        width: (widget.sizeItem - sizeText) * 0.75,
                        height: (widget.sizeItem - sizeText) * 0.75,
                      ),
                    ),
              Container(
                height: sizeText,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.name,
                    style: AppTextStyles.h45,
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
