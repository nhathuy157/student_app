import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/map/widget/common_used/icon_text_icon_button.dart';
import 'package:student_app/modules/map/widget/floor/floor_info.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/action/map/floor_action.dart';
import 'package:student_app/service/action/map/room_action.dart';
import 'package:student_app/widgets/stateless/dismissble_page.dart';
import 'package:student_app/widgets/stateless/icon_button_rounded.dart';
import 'package:student_app/widgets/stateless/icon_inside.dart';

class ListFloors extends StatefulWidget {
  const ListFloors({
    Key? key,
  }) : super(key: key);

  @override
  State<ListFloors> createState() => _ListFloorsState();
}

class _ListFloorsState extends State<ListFloors> {
  @override
  Widget build(BuildContext context) {
    return DismissiblePageCustom(
      function: () => Navigator.of(context).pop(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightGreen,
          title: AutoSizeText(
            BuildingAction.buildingSelected.name,
            maxLines: 1,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.orangeryYellow,
            ),
          ),
          titleSpacing: 0,
          leading: IconButtonRounded(
            spaceLeft: true,
            showDecoration: false,
            customWidget: IconInside(
                iconCustom: const Icon(Icons.arrow_back_ios_rounded),
                onClick: () {
                  Navigator.of(context).pop();
                }),
          ),
        ),
        body: ListView.builder(
          itemCount: FloorAction.floors.length,
          itemBuilder: ((context, index) {
            String nameFloor = FloorAction.floors.elementAt(index);
            return IconTextIconButton(
              onTap: () {
                FloorAction.nameFloorSelected = nameFloor;
                FloorAction.roomInFloor = RoomAction.rooms
                    .where((e) => e.numberOfFloor.toString() == nameFloor)
                    .toList();
                Navigator.of(context).push(
                  PageTransition(
                      type: PageTransitionType.rightToLeftWithFade,
                      curve: Curves.easeIn,
                      child: const FloorInfo()),
                );
              },
              icon: const Icon(
                Icons.add_business,
                color: AppColors.mainColor,
              ),
              text: "Tầng $nameFloor",
              iconTrailing: const Icon(
                Icons.keyboard_arrow_right,
                color: AppColors.greyBlur,
              ),
            );
          }),
        ),
      ),
    );
  }
}
