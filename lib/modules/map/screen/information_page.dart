import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/map/screen/description_page.dart';
import 'package:student_app/modules/map/screen/overview_page.dart';
import 'package:student_app/modules/map/screen/photos_page.dart';
import 'package:student_app/modules/map/widget/map/control_map.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:student_app/widgets/stateless/dismissble_page.dart';
import 'package:student_app/widgets/stateless/icon_button_rounded.dart';
import 'package:student_app/widgets/stateless/icon_inside.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
//Menu tabBar
  TabBar get _tabBar => const TabBar(
        indicatorColor: AppColors.mainColor,
        labelPadding: EdgeInsets.symmetric(horizontal: 2),
        labelColor: AppColors.mainColor,
        tabs: [
          Tab(
            text: 'OVERVIEW',
          ),
          Tab(
            text: 'PHOTOS',
          ),
          Tab(
            text: 'DESCRIPTION',
          ),
        ],
      );

  void exitPage() {
    Navigator.of(context).pop();
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
      child: DismissiblePageCustom(
        function: () => exitPage(),
        child: SafeArea(
          child: DefaultTabController(
            length: 3,
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
                        exitPage();
                      }),
                ),
                bottom: PreferredSize(
                  preferredSize: _tabBar.preferredSize,
                  child: ColoredBox(
                    color: Colors.white,
                    child: _tabBar,
                  ),
                ),
              ),

              //noi dung cua tung trang trong menu tab
              body:  const TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  OverViewPage(),
                  PhotosViewPage(),
                  DescriptionPage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
