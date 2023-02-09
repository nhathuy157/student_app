import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/map/widget/common_used/text_item.dart';
import 'package:student_app/service/action/map/room_action.dart';
import 'package:student_app/widgets/stateless/dismissble_page.dart';
import 'package:student_app/widgets/stateless/icon_button_rounded.dart';
import 'package:student_app/widgets/stateless/icon_inside.dart';

class RoomInfo extends StatefulWidget {
  const RoomInfo({Key? key}) : super(key: key);

  @override
  State<RoomInfo> createState() => _RoomInfoState();
}

class _RoomInfoState extends State<RoomInfo> {
  @override
  Widget build(BuildContext context) {
    return DismissiblePageCustom(
        function: () => Navigator.of(context).pop(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.lightGreen,
            title: AutoSizeText(
              "Phòng " + RoomAction.roomSelected.nameRoom,
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
          body: Column(children: [
            IconText(
              icon: const Icon(
                Icons.camera_sharp,
                color: AppColors.mainColor,
              ),
              text: 'Tầng ' + RoomAction.roomSelected.numberOfFloor.toString(),
            ),
            IconText(
              icon: const Icon(
                Icons.description,
                color: AppColors.mainColor,
              ),
              text: RoomAction.roomSelected.description.toString(),
            )
          ]),
        ));
  }
}
