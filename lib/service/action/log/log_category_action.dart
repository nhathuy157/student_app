// ignore_for_file: await_only_futures

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/controller/utility.dart';

import '../../../config/string/string_category.dart';
import '../../../model/other/log_category.dart';

class LogCategoryAction {
  LogCategory logCategory = LogCategory();
  Future getLogLocal() async {
    final referent = await SharedPreferences.getInstance();
    logCategory.locationCategory =
        await referent.getString(StringCategory.locationCategory);
    logCategory.jobNaturalCategory =
        await referent.getString(StringCategory.jobNaturalCategory);
    logCategory.jobFieldsCategory =
        await referent.getString(StringCategory.jobFieldsCategory);
    logCategory.shopCategory =
        await referent.getString(StringCategory.shopCategory);
    logCategory.typeSalary =
        await referent.getString(StringCategory.typeSalary);
  }

  Future setLogLocal() async {
    final referent = await SharedPreferences.getInstance();
    await referent.setString(
        StringCategory.locationCategory, logCategory.locationCategory!);
    await referent.setString(
        StringCategory.jobNaturalCategory, logCategory.jobNaturalCategory!);
    await referent.setString(
        StringCategory.jobFieldsCategory, logCategory.jobFieldsCategory!);
    await referent.setString(
        StringCategory.shopCategory, logCategory.shopCategory!);
    await referent.setString(
        StringCategory.typeSalary, logCategory.typeSalary!);
  }
}
