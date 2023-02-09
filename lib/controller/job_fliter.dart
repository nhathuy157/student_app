import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:student_app/config/string/string_job.dart';
import 'package:student_app/model/job/job_model.dart';
import 'package:student_app/service/other/contact_action.dart';
import 'package:student_app/service/action/job/job_action.dart';
import 'package:student_app/service/other/range_money_action.dart';

import '../config/string/string_use.dart';

class JobFilter {
  // JobFliter({required this._minSalary, required this._maxSalary});
  static List<String> listFilterNatural = [];
  static List<String> listFilterLocation = [];
  static List<String> listFilterFields = [];
  static List<JobModel> listJob = [];
  static List<JobModel> listFilter = [];
  static List<JobModel> listSearch = [];
  static List<JobModel> filters = [];
  static List<String> listRangeMoney = [];
  static double _minSalary = 0;
  static double _maxSalary = 0;
  static String title = StringUse.jobSearch;
  static bool haveOther = false;
  static bool isNew = false;

  List<String> getFilterField() {
    return listFilterFields;
  }

  bool setMin(String min) {
    try {
      _minSalary = double.parse(min);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool setMax(String max) {
    try {
      _minSalary = double.parse(max);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future initData() async {
    if (listFilterLocation.isEmpty &&
        listFilterFields.isEmpty &&
        listFilterNatural.isEmpty &&
        _minSalary == 0 &&
        _maxSalary == 0) {
      listJob = await JobsAction().getNewJob();
      isNew = true;
    } else {
      isNew = false;
      listJob = await JobsAction()
          .getJobByQuery(jobs: filters = getListObjectFilter());
    }
  }

  Future getSearch(String term) async {
    if (isNew) {
      listSearch = await JobsAction().getNewJob(
        search: term,
      );
    } else {}
  }

  List<JobModel> getListObjectFilter() {
    double maxTemp = _maxSalary.toDouble();
    if (_maxSalary == 0) {
      maxTemp = double.maxFinite;
    }
    listRangeMoney = RangeMoneyAction()
        .getListRageMony(min: _minSalary.toDouble(), max: maxTemp);
    List<JobModel> list = [];

    int i = 0;
    int j = 0;
    int k = 0;
    int h = 0;

    int fLengthField = listFilterFields.length;
    int fLengthLocation = listFilterLocation.length;
    int fLengthNatural = listFilterNatural.length;
    int fLengthMoney = listRangeMoney.length;

    int ii = fLengthField > 0 ? 1 : 0;
    int ij = fLengthLocation > 0 ? 1 : 0;
    int ik = fLengthNatural > 0 ? 1 : 0;
    int il = fLengthMoney > 0 ? 1 : 0;

    for (i = ii; i <= fLengthField; i++) {
      for (j = ij; j <= fLengthLocation; j++) {
        for (k = ik; k <= fLengthNatural; k++) {
          for (h = il; h <= fLengthMoney; h++) {
            JobModel job = JobModel();
            if (i > 0) {
              job.idCategoryFields = listFilterFields[i - 1];
            }
            if (j > 0) {
              job.idLocation = listFilterLocation[j - 1];
            }
            if (k > 0) {
              job.idNatural = listFilterNatural[k - 1];
            }
            if (h > 0) {
              job.idRangeMoney = listRangeMoney[h - 1];
            }
            list.add(job);
          }
        }
      }
    }
    return list;
  }

  Future<JobModel?> getJob(String idJob) async {
    int index = listJob.indexWhere((element) => element.idJob == idJob);

    if (index == -1) {
      return null;
    } else {
      if (listJob[index].jobDetails!.contact == null) {
        // listJob[index].jobDetails!.contact =
        //     await ContactAction().getContact(idContact: listJob[index].idJob!);
      }
      return listJob[index];
    }
  }
}
