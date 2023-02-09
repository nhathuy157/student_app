import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/model/hotel/category_capacity_hotel.dart';
import 'package:student_app/service/other/json_manager.dart';

import '../../../config/string/string_category.dart';
import '../../../config/string/string_utility.dart';

class HotelCapacityAction {
  // ignore: non_constant_identifier_names
  Future<List<CategoryCapacityHotel>> ReadJsonHotelCategoryCapacity() async {
    final jsonData =
        await rootBundle.loadString(DataAssets.categoryHotelCapacity);
    final list = json.decode(jsonData) as List<dynamic>;
    return listCapacity =
        list.map((e) => CategoryCapacityHotel.fromJson(e)).toList();
  }

  Future<List<CategoryCapacityHotel>> getFromFirebase() async {
    List<dynamic> list = await JsonManager().categoryFormFireBase(
        url: StringUtility.urlCapacityHotel,
        nameType: StringCategory.capacityHotel);
    return list.map((e) => CategoryCapacityHotel.fromJson(e)).toList();
  }

  static List<CategoryCapacityHotel> listCapacity = [];
}
