import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/string/string_job.dart';

class JobNatural {
  String? idCategoryNatural;
  String? name;
  DocumentReference? doc;

  JobNatural({this.idCategoryNatural, this.name});

  factory JobNatural.fromSnapshot(DocumentSnapshot snapshot) {
    JobNatural categoryJobLocationModel =
        JobNatural.fromJson(snapshot.data() as Map<String, dynamic>);
    categoryJobLocationModel.doc = snapshot.reference;
    return categoryJobLocationModel;
  }

  factory JobNatural.fromJson(Map<String, dynamic> responseData) {
    return JobNatural(
        idCategoryNatural: responseData[Job.idNatural].toString(),
        name: responseData[Job.name]);
  }
  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> json = {
  //     Shop.categoryShop: {toDynamic()}
  //   };
  //   return json;
  // }
  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      Job.idNatural: idCategoryNatural,
      Job.name: name,
    };
    return toData;
  }
}
