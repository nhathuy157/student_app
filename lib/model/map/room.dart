import 'package:student_app/config/string/string_map.dart';

class Room {
  String id;
  String idBuilding;
  String nameRoom;
  String description;
  String numberOfFloor;

  Room(
      {required this.id,
      required this.idBuilding,
      required this.nameRoom,
      required this.description,
      required this.numberOfFloor});

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json[MapRoom.idRoom] is String
            ? json[MapRoom.idRoom]
            : json[MapRoom.idRoom].toString(),
        idBuilding: json[MapRoom.idBuilding] is String
            ? json[MapRoom.idBuilding]
            : json[MapRoom.idBuilding].toString(),
        nameRoom: json[MapRoom.nameRoom],
        description: json[MapRoom.description],
        numberOfFloor: json[MapRoom.numberOfFloor] is String
            ? json[MapRoom.numberOfFloor]
            : json[MapRoom.numberOfFloor].toString(),
      );

  Map<String, dynamic> toJson() => {
        MapRoom.idRoom: id,
        MapRoom.idBuilding: idBuilding,
        MapRoom.nameRoom: nameRoom,
        MapRoom.description: description,
        MapRoom.numberOfFloor: numberOfFloor,
      };
}
