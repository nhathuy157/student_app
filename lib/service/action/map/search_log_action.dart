import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_map.dart';
import 'package:student_app/model/map/list_building.dart';
import 'package:student_app/model/map/list_room.dart';
import 'package:student_app/model/map/log_search.dart';
import 'dart:developer' as devtools show log;

class SearchLogAction {
  static List<SearchLog> actions = [];

  void getFromBuilding() {
    for (var element in ListBuildings.listBuildings) {
      actions.add(
        SearchLog(
          name: element.name,
          idBuilding: element.id,
        ),
      );
    }
  }

  void getFromRoom() {
    for (var element in Rooms.rooms) {
      actions.add(
        SearchLog(
          name: element.nameRoom,
          idBuilding: element.idBuilding,
        ),
      );
    }
  }

  Map<String, dynamic> searchLogToJson() {
    getFromBuilding();
    getFromRoom();
    devtools.log('hello bugs');
    return {
      "search_log": actions
          .map(
            (e) => e.getValue(),
          )
          .toList(),
    };
  }

  Future upSearchLogToFirebase() async {
    return await FirebaseFirestore.instance
        .collection(MapSearch.search)
        .doc(MapSearch.search)
        .set(
          searchLogToJson(),
        );
  }

  Future getBuildingFromFirebase() async {
    // ignore: unused_local_variable
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(MapSearch.search)
        .doc(MapSearch.search)
        .get();
    if (!snapshot.exists) {
      actions = [];
    } else {
      getFromSnapShot(snapshot);
    }
  }

  getFromSnapShot(DocumentSnapshot snapshot) {
    Map<String, dynamic> mapSearch = snapshot.data() as Map<String, dynamic>;
    List<dynamic> searchLists = mapSearch[MapSearch.search];
    if (actions.isEmpty) {
      for (var element in searchLists) {
        String name;
        String idBuilding;
        name = element.substring(0, element.lastIndexOf('^'));
        idBuilding =
            element.substring(element.lastIndexOf('^') + 1, element.length);
        devtools.log(element);

        actions.add(SearchLog(
          name: name,
          idBuilding: idBuilding,
        ));
      }
    } else {
      return;
    }
  }
}
