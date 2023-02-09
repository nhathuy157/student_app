// ignore_for_file: avoid_unnecessary_containers

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_app/controller/hotel_filter.dart';
import 'package:student_app/model/other/location_category.dart';
import 'package:student_app/controller/job_fliter.dart';
import 'package:student_app/service/other/category_location.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';

// ignore: must_be_immutable
class ItemCapacity extends StatefulWidget {
  String nameCapacity;
  String idCapacity;

  ItemCapacity({Key? key, required this.nameCapacity, required this.idCapacity})
      : super(key: key);

  @override
  State<ItemCapacity> createState() => _ItemCapacityState();
}

class _ItemCapacityState extends State<ItemCapacity> {
  bool changeColor = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        setState(() {
          changeColor = !changeColor;
          // changeColor
          //     // ? JobFilter.listFilterLocation.add(widget.idLocation)
          //     // : JobFilter.listFilterLocation.remove(widget.idLocation);
        });
      }),
      child: Container(
        decoration: BoxDecoration(
            color: changeColor ? AppColors.mainColor : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Text(
              widget.nameCapacity,
              style: AppTextStyles.h4,
            ),
          ),
        ),
      ),
    );
  }
}
