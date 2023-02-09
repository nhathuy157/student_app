import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_utility.dart';

import '../../config/string/string_job.dart';

class LocationCategory {
  String? idLocation;
  String? nameLocation;
  DocumentReference? doc;

  LocationCategory({this.idLocation, this.nameLocation});

  factory LocationCategory.fromSnapshot(DocumentSnapshot snapshot) {
    LocationCategory categoryJobLocationModel =
        LocationCategory.fromJson(snapshot.data() as Map<String, dynamic>);
    categoryJobLocationModel.doc = snapshot.reference;
    return categoryJobLocationModel;
  }

  factory LocationCategory.fromJson(Map<String, dynamic> responseData) {
    return LocationCategory(
        idLocation: responseData[StringUtility.idLocation].toString(),
        nameLocation: responseData[StringUtility.nameLocation]);
  }
  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> json = {
  //     Shop.categoryShop: {toDynamic()}
  //   };
  //   return json;
  // }
  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      StringUtility.idLocation: idLocation,
      StringUtility.nameLocation: nameLocation,
    };
    return toData;
  }

  String? getId() {
    return idLocation;
  }
}
