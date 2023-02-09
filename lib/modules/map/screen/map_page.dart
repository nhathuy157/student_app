// import 'package:student_app/config/string/string_app.dart';

import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/controller/utility_controller.dart';
import 'package:student_app/model/map/building.dart';
import 'package:student_app/model/map/list_building.dart';
import 'package:student_app/modules/map/widget/map/draw_map.dart';
import 'package:student_app/modules/map/widget/search/search_button.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/action/map/search_log_action.dart';
import 'package:student_app/widgets/stateless/icon_button_back.dart';
import 'package:student_app/widgets/stateless/icon_button_rounded.dart';
import 'package:flutter/material.dart';
import 'package:student_app/widgets/stateless/icon_inside.dart';
import 'dart:developer' as devtools show log;

import 'package:student_app/widgets/stateless/loading.dart';
import 'package:student_app/widgets/stateless/notification_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    Key? key,
  }) : super(key: key);
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _completer = Completer();
  late final TextEditingController searchText;
  final List<Building> buildings = ListBuildings.listBuildings;

  Future<void> animateTo(double lat, double lng) async {
    final c = await _completer.future;
    final p = CameraPosition(target: LatLng(lat, lng), zoom: 18);
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }

  @override
  void initState() {
    devtools.log('hello long');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Icon eyeStatus = const Icon(Icons.remove_red_eye_outlined);
  bool hideMarker = false;
  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        title: const SearchBoxButton(),
        titleSpacing: 0,
        leading: IconButtonBack(),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: IconButtonRounded(
              customWidget: IconInside(
                iconCustom: eyeStatus,
                onClick: () {
                  setState(
                    () {
                      if (eyeStatus.icon == Icons.remove_red_eye_outlined) {
                        eyeStatus = const Icon(Icons.remove_red_eye);
                        hideMarker = true;
                      } else {
                        eyeStatus = const Icon(Icons.remove_red_eye_outlined);
                        hideMarker = false;
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Future.wait([
          UtilityController.instance.checkConnect(),
          BuildingAction().getBuildingFromFirebase(),
          SearchLogAction().getBuildingFromFirebase(),
        ]),
        builder: (context, data) {
          if (data.hasError) {
            if (UtilityController.instance.haveConnect) {
              return NotificationPage(
                notification: ENotification.error,
                icBack: false,
              );
            } else {
              return NotificationPage(
                notification: ENotification.netWork,
                icBack: false,
              );
            }
          } else if (data.hasData) {
            return SafeArea(

              child: GoogleMapScreen(
                hideMarkers: hideMarker,
              ),
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
