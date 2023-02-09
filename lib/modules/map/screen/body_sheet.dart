import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:student_app/modules/map/screen/information_page.dart';
import 'package:student_app/modules/map/widget/body_sheet/photo_slider.dart';
import 'package:student_app/modules/map/widget/body_sheet/text_about.dart';
import 'package:student_app/modules/map/widget/direction_control/popup_dialog.dart';
import 'package:student_app/modules/map/widget/map/control_map.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/size_screen.dart';

class BodySheet extends StatefulWidget {
  @override
  State<BodySheet> createState() => _BodySheetState();
}

class _BodySheetState extends State<BodySheet> {
  //noi dung chu tren sheet
  @override
  void initState() {
    super.initState();
  }

  void exitPage() {
    Navigator.of(context).pop();
    ControlMap().animateToLocation(
      0,
      LatLng(
        BuildingAction.buildingSelected.geo.latitude,
        BuildingAction.buildingSelected.geo.longitude,
      ),
      18,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exitPage();
        return false;
      },
      child: Dismissible(
        key: const Key('body-sheet'),
        direction: DismissDirection.down,
        onUpdate: (_) {
          exitPage();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: SizeScreen.sizeSpace * 2),
                    width: SizeScreen.sizeBox,
                    height: SizeScreen.sizeSpace,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.greyBlur),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: SizeScreen.sizeSpace / 2),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        primary: Colors.deepOrange,
                      ),
                      onPressed: () {
                        exitPage();
                      },
                      child: Icon(
                        Icons.close_outlined,
                        size: SizeScreen.sizeIcon,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizeScreen.sizeSpace * 2),
              child: Column(
                children: [
                  const TextAbout(),
                  BuildingAction.buildingSelected.listPhoto.length > 1
                      ? const PhotoSlide()
                      : const SizedBox(),
                  const SizedBox(
                    height: 8,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: FloatingActionButton.extended(
                          label: const Text('Chỉ đường'), // <-- Text
                          backgroundColor: AppColors.blue,
                          icon: Icon(
                            // <-- Icon
                            Icons.directions,
                            size: SizeScreen.sizeIcon,
                          ),
                          onPressed: () async {
                            exitPage();
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  const SimpleDialogChooseTypeInputSource(),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: SizeScreen.sizeSpace * 3,
                      ),
                      Flexible(
                        flex: 1,
                        child: FloatingActionButton.extended(
                          label: const Text('Xem thông tin'), // <-- Text
                          backgroundColor: AppColors.orangeryYellow,
                          icon: Icon(
                            // <-- Icon
                            Icons.more,
                            size: SizeScreen.sizeIcon,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 400),
                                child: const InformationPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  ///button show more
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
