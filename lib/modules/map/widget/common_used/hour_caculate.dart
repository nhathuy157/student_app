import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/model/map/building.dart';
import 'package:student_app/modules/map/widget/common_used/text_item.dart';
import 'package:student_app/service/action/map/building_action.dart';

class HourOpenClose extends StatelessWidget {
  Icon? icon;
  bool isSizeBoxBefore;
  bool isBorder;
  bool isPadding;
  Building building = BuildingAction.buildingSelected;
  HourOpenClose({
    Key? key,
    this.icon,
    this.isSizeBoxBefore = true,
    this.isBorder = true,
    this.isPadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TimeOfDay nowTime = TimeOfDay.now();
    final TimeOfDay timeOpen = TimeOfDay(
        hour: int.parse(building.hourOpen.substring(0, 2)),
        minute: int.parse(building.hourOpen.substring(3, 5)));
    final TimeOfDay timeClose = TimeOfDay(
        hour: int.parse(building.hourClose.substring(0, 2)),
        minute: int.parse(building.hourClose.substring(3, 5)));

    final double doubleNowTime =
        nowTime.hour.toDouble() + (nowTime.minute.toDouble() / 60);
    final double doubleOpenTime =
        timeOpen.hour.toDouble() + (timeOpen.minute.toDouble() / 60);
    final double doubleCloseTime =
        timeClose.hour.toDouble() + (timeClose.minute.toDouble() / 60);

    final AutoSizeText value = (doubleNowTime - doubleOpenTime > 0 &&
            doubleNowTime - doubleCloseTime < 0)
        ? AutoSizeText(
            'Open',
            style: AppTextStyles.h3.copyWith(
                color: AppColors.mainColor, fontWeight: FontWeight.w600),
          )
        : AutoSizeText(
            'Close',
            style: AppTextStyles.h3
                .copyWith(color: Colors.red, fontWeight: FontWeight.w600),
          );

    return IconText(
      icon: icon,
      text:
          '${building.hourOpen.toString()} - ${building.hourClose.toString()}',
      isBorder: isBorder,
      extraWidget: value,
      isSizedBoxBeforeText: isSizeBoxBefore,
      isPadding: isPadding,
    );
  }
}
