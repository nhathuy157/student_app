import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/model/other/search_model.dart';

import '../../../config/string/string_use.dart';
import '../../../config/themes/app_colors.dart';
import '../../../controller/job_fliter.dart';
import '../../../model/job/job_model.dart';
import '../../../widgets/stateful/my_search.dart';
import '../../../widgets/stateful/search_page.dart';
import '../../../widgets/stateless/icon_button_back.dart';
import '../../../widgets/stateless/icon_button_rounded.dart';
import '../../../widgets/stateless/icon_inside.dart';
import '../../../widgets/stateless/search_widget.dart';
import '../widget/item_listview_job.dart';

class JobSearchPage extends StatefulWidget {
  const JobSearchPage({Key? key}) : super(key: key);

  @override
  State<JobSearchPage> createState() => _JobSearchPageState();
}

class _JobSearchPageState extends State<JobSearchPage> {
  List<JobModel> listJob = [];

  bool loading = true;

  Future getData() async {
    loading = true;
    await JobFilter().getSearch(SearchModel().searchJob).whenComplete(
          () => Timer(
            const Duration(seconds: 1),
            () {
              listJob = JobFilter.listSearch;
              setState(() {
                loading = false;
              });
            },
          ),
        );
  }

  @override
  void initState() {
    getData().whenComplete(() => true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.lightGreen,
          elevation: 4,
          actions: [
            SearchWidget(
              numberIcon: 2,
              string: SearchModel().searchJob.isEmpty
                  ? StringUse.jobSearch
                  : SearchModel().searchJob,
              onTap: () async {
                String term = (await myShowSearch(
                    context: context, delegate: CustomSearch()));
                if (term.isNotEmpty) {
                  SearchModel().searchJob = term;
                  getData();
                }
              },
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
        body: Column(
          children: [
            Expanded(
                child: Container(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: listJob.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return ItemListViewJob(
                      textNameJob: listJob[index].nameJob!,
                      textAddress:
                          listJob[index].jobDetails!.address!.toString(),
                      textNatural: "",
                      textSalary: listJob[index].salaryMin == null
                          ? "Thỏa thuận"
                          : listJob[index].salaryMin.toString(),
                      img: listJob[index].images ?? "",
                      idJob: listJob[index].idJob!,
                    );
                  }),
            ))
          ],
        ));
  }
}
