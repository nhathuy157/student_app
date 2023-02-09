import 'dart:developer';

import 'package:student_app/config/string/string_job.dart';
import 'package:student_app/controller/job_fliter.dart';
import 'package:student_app/model/job/job_details_model.dart';
import 'package:student_app/service/action/job/job_action.dart';
import 'package:student_app/service/action/job/job_category_fields_action.dart';
import 'package:student_app/service/other/category_location.dart';
import 'package:student_app/service/action/job/job_category_natural_action.dart';
import 'package:student_app/service/action/job/job_details_action.dart';
import 'package:student_app/service/other/range_money_action.dart';

class FakeDataJob {
  Future getJsonData() async {
    // await LocationCategoryAction().ReadJsonJobCategoryLocation();
    // await JobFieldsAction().ReadJsonJobCategoryFields();
    // await JobNaturalAction().ReadJsonJobCategoryNatural();
    JobFilter.listJob = await JobsAction().ReadJsonJob();
    await JobsDetailsAction().ReadJsonJobDetails();
    RangeMoneyAction().getRangeForJob();
    setDataJob();
    await JobToFireBase();
  }

  setDataJob() {
    for (var job in JobFilter.listJob) {
      final jobDetail = JobsDetailsAction.listJobDetail
          .indexWhere((element) => element.idJob == job.idJob);
      job.jobDetails = JobsDetailsAction.listJobDetail[jobDetail];
    }
  }

  Future JobToFireBase() async {
    for (var job in JobFilter.listJob) {
      await JobsAction().addJob(job: job);
    }
  }
}
