import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:student_app/model/map/building.dart';
import 'package:student_app/model/map/list_building.dart';
import 'package:student_app/model/map/list_room.dart';
import 'package:student_app/model/map/room.dart';
import 'package:student_app/service/other/img_action.dart';
import 'package:student_app/service/action/map/building_action.dart';

import 'package:student_app/service/action/map/room_action.dart';
import 'package:student_app/service/action/map/search_log_action.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as devtools show log;

class FakeDataMap {
  Future<List<Building>> readBuildingFromJson() async {
    final jsonBuilding =
        await rootBundle.loadString('assets/data/map/building.json');
    final list = json.decode(jsonBuilding) as List<dynamic>;
    ListBuildings.listBuildings =
        list.map((e) => Building.fromJson(e)).toList();

    return ListBuildings.listBuildings;
  }

  Future<List<Room>> readRoomFromJson() async {
    final jsonRoom = await rootBundle.loadString('assets/data/map/room.json');
    final list = json.decode(jsonRoom) as List<dynamic>;
    Rooms.rooms = list.map((e) => Room.fromJson(e)).toList();
    return Rooms.rooms;
  }

  Future readBuildingAndRoomFromJson() async {
    await readBuildingFromJson();
    await readRoomFromJson();
    var uuid = const Uuid();
    var uuid2 = const Uuid();
    for (var item in ListBuildings.listBuildings) {
      String idBuilding = uuid.v1();
      for (var item2 in Rooms.rooms) {
        if (item2.idBuilding == item.id) {
          item2.idBuilding = idBuilding;
        }
        item2.id = uuid2.v1();
      }
      item.id = idBuilding;
    }
  }

  Future addBuildings() async {
    for (var item in ListBuildings.listBuildings) {
      await BuildingAction().addBuilding(item);
    }
  }

  Future addRooms() async {
    for (var item in Rooms.rooms) {
      await RoomAction().addRoom(item);
    }
  }

  Future<List<String>> getImgList() async {
    List<String> images = [];
    String assets = '';
    for (int i = 0; i < ListBuildings.listBuildings.length; i++) {
      for (var j = 0;
          j < ListBuildings.listBuildings[i].listPhoto.length;
          j++) {
        assets = ListBuildings.listBuildings[i].listPhoto[j];
        String pathStorage = '';
        pathStorage = 'img/map/${ListBuildings.listBuildings[i].id}/';
        String img = await ImgAction()
            .uploadImagesFirebase(assets: assets, pathStorage: pathStorage);
        ListBuildings.listBuildings[i].listPhoto[j] = img;
        images.add(img);
      }
    }
    return images;
  }

  Future totalAddBuilding() async {
    devtools.log('bat dau day du lieu len firebase');
    await readBuildingAndRoomFromJson();
    await getImgList();
    await addBuildings();
    await addRooms();
    await SearchLogAction().upSearchLogToFirebase();
    devtools.log('xong day du lieu len firebase');
  }
}
