import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_map.dart';

///chua co thong tin toa A1. A2. A16. A3. A4. A5, hội trường thống nhất. a16. a20
class Building {
  Building({
    required this.id,
    required this.name,
    required this.hourOpen,
    required this.hourClose,
    required this.usesPlace,
    required this.geo,
    required this.totalRooms,
    required this.totalFloors,
    required this.phone,
    required this.website,
    required this.description,
    required this.listPhoto,
  });

  String id;
  String name;
  String hourOpen;
  String hourClose;
  String usesPlace;
  GeoPoint geo;
  int totalRooms;
  int totalFloors;
  String phone;
  String website;
  String description;
  List<String> listPhoto;

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        id: json[MapBuilding.idBuilding] is String
            ? json[MapBuilding.idBuilding]
            : json[MapBuilding.idBuilding].toString(),
        name: json[MapBuilding.nameBuilding],
        hourOpen: json[MapBuilding.hourOpen],
        hourClose: json[MapBuilding.hourClose],
        usesPlace: json[MapBuilding.usesPlace],
        // geo: GeoPoint(
        //   // json[MapBuilding.geo]["lat"].toDouble(),
        //   // json[MapBuilding.geo]["lng"].toDouble(),
        // ),
        geo: json[MapBuilding.geo] is GeoPoint
            ? json[MapBuilding.geo]
            : GeoPoint(
                json[MapBuilding.geo]["lat"].toDouble(),
                json[MapBuilding.geo]["lng"].toDouble(),
              ),

        listPhoto: json[MapBuilding.listPhoto] != null
            ? json[MapBuilding.listPhoto].cast<String>()
            : [],
        totalFloors: json[MapBuilding.totalFloors] ?? 0,
        // ? json[MapBuilding.totalFloors].toInt()
        // : json[MapBuilding.totalFloors],
        totalRooms: json[MapBuilding.totalRooms] ?? 0,
        // ? json[MapBuilding.totalRooms].toInt()
        // : json[MapBuilding.totalRooms],
        phone: json[MapBuilding.phone] ?? '',
        website: json[MapBuilding.website] ?? '',
        description: json[MapBuilding.description],
      );

  Map<String, dynamic> toJson() => {
        MapBuilding.idBuilding: id,
        MapBuilding.nameBuilding: name,
        MapBuilding.hourOpen: hourOpen,
        MapBuilding.hourClose: hourClose,
        MapBuilding.usesPlace: usesPlace,
        MapBuilding.geo: geo,
        MapBuilding.listPhoto: listPhoto,
        MapBuilding.totalFloors: totalFloors,
        MapBuilding.totalRooms: totalRooms,
        MapBuilding.phone: phone,
        MapBuilding.website: website,
        MapBuilding.description: description,
      };
}
