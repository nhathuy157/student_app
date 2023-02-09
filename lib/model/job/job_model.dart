import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_price.dart';
import 'package:student_app/config/string/string_utility.dart';
import 'package:student_app/controller/category_controller.dart';
import 'package:student_app/model/other/address.dart';
import 'package:student_app/model/job/job_details_model.dart';
import 'package:student_app/model/other/type_salary.dart';
import 'package:student_app/model/users/user_detail.dart';
import 'package:student_app/controller/utility.dart';

import '../../config/string/string_app.dart';
import '../../config/string/string_job.dart';

class JobModel {
  String? idJob;
  String? idLocation;
  String? idCategoryFields;
  String? idNatural;
  String? nameJob;
  double? salaryMin;
  DateTime? timePost;
  double? salaryMax;
  String? idRangeMoney;
  String? idTypeSalary;
  String? images;
  JobDetailModel? jobDetails;
  DocumentReference? doc;

  JobModel(
      {this.idJob,
      this.idLocation,
      this.idCategoryFields,
      this.idNatural,
      this.nameJob,
      this.idTypeSalary,
      this.salaryMin,
      this.timePost,
      this.images,
      this.salaryMax,
      this.idRangeMoney,
      this.jobDetails});

  factory JobModel.fromSnapshot(DocumentSnapshot snapshot) {
    JobModel jobModel =
        JobModel.fromJson(snapshot.data() as Map<String, dynamic>);
    jobModel.doc = snapshot.reference;
    return jobModel;
  }

  factory JobModel.fromJson(Map<String, dynamic> responseData) {
    return JobModel(
      idJob: responseData[Job.idJob].toString(),
      idLocation: responseData[StringUtility.idLocation].toString(),
      idCategoryFields: responseData[Job.idCategoryFields].toString(),
      idNatural: responseData[Job.idNatural].toString(),
      nameJob: responseData[Job.nameJob],
      salaryMin: responseData[Job.salaryMin] is String
          ? double.tryParse(responseData[Job.salaryMin])
          : double.tryParse(responseData[Job.salaryMin].toString()),
      salaryMax: responseData[Job.salaryMax] is String
          ? double.tryParse(responseData[Job.salaryMax])
          : double.tryParse(responseData[Job.salaryMax].toString()),
      images: responseData[Job.imgs],
      timePost: responseData[Job.timePost] == null
          ? DateTime.now()
          : DateTime.fromMicrosecondsSinceEpoch(
              responseData[Job.timePost].microsecondsSinceEpoch),
      jobDetails: responseData[Job.jobDetails] == null
          ? null
          : JobDetailModel.fromJson(responseData[Job.jobDetails]),
      idRangeMoney: responseData[StringPrice.idRangeMoney],
      idTypeSalary: responseData[StringUtility.idTypeSalary] != null
          ? responseData[StringUtility.idTypeSalary].toString()
          : responseData[StringUtility.idTypeSalary],
    );
  }

  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      Job.idJob: idJob,
      Job.idCategoryFields: idCategoryFields,
      Job.idNatural: idNatural,
      Job.nameJob: nameJob,
      Job.salaryMin: salaryMin,
      Job.salaryMax: salaryMax,
      StringPrice.idRangeMoney: idRangeMoney,
      Job.timePost: timePost,
      Job.imgs: images,
      StringUtility.idTypeSalary: idTypeSalary,
      Job.jobDetails: jobDetails!.toDynamic(),
      StringUtility.idLocation: idLocation,
      StringUtility.keyWord: getKeyWorld(nameJob!),
    };
    return toData;
  }

  @override
  String toString() {
    String str = "";
    if (salaryMin != null) {
      str += priceToString(salaryMin!);
      if (salaryMax != null) {
        str += " ~ " + priceToString(salaryMax!);
      }
      str += CategoryController().getValueSalary(idTypeSalary);
    } else {
      str = StringApp.agree;
    }

    return str;
  }
}
