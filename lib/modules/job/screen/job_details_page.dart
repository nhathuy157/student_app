// ignore_for_file: avoid_unnecessary_containers

/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_app/model/job/job_details_model.dart';
import 'package:student_app/model/other/search_model.dart';
import 'package:student_app/service/action/job/job_action.dart';
import 'package:student_app/service/other/category_location.dart';
import 'package:student_app/service/action/job/job_details_action.dart';
import 'package:student_app/widgets/stateless/icon_button_back.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../controller/job_fliter.dart';
import '../../../model/job/job_model.dart';
import '../../../service/size_screen.dart';

class JobDetailsPage extends StatefulWidget {
  String idJob;

  JobDetailsPage({
    Key? key,
    required this.idJob,
  }) : super(
          key: key,
        );

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  JobModel? jobModel;
  JobDetailModel? jobDetailModel;
  bool loading = true;

  Future getData() async {
    jobModel = await JobFilter().getJob(widget.idJob);
    jobDetailModel = jobModel!.jobDetails;
  }

  @override
  void initState() {
    getData().whenComplete(
      () => Timer(
        const Duration(seconds: 1),
        () {
          SearchModel.typeSearch = TypeSearch.job;
          setState(() {
            loading = false;
          });
        },
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String bullet = "\u2022" " ";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Công việc',
          style: AppTextStyles.h2,
        ),
        centerTitle: true,
        backgroundColor: AppColors.lightGreen,
        elevation: 4,
        leading: IconButtonBack(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: Text(
                  jobDetailModel!.nameStore ?? "",
                  style:
                      AppTextStyles.h2.copyWith(color: AppColors.textColorBold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  'Chi tiết công việc',
                  style: AppTextStyles.h4.copyWith(
                      color: AppColors.orangeryYellow,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: size.width * 9.3 / 10,
              height: size.height * 2 / 10,
              decoration: const BoxDecoration(
                  color: AppColors.lightGreen,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(3, 6),
                        blurRadius: 6)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 16, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Text(
                        bullet + ' ' + (jobModel!.nameJob ?? ""),
                        style: AppTextStyles.h4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColorBold),
                      ),
                    ),
                    Container(
                      child: Text(
                        bullet + ' ' + jobModel!.toString(),
                        style: AppTextStyles.h4.copyWith(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                    Container(
                      child: Text(bullet + " ", style: AppTextStyles.h4),
                    ),
                    Container(
                      child: Text(
                          bullet +
                              ' Số lượng : ' +
                              (jobDetailModel!.quantily ?? ""),
                          style: AppTextStyles.h4),
                    ),
                    Container(
                      child: Text(
                          bullet +
                              ' ' +
                              jobModel!.jobDetails!.address.toString(),
                          style: AppTextStyles.h4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  'Mô tả',
                  style: AppTextStyles.h4.copyWith(
                      color: AppColors.orangeryYellow,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: size.width * 9.3 / 10,
              // height: size.height * 14 / 10,
              decoration: const BoxDecoration(
                  color: AppColors.lightGreen,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(3, 6),
                        blurRadius: 6)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 8, bottom: 8, left: 16, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        bullet + ' ' + 'Mô tả công việc',
                        style: AppTextStyles.h4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColorBold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(
                        jobDetailModel!.jobDescription ?? "",
                        style: AppTextStyles.h4,
                      ),
                    ),
                    Container(
                      child: Text(
                        bullet + ' ' + 'Yêu cầu',
                        style: AppTextStyles.h4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColorBold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Text(jobDetailModel!.require ?? "",
                          style: AppTextStyles.h4),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 2),
                      child: Text(
                        bullet + ' ' + 'Quyền lợi',
                        style: AppTextStyles.h4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColorBold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 4, left: 4),
                      child: Text(jobDetailModel!.right ?? "",
                          style: AppTextStyles.h4),
                    ),
                    Container(
                      child: Text(
                        bullet + ' ' + 'Liên hệ',
                        style: AppTextStyles.h4.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textColorBold),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(top: 4, bottom: 4, left: 4),
                      child: Text(jobDetailModel!.idContact ?? "",
                          style: AppTextStyles.h4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
