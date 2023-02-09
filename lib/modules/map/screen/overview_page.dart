import 'package:page_transition/page_transition.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/model/map/building.dart';
import 'package:student_app/modules/map/widget/common_used/hour_caculate.dart';
import 'package:student_app/modules/map/widget/common_used/icon_text_icon_button.dart';
import 'package:student_app/modules/map/widget/common_used/text_item.dart';
import 'package:flutter/material.dart';
import 'package:student_app/modules/map/widget/floor/floors_list.dart';
import 'package:student_app/modules/map/widget/room/rooms.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/action/map/floor_action.dart';
import 'package:student_app/service/action/map/room_action.dart';

class OverViewPage extends StatelessWidget {
  const OverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Building building = BuildingAction.buildingSelected;
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(children: [
          HourOpenClose(
            icon: const Icon(
              Icons.access_time,
              color: AppColors.mainColor,
            ),
          ),
          building.phone != ''
              ? IconText(
                  icon: const Icon(
                    Icons.phone,
                    color: AppColors.mainColor,
                  ),
                  text: building.phone.toString(),
                )
              : const SizedBox(),
          building.website != ''
              ? IconText(
                  icon: const Icon(
                    Icons.camera_sharp,
                    color: AppColors.mainColor,
                  ),
                  text: building.website.toString(),
                )
              : const SizedBox(),
          building.totalRooms > 0
              ? IconTextIconButton(
                  onTap: () async {
                    await RoomAction().getRoomByIdBuilding(
                        BuildingAction.buildingSelected.id);

                    Navigator.of(context).push(
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          curve: Curves.easeIn,
                          child: const ListRooms()),
                    );
                  },
                  icon: const Icon(
                    Icons.add_business,
                    color: AppColors.mainColor,
                  ),
                  text: "${building.totalRooms.toString()} phòng",
                  iconTrailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.greyBlur,
                  ),
                )
              : const SizedBox(),
          building.totalFloors != 0
              ? IconTextIconButton(
                  onTap: () async {
                    await RoomAction().getRoomByIdBuilding(
                        BuildingAction.buildingSelected.id);

                    FloorAction.floors =
                        RoomAction.rooms.map((e) => e.numberOfFloor).toSet();
                    Navigator.of(context).push(
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          curve: Curves.easeIn,
                          child: const ListFloors()),
                    );
                  },
                  icon: const Icon(
                    Icons.business_outlined,
                    color: AppColors.mainColor,
                  ),
                  text: "${building.totalFloors.toString()} tầng",
                  iconTrailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.greyBlur,
                  ),
                )
              : const SizedBox()
        ]);
      },
      itemCount: 1,
    );
  }
}
