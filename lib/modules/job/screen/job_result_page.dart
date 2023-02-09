// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/config/string/string_use.dart';
import 'package:student_app/controller/job_fliter.dart';
import 'package:student_app/model/job/job_details_model.dart';
import 'package:student_app/model/other/search_model.dart';
import 'package:student_app/modules/job/screen/job_search.dart';
import 'package:student_app/modules/page_temp.dart';
import 'package:student_app/widgets/stateful/search_page.dart';
import 'package:student_app/widgets/stateless/icon_button_back.dart';
import 'package:student_app/widgets/stateless/icon_button_rounded.dart';
import 'package:student_app/widgets/stateless/icon_inside.dart';
import 'package:student_app/model/job/job_model.dart';
import 'package:student_app/service/action/job/job_action.dart';
import 'package:student_app/widgets/stateless/loading.dart';
import 'package:student_app/widgets/stateless/no_result.dart';

import '../../../config/themes/app_colors.dart';

import '../../../service/size_screen.dart';
import '../../../widgets/stateful/my_search.dart';
import '../../../widgets/stateless/search_widget.dart';
import '../widget/item_listview_job.dart';

class JobResultPage extends StatefulWidget {
  String? search;
  JobResultPage({
    this.search,
    Key? key,
  }) : super(key: key);

  @override
  State<JobResultPage> createState() => _JobResultPageState();
}

class _JobResultPageState extends State<JobResultPage> {
  List<JobModel> listJob = [];

  bool loading = true;

  Future getData() async {
    await JobFilter().initData();
    listJob = JobFilter.listJob;
  }

  @override
  void initState() {
    getData().whenComplete(() {
      Timer(const Duration(seconds: 1), () {
        setState(() {
          loading = false;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: AppColors.lightGreen,
              elevation: 4,
              actions: [
                SearchWidget(
                  numberIcon: 2,
                  string: StringUse.jobSearch,
                  onTap: () async {
                    String search = (await myShowSearch(
                        context: context, delegate: CustomSearch()));
                    if (search.isNotEmpty) {
                      SearchModel().searchJob = search;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => JobSearchPage()),
                      );
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (_) {
                    //       return SearchPage();
                    //     },
                    //   ),
                    // );
                  },
                  // Đến đây
                ),
                // ignore: prefer_const_constructors
                IconButtonRounded(
                  customWidget: IconInside(
                    iconCustom: Icon(Icons.star),
                    color: AppColors.orangeryYellow,
                    onClick: () {},
                  ),
                  showDecoration: false,
                )
              ],
              leading: IconButtonBack(),
            ),
            body: listJob.isEmpty
                ? NoResult()
                : Column(
                    children: [
                      Expanded(
                          child: Container(
                        child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: listJob.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return ItemListViewJob(
                                textNameJob: listJob[index].nameJob!,
                                textAddress: listJob[index]
                                    .jobDetails!
                                    .address!
                                    .toString(),
                                textNatural: "",
                                textSalary: listJob[index].toString(),
                                img: listJob[index].images ?? "",
                                idJob: listJob[index].idJob!,
                              );
                            }),
                      ))
                    ],
                  ));
  }
}
