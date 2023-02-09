import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/model/hotel/category_type_hotel.dart';

import '../../../config/string/string_category.dart';
import '../../../config/string/string_utility.dart';
import '../../other/json_manager.dart';

class HotelTypeAction {
  // ignore: non_constant_identifier_names
  Future<List<CategoryTypeHotel>> ReadJsonHotelCategoryType() async {
    final jsonData = await rootBundle.loadString(DataAssets.categoryHotelType);
    final list = json.decode(jsonData) as List<dynamic>;
    return listType =
        list.map((e) => CategoryTypeHotel.fromJson(e)).toList();
  }
  
    Future<List<CategoryTypeHotel>> getFromFirebase() async {
    List<dynamic> list = await JsonManager().categoryFormFireBase(
        url: StringUtility.urlTypeHotel,
        nameType: StringCategory.typeHotel);
    return list.map((e) => CategoryTypeHotel.fromJson(e)).toList();
  }

  static List<CategoryTypeHotel> listType = [];
}
