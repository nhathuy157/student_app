import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/model/job/job_natural.dart';

import '../../../config/string/string_category.dart';
import '../../../config/string/string_job.dart';
import '../../../config/string/string_utility.dart';
import '../../other/data_services.dart';
import '../../other/json_manager.dart';

class JobNaturalAction {
  // ignore: non_constant_identifier_names
  static List<JobNatural> listNatural = [];
  Future<List<JobNatural>> ReadJsonJobCategoryNatural() async {
    final jsonData =
        await rootBundle.loadString(DataAssets.category_job_natural);
    final list = json.decode(jsonData) as List<dynamic>;
    return listNatural = list.map((e) => JobNatural.fromJson(e)).toList();
  }

  Future<List<JobNatural>> getFromFirebase() async {
    List<dynamic> list = await JsonManager().categoryFormFireBase(
        url: StringUtility.urlJobNatural,
        nameType: StringCategory.jobNaturalCategory);
    return list.map((e) => JobNatural.fromJson(e)).toList();
  }
}
