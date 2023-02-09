// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/controller/job_fliter.dart';
import 'package:student_app/model/job/category_job_fields_model.dart';

import '../../../config/string/string_category.dart';
import '../../../config/string/string_job.dart';
import '../../../config/string/string_shop.dart';
import '../../../config/string/string_utility.dart';
import '../../../model/other/location_category.dart';
import '../../other/data_services.dart';
import '../../other/json_manager.dart';

class JobFieldsAction {
  static List<JobField> listFields = [];
  Future<List<JobField>> ReadJsonJobCategoryFields() async {
    final jsonData =
        await rootBundle.loadString(DataAssets.category_job_fields);
    final list = json.decode(jsonData) as List<dynamic>;
    return listFields = list.map((e) => JobField.fromJson(e)).toList();
  }

  Future<List<JobField>> getFromFirebase() async {
    List<dynamic> list = await JsonManager().categoryFormFireBase(
        url: StringUtility.urlJobFelids,
        nameType: StringCategory.jobFieldsCategory);
    return list.map((e) => JobField.fromJson(e)).toList();
  }
}
