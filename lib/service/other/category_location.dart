import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:student_app/config/string/string_category.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/model/other/location_category.dart';
import 'package:student_app/service/other/data_services.dart';
import 'package:student_app/service/other/json_manager.dart';

import '../../config/string/string_job.dart';
import '../../config/string/string_utility.dart';

class LocationCategoryAction {
  static List<LocationCategory> listLocation = [];
  // ignore: non_constant_identifier_names
  Future<List<LocationCategory>> ReadJsonJobCategoryLocation() async {
    final jsonData =
        await rootBundle.loadString(DataAssets.category_job_location);
    final list = json.decode(jsonData) as List<dynamic>;
    return listLocation =
        list.map((e) => LocationCategory.fromJson(e)).toList();
  }

  Future<List<LocationCategory>> getFromFirebase() async {
    List<dynamic> list = await JsonManager().categoryFormFireBase(
        url: StringUtility.urlLocationCategory,
        nameType: StringCategory.locationCategory);
    return list.map((e) => LocationCategory.fromJson(e)).toList();
  }
}
