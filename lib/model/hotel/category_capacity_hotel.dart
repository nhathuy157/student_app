import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_hotel.dart';

import '../../config/string/string_job.dart';

class CategoryCapacityHotel {
  String? idCategoryCapacity;
  String? name;
  DocumentReference? doc;

  CategoryCapacityHotel({this.idCategoryCapacity, this.name});

  factory CategoryCapacityHotel.fromSnapshot(DocumentSnapshot snapshot) {
    CategoryCapacityHotel capacityHotel =
        CategoryCapacityHotel.fromJson(snapshot.data() as Map<String, dynamic>);
    capacityHotel.doc = snapshot.reference;
    return capacityHotel;
  }

  factory CategoryCapacityHotel.fromJson(Map<String, dynamic> responseData) {
    return CategoryCapacityHotel(
        idCategoryCapacity: responseData[StringHotel.idCapacity].toString(),
        name: responseData[StringHotel.nameCapacity]);
  }
  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> json = {
  //     Shop.categoryShop: {toDynamic()}
  //   };
  //   return json;
  // }
  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      StringHotel.idCapacity: idCategoryCapacity,
      StringHotel.nameCapacity: name,
    };
    return toData;
  }
}
