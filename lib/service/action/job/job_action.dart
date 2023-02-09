import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:student_app/config/string/string_job.dart';
import 'package:student_app/config/string/string_price.dart';
import 'package:student_app/config/string/string_utility.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/constants/constant.dart';

import 'package:student_app/model/job/job_model.dart';

import '../../../controller/utility.dart';

class JobsAction {
  static bool lastDefault = false;
  static bool lastFelid = false;
  static bool lastSearch = false;
  JobModel jobNewLast = JobModel();
  List<JobModel> lastGetDefaults = [];
  List<JobModel> lastGetResults = [];

  static const limitResult = 10;
  final CollectionReference jobCollection =
      FirebaseFirestore.instance.collection(Job.job);

  // ignore: non_constant_identifier_names
  Future<List<JobModel>> ReadJsonJob() async {
    final jsonData = await rootBundle.loadString(DataAssets.job_js);
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => JobModel.fromJson(e)).toList();
  }

  Future addJob({required JobModel job}) async {
    await jobCollection.doc(job.idJob).set(job.toDynamic());
  }

  Future getNewJob({bool showMore = false, String search = ""}) async {
    List<JobModel> jobs = [];
    List<String> listProcural = [];
    String temp = "";
    for (var i = 0; i < search.length; i++) {
      if (search[i] == " ") {
        temp = "";
      } else {
        temp = temp + search[i];
        listProcural.add(temp);
      }
    }
    Query query = jobCollection.limit(limitResult);
    if (search.isNotEmpty) {
      query = query.where(StringUtility.keyWord,
          arrayContainsAny: getKeyWorld(search));
    }
    if (showMore) {
      query = query
          .startAfterDocument(await getDocumentReferentByID(jobNewLast.idJob!));
    }
    QuerySnapshot snapshot = await query.get();
    jobs.addAll(getFormSnapShot(snapshot));
    if (jobs.isNotEmpty) {
      jobs.sort(
        (a, b) => b.timePost!.compareTo(a.timePost!),
      );
      jobNewLast = jobs.last;
    }

    return jobs;
  }

  List<JobModel> getFormSnapShot(QuerySnapshot snapshot) {
    List<JobModel> list = [];
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      snapshot.docs.forEach((element) {
        list.add(JobModel.fromSnapshot(element));
      });
      return list;
    }
  }

  Future<DocumentSnapshot> getDocumentReferentByID(String id) async {
    return await jobCollection.doc(id).get();
  }

  Future<List<JobModel>> getJobByQuery(
      {required List<JobModel> jobs, bool showMore = false}) async {
    List<JobModel> jobResults = [];
    List<JobModel> listLast = [];
    for (var job in (showMore ? lastGetDefaults : jobs)) {
      Query query = jobCollection.orderBy(Job.timePost, descending: true);
      if (showMore) {
        query =
            query.startAfterDocument(await getDocumentReferentByID(job.idJob!));
      }
      if (job.idCategoryFields != null) {
        query =
            query.where(Job.idCategoryFields, isEqualTo: job.idCategoryFields);
      }
      if (job.idLocation != null) {
        query =
            query.where(StringUtility.idLocation, isEqualTo: job.idLocation);
      }
      if (job.idNatural != null) {
        query = query.where(Job.idNatural, isEqualTo: job.idNatural);
      }
      if (job.idRangeMoney != null) {
        query =
            query.where(StringPrice.idRangeMoney, isEqualTo: job.idRangeMoney);
      }
      QuerySnapshot snapshot = await query.limit(LIMIT).get();
      jobResults.addAll(getFormSnapShot(snapshot));
      if (jobResults.isNotEmpty) {
        listLast.add(jobResults.last);
      }
    }
    lastGetDefaults.clear();
    lastGetDefaults.addAll(listLast);
    return jobResults;
  }

  List<JobModel> getFormSnapShotQuery(
      QuerySnapshot snapshot, double salaryMax) {
    List<JobModel> list = [];
    if (snapshot.docs.isEmpty) {
      return [];
    } else {
      List<JobModel> list = [];
      snapshot.docs.forEach((element) {
        JobModel job = JobModel.fromSnapshot(element);
        list.add(job);
      });
      return list;
    }
  }
  // Future<DocumentSnapshot> getStartMinSalary(double minSalary) async{
  //   await
  // }

//     if (snapshot.docs.isEmpty) {
//       return [];
//     } else {
//       List<JobModel> listJob = [];
//       snapshot.docs.forEach((element) {
//         listJob.add(JobModel.fromSnapshot(element));
//       });
//       return listJob;
}
