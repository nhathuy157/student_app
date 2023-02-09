import 'package:cloud_firestore/cloud_firestore.dart';

import '../../config/string/string_job.dart';

class JobField {
  String? idCategoryFields;
  String? name;
  DocumentReference? doc;

  JobField({this.idCategoryFields, this.name});

  factory JobField.fromSnapshot(DocumentSnapshot snapshot) {
    JobField categoryJobFieldsModel =
        JobField.fromJson(snapshot.data() as Map<String, dynamic>);
    categoryJobFieldsModel.doc = snapshot.reference;
    return categoryJobFieldsModel;
  }

  factory JobField.fromJson(Map<String, dynamic> responseData) {
    return JobField(
        idCategoryFields: responseData[Job.idCategoryFields].toString(),
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
      Job.idCategoryFields: idCategoryFields,
      Job.name: name,
    };
    return toData;
  }
}
