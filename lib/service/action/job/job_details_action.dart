import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/model/job/job_details_model.dart';

class JobsDetailsAction {
  // ignore: non_constant_identifier_names
  static List<JobDetailModel> listJobDetail = [];
  Future<List<JobDetailModel>> ReadJsonJobDetails() async {
    final jsonData = await rootBundle.loadString(DataAssets.job_details);
    final list = json.decode(jsonData) as List<dynamic>;
    return listJobDetail = list.map((e) => JobDetailModel.fromJson(e)).toList();
  }
  
}
