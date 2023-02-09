import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:provider/provider.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/model/map/direction.dart';
import 'package:student_app/model/map/list_building.dart';
import 'package:student_app/modules/map/widget/current_location/get_geo_current.dart';
import 'package:student_app/modules/map/widget/map/control_map.dart';
import 'package:student_app/modules/map/widget/map/draw_marker.dart';
import 'package:student_app/modules/map/widget/map/theme_map.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/size_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_app/model/map/building.dart';

@immutable
class GoogleMapScreen extends StatefulWidget {
  final bool hideMarkers;
  const GoogleMapScreen({Key? key, required this.hideMarkers})
      : super(key: key);
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
  static GlobalKey globalKeyDirectButton = GlobalKey();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final List<Building> buildings = ListBuildings.listBuildings;
  Building? building;
  int isMarkerTaped = -1;
  String markerFlag = '';
  MarkerId idMarkerTapPrev = const MarkerId('');
  String nameMarkerPrev = '';
  late BitmapDescriptor iconTapPrevious;
  late LatLng currentCameraPosition =
      LatLng(buildings[0].geo.latitude, buildings[0].geo.longitude);
  MapType _currentMapType = MapType.normal;
  String _currentTextMapType = 'Statelite view';
  Icon _isZoomIcon = const Icon(Icons.zoom_in_map_sharp);
  bool _isZoomedCheck = false;
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  late PointLatLng source;
  late PointLatLng des;

  @override
  void initState() {
    _createMarker();
    setState(() {
      building = BuildingAction.buildingSelected;
    });
    super.initState();
  }

  void changeColorMarkerOnTap(MarkerId markerId, BitmapDescriptor iconOnTap) {
    if (MarkerId(markerFlag) != markerId) {
      setState(() {
        if (markerFlag == '') {
          idMarkerTapPrev = markerId;
          nameMarkerPrev = BuildingAction.buildingSelected.name;
        }
        ControlMap.markers.update(idMarkerTapPrev,
            (value) => value.copyWith(iconParam: iconTapPrevious));
        ControlMap.markers
            .update(markerId, (value) => value.copyWith(iconParam: iconOnTap));
        idMarkerTapPrev = markerId;
        nameMarkerPrev = BuildingAction.buildingSelected.name;
        markerFlag = markerId.toString();
      });
    }
  }

  void _createMarker() async {
    for (var item in buildings) {
      final BitmapDescriptor icon = await createCustomMarkerBitmap(
          item.name.toString(),
          textStyle: AppTextStyles.h2.copyWith(color: Colors.white),
          backgroundColor: AppColors.orangeryYellow);
      final BitmapDescriptor iconOnTap = await createCustomMarkerBitmap(
          item.name.toString(),
          textStyle: AppTextStyles.h1.copyWith(color: Colors.white),
          backgroundColor: AppColors.mainColor);
      final MarkerId markerId = MarkerId(item.id);
      // creating a new MARKER
      final Marker marker = Marker(
        markerId: markerId,
        icon: icon,
        position: LatLng(
          item.geo.latitude,
          item.geo.longitude,
        ),
        onTap: () async {
          // if (!GoogleMapScreen.isFirstPress) {
          //   var snackBar = const SnackBar(content: Text('Please waiting'));
          //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
          //   Future.delayed(const Duration(milliseconds: 500), () {
          //     ScaffoldMessenger.of(context).removeCurrentSnackBar();
          //   });
          //   return;
          // }
          // GoogleMapScreen.isFirstPress = false;
          iconTapPrevious = await createCustomMarkerBitmap(nameMarkerPrev,
              textStyle: AppTextStyles.h2.copyWith(color: Colors.white),
              backgroundColor: AppColors.orangeryYellow);
          setState(() {
            BuildingAction.buildingSelected = item;
          });
          changeColorMarkerOnTap(markerId, iconOnTap);
          LatLng newlatlang = LatLng(
            BuildingAction.buildingSelected.geo.latitude,
            BuildingAction.buildingSelected.geo.longitude,
          );
          ControlMap().tapMarker(context, newlatlang);
        },
      );
      setState(() {
        ControlMap.markers[markerId] = marker;
      });
    }
  }

