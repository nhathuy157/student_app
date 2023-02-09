import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_app/model/map/direction.dart';
import 'package:student_app/modules/map/widget/current_location/get_geo_current.dart';
import 'package:student_app/modules/map/widget/direction_control/simple_dialog_item.dart';
import 'package:student_app/modules/map/widget/map/control_map.dart';
import 'package:student_app/modules/map/widget/search/search_delegate.dart';
import 'package:student_app/service/action/map/building_action.dart';

class SimpleDialogChooseTypeInputSource extends StatefulWidget {
  const SimpleDialogChooseTypeInputSource({Key? key}) : super(key: key);

  @override
  State<SimpleDialogChooseTypeInputSource> createState() =>
      _SimpleDialogChooseTypeInputSourceState();
}

class _SimpleDialogChooseTypeInputSourceState
    extends State<SimpleDialogChooseTypeInputSource> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text('Xác định vị trí hiện tại'),
      children: [
        SimpleDialogItem(
          icon: Icons.keyboard,
          color: Colors.orange,
          text: 'Nhập vị trí hiện tại',
          onPressed: () {
            setState(() {
              var position = BuildingAction.buildingSelected.geo;
              BuildingAction.destinationLocation =
                  LatLng(position.latitude, position.longitude);
            });
            Navigator.of(context).pop();
            showSearch(
              context: context,
              delegate: BuildingSearchDelegate(typeSearch: 2),
              useRootNavigator: false,
            );
          },
        ),
        Consumer<DirectionPolyline>(
          builder: ((context, value, child) {
            return SimpleDialogItem(
              icon: Icons.gps_fixed,
              color: Colors.red,
              text: 'Định vị trí hiện tại',
              onPressed: () async {
                var positionCurrent =
                    await GeoLocation().getGeoLocationPosition();
                setState(
                  () {
                    var position = BuildingAction.buildingSelected.geo;
                    BuildingAction.destinationLocation =
                        LatLng(position.latitude, position.longitude);
                    BuildingAction.sourceLocation = LatLng(
                        positionCurrent.latitude, positionCurrent.longitude);
                    if (BuildingAction.sourceLocation != null &&
                        BuildingAction.destinationLocation != null) {
                      value.createPolyines(BuildingAction.sourceLocation!,
                          BuildingAction.destinationLocation!);
                    }
                  },
                );
                Navigator.of(context).pop();
                ControlMap().animateToLocation(
                  200,
                  BuildingAction.sourceLocation!,
                  18,
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
