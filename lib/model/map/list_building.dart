import 'package:student_app/model/map/building.dart';

class ListBuildings {
  static List<Building> listBuildings = [];
  static Map<String, Building> mapBuildings = {
    for (var element in listBuildings) element.id.toString(): element
  };
}