  void _onMapCreated(GoogleMapController gController) async {
    gController.setMapStyle(ThemeMap.mapStyle);
    setState(() {
      ControlMap.mapController = gController;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Consumer<DirectionPolyline>(
      builder: ((context, value, child) {
        return Stack(children: [
          GoogleMap(
              mapType: _currentMapType,
              onMapCreated: _onMapCreated,
              onCameraMove: (CameraPosition position) {
                setState(() {
                currentCameraPosition =
                    LatLng(position.target.latitude, position.target.longitude);
                });
              },
              padding: EdgeInsets.only(bottom: SizeScreen.sizeBox * 1.7),
              mapToolbarEnabled: false,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: false,
              zoomControlsEnabled: false,
              indoorViewEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    buildings[0].geo.latitude, buildings[0].geo.longitude),
                zoom: 18,
              ),
              markers: widget.hideMarkers
                  ? {}
                  : Set<Marker>.of(ControlMap.markers.values),
              polylines: Set<Polyline>.of(value.polylines.values),
              // polylines: _polyline,
              onTap: (LatLng value) async {
                final MarkerId markerId =
                    MarkerId(BuildingAction.buildingSelected.id);
                final BitmapDescriptor icon = await createCustomMarkerBitmap(
                    BuildingAction.buildingSelected.name.toString(),
                    textStyle: AppTextStyles.h2.copyWith(color: Colors.white),
                    backgroundColor: AppColors.orangeryYellow);
                if (markerFlag != '') {
                  setState(() {
                    ControlMap.markers.update(
                        markerId, (value) => value.copyWith(iconParam: icon));
                    markerFlag = '';
                  });
                }
              }),

          /// hien thi thong tin cua duong di
          if (value.info != null)
            Positioned(
              top: SizeScreen.sizeSpace,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(left: SizeScreen.sizeSpace * 2),
                  decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 5,
                        fit: FlexFit.loose,
                        child: Text(
                            '${value.info!.totalDistance}, ${value.info!.totalDuration}',
                            style: AppTextStyles.h3
                                .copyWith(fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        width: SizeScreen.sizeSpace,
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.loose,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: SizeScreen.sizeIcon,
                          ),
                          onPressed: () {
                            setState(() {
                              BuildingAction.sourceLocation = null;
                              BuildingAction.destinationLocation = null;
                              value.info = null;
                              value.clearPolylines();
                              ControlMap().animateToLocation(
                                  200, currentCameraPosition, 17);
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

          //nut  dinh vi
          Positioned(
            bottom: SizeScreen.sizeBox * 4,
            right: SizeScreen.sizeSpace * 1.5,
            child: MaterialButton(
              shape: const CircleBorder(),
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              onPressed: () async {
             
                var positionCurrent =
                    await GeoLocation().getGeoLocationPosition();
                setState(() {
                  BuildingAction.sourceLocation = LatLng(
                      positionCurrent.latitude, positionCurrent.longitude);
                  const MarkerId markerId = MarkerId('vi tri hien tai');
                  // creating a new MARKER
                  final Marker marker = Marker(
                    markerId: markerId,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen),
                    position: LatLng(
                        positionCurrent.latitude, positionCurrent.longitude),
                    onTap: () async {},
                  );
                  setState(() {
                    ControlMap.markers[markerId] = marker;
                  });

                  ControlMap().animateToLocation(
                      2,
                      LatLng(
                          marker.position.latitude, marker.position.longitude),
                      19);
                });
              },
              child: const Icon(Icons.gps_fixed, color: Colors.red),
            ),
          ),

          //nut zoom
          Positioned(
            bottom: SizeScreen.sizeBox * 2 + SizeScreen.sizeSpace,
            right: SizeScreen.sizeSpace * 2,
            child: MaterialButton(
              shape: const CircleBorder(),
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              onPressed: () {
                setState(() {
                  if (_isZoomIcon.icon == Icons.zoom_in_map_sharp) {
                    _isZoomIcon = const Icon(Icons.zoom_out_map_sharp);
                  } else {
                    _isZoomIcon = const Icon(Icons.zoom_in_map_sharp);
                  }
                  _isZoomedCheck = !_isZoomedCheck;
                });
                if (_isZoomedCheck) {
                  ControlMap().animateToLocation(0, currentCameraPosition, 22);
                } else {
                  ControlMap().animateToLocation(0, currentCameraPosition, 18);
                }
              },
              child: _isZoomIcon,
            ),
          ),

          //nut chuyen view
          Positioned(
            bottom: SizeScreen.sizeSpace * 2.5,
            right: SizeScreen.sizeSpace * 2.5,
            child: FloatingActionButton.extended(
              label: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.greyBlur,
              ),
              backgroundColor: Colors.white,
              icon: Text(
                _currentTextMapType,
                style: AppTextStyles.h5.copyWith(color: AppColors.greyBlur),
              ),
              onPressed: () {
                setState(
                  () {
                    _currentMapType = (_currentMapType == MapType.normal)
                        ? MapType.satellite
                        : MapType.normal;
                    _currentTextMapType =
                        (_currentTextMapType == 'Statelite view')
                            ? 'Normal view'
                            : 'Statelite view';
                  },
                );
              },
            ),
          )
        ]);
      }),
    );
  }
}
