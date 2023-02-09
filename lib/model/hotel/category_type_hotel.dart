import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_hotel.dart';

import '../../config/string/string_job.dart';

class CategoryTypeHotel {
  String? idCategoryType;
  String? name;
  String? images;
  DocumentReference? doc;

  CategoryTypeHotel({this.idCategoryType, this.name, this.images});

  factory CategoryTypeHotel.fromSnapshot(DocumentSnapshot snapshot) {
    CategoryTypeHotel categoryTypeHotel =
        CategoryTypeHotel.fromJson(snapshot.data() as Map<String, dynamic>);
    categoryTypeHotel.doc = snapshot.reference;
    return categoryTypeHotel;
  }

  factory CategoryTypeHotel.fromJson(Map<String, dynamic> responseData) {
    return CategoryTypeHotel(
        idCategoryType: responseData[StringHotel.idType].toString(),
        name: responseData[StringHotel.nameType],
        images: responseData[StringHotel.imgType]);
  }
  // Map<String, dynamic> toJson() {
  //   Map<String, dynamic> json = {
  //     Shop.categoryShop: {toDynamic()}
  //   };
  //   return json;
  // }
  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      StringHotel.idType: idCategoryType,
      StringHotel.nameType: name,
      StringHotel.imgType: images
    };
    return toData;
  }
}
