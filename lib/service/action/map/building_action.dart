import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:student_app/config/string/string_map.dart';
import 'package:student_app/model/map/building.dart';
import 'package:student_app/model/map/list_building.dart';

class BuildingAction {
  static Building buildingSelected =
      ListBuildings.mapBuildings['1'] ?? ListBuildings.listBuildings[0];
  static int photoSelected = 0;

  static LatLng? sourceLocation;
  static LatLng? destinationLocation;

  Future addBuilding(Building building) async {
    return await FirebaseFirestore.instance
        .collection(MapBuilding.building)
        .doc(building.id)
        .set(building.toJson());
  }

  Future getBuildingFromFirebase() async {
    // ignore: unused_local_variable
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(MapBuilding.building).get();
    if (snapshot.docs.isEmpty) {
      ListBuildings.listBuildings = [];
    } else {
      getFromSnapShot(snapshot);
    }
  }

  getFromSnapShot(QuerySnapshot snapshot) {
    if (ListBuildings.listBuildings.isEmpty) {
      for (var element in snapshot.docs) {
        ListBuildings.listBuildings
            .add(Building.fromJson(element.data() as Map<String, dynamic>));
      }
      ListBuildings.mapBuildings = {
        for (var element in ListBuildings.listBuildings)
          element.id.toString(): element
      };
    } else {
      return;
    }
  }
}
