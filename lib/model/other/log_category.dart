// ignore_for_file: non_constant_identifier_names

import '../../config/string/string_category.dart';

class LogCategory {
  String? locationCategory;
  String? jobNaturalCategory;
  String? jobFieldsCategory;
  String? shopCategory;
  String? typeSalary;

  LogCategory(
      {this.locationCategory,
      this.jobNaturalCategory,
      this.jobFieldsCategory,
      this.shopCategory,
      this.typeSalary});

  factory LogCategory.fromJson(Map<String, dynamic> responseData) {
    return LogCategory(
      locationCategory: responseData[StringCategory.locationCategory],
      jobNaturalCategory: responseData[StringCategory.jobNaturalCategory],
      jobFieldsCategory: responseData[StringCategory.jobFieldsCategory],
      shopCategory: responseData[StringCategory.shopCategory],
      typeSalary: responseData[StringCategory.typeSalary],
    );
  }
  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      StringCategory.locationCategory: locationCategory,
      StringCategory.jobNaturalCategory: jobNaturalCategory,
      StringCategory.jobFieldsCategory: jobFieldsCategory,
      StringCategory.shopCategory: shopCategory,
      StringCategory.typeSalary: typeSalary,
    };
    return toData;
  }
}
