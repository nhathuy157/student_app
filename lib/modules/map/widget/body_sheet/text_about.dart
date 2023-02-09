import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/map/widget/common_used/hour_caculate.dart';
import 'package:student_app/service/action/map/building_action.dart';

class TextAbout extends StatelessWidget {
  const TextAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: AutoSizeText(
            BuildingAction.buildingSelected.name,
            style: AppTextStyles.h2.copyWith(color: Colors.black),
            maxLines: 1,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: AutoSizeText(
            BuildingAction.buildingSelected.usesPlace,
            style: AppTextStyles.h4.copyWith(color: AppColors.greyBlur),
            maxLines: 1,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: HourOpenClose(
            isSizeBoxBefore: false,
            isBorder: false,
            isPadding: false,
          ),
        )
      ],
    );
  }
}
