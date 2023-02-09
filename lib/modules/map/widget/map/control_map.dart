import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_app/modules/map/screen/body_sheet.dart';

class ControlMap {
  static GoogleMapController? mapController;
  static Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Future<void> animateToLocation(
      int delay, LatLng newlatlang, double zoom) async {
    Future.delayed(Duration(milliseconds: delay), () {
      mapController
          ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: newlatlang,
        zoom: zoom,
      )));
    });
  }

  Future<void> _showModal(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 1200), () {
      showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          backgroundColor: Colors.white,
          isScrollControlled: true,
          isDismissible: false,
          context: context,
          builder: (context) {
            return BodySheet();
          });
    });
  }

  void tapMarker(BuildContext context, LatLng newlatlang) async {
    double zoom = 19;
    mapController
        ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: newlatlang,
          zoom: zoom,
        )))
        .then((value) => _showModal(context));
  }
}
