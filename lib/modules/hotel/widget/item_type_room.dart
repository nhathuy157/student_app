// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:student_app/model/other/location_category.dart';
import 'package:student_app/controller/job_fliter.dart';
import 'package:student_app/service/other/category_location.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';

// ignore: must_be_immutable
class ItemTypeRoom extends StatefulWidget {
  String nameTypeRoom;
  String idTypeRoom;
  String imgType;

  ItemTypeRoom(
      {Key? key,
      required this.nameTypeRoom,
      required this.idTypeRoom,
      required this.imgType})
      : super(key: key);

  @override
  State<ItemTypeRoom> createState() => _ItemTypeRoomState();
}

class _ItemTypeRoomState extends State<ItemTypeRoom> {
  bool changeColor = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        setState(() {
          changeColor = !changeColor;
          // changeColor
          //     ? JobFliter.listFilterLocaiton.add(widget.idLocation)
          //     : JobFliter.listFilterLocaiton.remove(widget.idLocation);
        });
      }),
      child: Container(
        decoration: BoxDecoration(
            color: changeColor ? AppColors.mainColor : Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 4),
              child: Image.asset(widget.imgType),
            ),
            Container(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  child: Text(
                    widget.nameTypeRoom,
                    style: AppTextStyles.h4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
