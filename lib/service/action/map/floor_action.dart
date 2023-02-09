import 'package:student_app/model/map/room.dart';
import 'package:student_app/service/action/map/room_action.dart';

class FloorAction {
  static Set<String> floors =
      RoomAction.rooms.map((e) => e.numberOfFloor).toSet();
  static List<Room> roomInFloor = [];
  static String nameFloorSelected = '';
}
