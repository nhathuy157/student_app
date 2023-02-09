import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_map.dart';
import 'package:student_app/model/map/list_room.dart';
import 'package:student_app/model/map/room.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'dart:developer' as devtools show log;

class RoomAction {
  static List<Room> rooms = Rooms.rooms
      .where((element) =>
          element.idBuilding.toString() == BuildingAction.buildingSelected.id)
      .toList();
  static Room roomSelected = rooms[0];
  static Map<String, List<Room>> mapRooms = {};

  Future addRoom(Room room) async {
    return await FirebaseFirestore.instance
        .collection(MapRoom.room)
        .doc(room.id)
        .set(room.toJson());
  }

  Future getRoomByIdBuilding(String idBuilding) async {
    if (mapRooms.containsKey(idBuilding)) {
      rooms = mapRooms[idBuilding] as List<Room>;
    } else {
      await getlistroomfromfirebase(idBuilding);
      mapRooms[idBuilding] = rooms;
    }
  }

  Future getlistroomfromfirebase(String idBuilding) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection(MapRoom.room)
        .where(MapRoom.idBuilding, isEqualTo: idBuilding)
        .get();
    devtools.log(idBuilding);
    if (snapshot.docs.isEmpty) {
      rooms = [];
    } else {
      getFromSnapShot(snapshot);
      for (var item in rooms) {
        devtools.log(item.nameRoom.toString());
      }
    }
  }

  getFromSnapShot(QuerySnapshot snapshot) {
    rooms = [];
    for (var element in snapshot.docs) {
      rooms.add(Room.fromJson(element.data() as Map<String, dynamic>));
    }
  }
}
