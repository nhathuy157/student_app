import 'dart:developer';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_hotel.dart';

import '../../config/string/string_price.dart';
import '../../config/string/string_utility.dart';
import '../../controller/category_controller.dart';
import '../../controller/utility.dart';

class Hotel {
  String? idHotel;
  String? idCategoryType;
  String? idCategoryCapacity;
  String? idLocation;
  String? idRangeMoney;
  String? name;
  String? address;
  double? price;
  List<String>? img;
  String? description;
  String? area;
  String? idContact;
  String? idTypeSalary;
  DocumentReference? doc;

  Hotel(
      {this.idTypeSalary,
      this.idHotel,
      this.idCategoryCapacity,
      this.idCategoryType,
      this.idContact,
      this.idLocation,
      this.name,
      this.address,
      this.price,
      this.idRangeMoney,
      this.description,
      this.area});

  factory Hotel.fromSnapshot(DocumentSnapshot snapshot) {
    Hotel hotel = Hotel.fromJson(snapshot.data() as Map<String, dynamic>);
    hotel.doc = snapshot.reference;
    return hotel;
  }

  factory Hotel.fromJson(Map<String, dynamic> responseData) {
    return Hotel(
      idHotel: responseData[StringHotel.idHotel].toString(),
      idLocation: responseData[StringUtility.idLocation].toString(),
      idCategoryCapacity: responseData[StringHotel.idCapacity].toString(),
      idCategoryType: responseData[StringHotel.idType].toString(),
      name: responseData[StringHotel.nameHotel],
      address: responseData[StringHotel.address],
      idTypeSalary: responseData[StringUtility.idTypeSalary].toString(),
      price: responseData[StringHotel.price] is String
          ? double.tryParse(responseData[StringHotel.price])
          : double.tryParse(responseData[StringHotel.price].toString()),
      description: responseData[StringHotel.description],
      area: responseData[StringHotel.area].toString(),
      idContact: responseData[StringHotel.idContact].toString(),
      idRangeMoney: responseData[StringPrice.idRangeMoney],
    );
  }

  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      StringHotel.idHotel: idHotel,
      StringHotel.idType: idCategoryType,
      StringHotel.idCapacity: idCategoryCapacity,
      StringHotel.nameHotel: name,
      StringUtility.idLocation: idLocation,
      StringHotel.address: address,
      StringHotel.price: price,
      StringHotel.img: img,
      StringHotel.description: description,
      StringHotel.area: area,
      StringHotel.idContact: idContact,
      StringPrice.idRangeMoney: idRangeMoney,
      StringUtility.idTypeSalary : idTypeSalary
    };
    return toData;
  }

  @override
  String toString() {
    String str = "";
    str += priceToString(price!);
    // if (salaryMax != null) {
    //   str += " ~ " + priceToString(salaryMax!);
    // }
    str += CategoryController().getValueSalary(idTypeSalary);

    return str;
  }
}
