import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_app/modules/map/widget/polyline/directions.dart';
import 'package:student_app/modules/map/widget/polyline/directions_repository.dart';

class DirectionPolyline extends ChangeNotifier {
  Directions? info;
  Map<PolylineId, Polyline> polylines = {};

  void createPolyines(LatLng source, LatLng des) async {
    info = await DirectionsRepository(dio: Dio())
        .getDirections(origin: source, destination: des);
    notifyListeners();
    if (info != null) {
      var polylineID = const PolylineId('overview');
      var polyline = Polyline(
        polylineId: polylineID,
        color: Colors.red,
        width: 9,
        points: info!.polylinePoints!
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList(),
      );

      polylines[polylineID] = polyline;
    }
    notifyListeners();
  }

  void clearPolylines() {
    polylines.clear();
    notifyListeners();
  }
}
