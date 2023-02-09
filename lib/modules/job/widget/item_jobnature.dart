// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_app/controller/job_fliter.dart';
import 'package:student_app/service/action/job/job_category_natural_action.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';

class ItemJobNature extends StatefulWidget {
  final String textJobNature;
  String idNatural;

  ItemJobNature({required this.textJobNature, required this.idNatural});

  @override
  State<ItemJobNature> createState() => _ItemJobNatureState();
}

class _ItemJobNatureState extends State<ItemJobNature> {
  bool changeColor = false;

  @override
  Widget build(BuildContext context) {
    if (JobFilter.listFilterNatural.contains(widget.idNatural)) {
      changeColor = true;
    } else {
      changeColor = false;
    }
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (() {
        setState(() {
          changeColor = !changeColor;
          changeColor
              ? JobFilter.listFilterNatural.add(widget.idNatural)
              : JobFilter.listFilterNatural.remove(widget.idNatural);
        });
      }),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
        child: Container(
          width: size.width * 3 / 10,
          height: size.height * 0.4 / 10,
          decoration: BoxDecoration(
              color: changeColor ? AppColors.mainColor : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.only(top: 2, right: 16),
              child: Text(
                widget.textJobNature,
                style: AppTextStyles.h5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
