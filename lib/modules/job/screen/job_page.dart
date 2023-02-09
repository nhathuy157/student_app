// ignore_for_file: unused_local_variable, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/utility.dart';
import 'package:student_app/modules/job/widget/textbox_salary.dart';

import 'package:student_app/widgets/stateless/icon_button_back.dart';
import 'package:student_app/widgets/stateless/icon_inside.dart';
import 'package:student_app/model/job/category_job_fields_model.dart';
import 'package:student_app/model/job/job_natural.dart';
import 'package:student_app/controller/job_fliter.dart';
import 'package:student_app/modules/job/screen/job_result_page.dart';
import 'package:student_app/service/action/job/job_category_fields_action.dart';
import 'package:student_app/service/action/job/job_category_natural_action.dart';
import 'package:student_app/widgets/stateless/loading.dart';

import '../../../config/routes/routes.dart';
import '../../../config/string/string_app.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../controller/category_controller.dart';
import '../../../model/other/category.dart';
import '../../../model/other/location_category.dart';
import '../../../service/other/category_location.dart';
import '../../../service/size_screen.dart';
import '../../../widgets/stateful/category_widget/category_widget.dart';
import '../../../widgets/stateless/icon_button_rounded.dart';

import '../widget/item_jobnature.dart';

/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

class JobPage extends StatefulWidget {
  const JobPage({Key? key}) : super(key: key);

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  //GridView

  List<Category> location = [];
  List<Category> natural = [];
  List<Category> fields = [];
  //Textbox
  final minSalary = new TextEditingController();
  final maxSalary = new TextEditingController();
  bool notError = false;
  bool loading = true;

  Future getData() async {
    notError = await CategoryController().getLocationCategory();
    notError = await CategoryController().getNaturalCategory();
    notError = await CategoryController().getFieldCategory();
    notError = await CategoryController().getRangeMoneys();
    notError = await CategoryController().getRangeMoneys();
    notError = await CategoryController().getTypeSalary();
  }

  sortcategory() {
    location = sortCategorySelect(
        selected: JobFilter.listFilterLocation, categories: location);
    natural = sortCategorySelect(
        selected: JobFilter.listFilterLocation, categories: natural);
    fields = sortCategorySelect(
        selected: JobFilter.listFilterLocation, categories: fields);
  }

  @override
  void initState() {
    getData().whenComplete(() {
      location = CategoryController().locationConvertToCategories();
      natural = CategoryController().naturalConvertToCategories();
      fields = CategoryController().fieldConvertToCategories();
      Timer(const Duration(seconds: 1), () {
        setState(() {
          loading = false;
        });
      });
    });

    super.initState();
  }

  // mặc định

  final double _heightContainerFiedls = SizeScreen.sizeWidthScreen * 3.6 / 10;
  final double _heightContainerSalary = SizeScreen.sizeWidthScreen * 2.5 / 10;
  //@override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Công Việc',
                  style: AppTextStyles.h2,
                ),
                centerTitle: true,
                backgroundColor: AppColors.lightGreen,
                elevation: 4,
                actions: [
                  IconButtonRounded(
                    customWidget: IconInside(
                        iconCustom: Icon(Icons.check),
                        onClick: () {
                          Navigator.pushNamed(context, Routes.jobResultPage)
                              .then((value) {
                            sortcategory();
                          });
                        }),
                  ),
                ],
                leading: IconButtonBack()),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Lĩnh vực
                    CategoryWidget(
                      itemsSelected: JobFilter.listFilterFields,
                      categories: fields,
                      nameCategory: StringApp.field,
                      newPage: true,
                      typeShow: TypeShow.showAll,
                    ),
                    // Địa điểm
                    CategoryWidget(
                      typeShow: TypeShow.showMore,
                      center: true,
                      itemsSelected: JobFilter.listFilterLocation,
                      categories: location,
                      nameCategory: StringApp.location,
                    ),
                    //Mức lương
                    Container(
                      height: _heightContainerSalary +
                          SizeScreen.sizeWidthScreen * 0.1,
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  padding:
                                      const EdgeInsets.only(top: 1, left: 16),
                                  child: Text(
                                    'Mức lương',
                                    style: AppTextStyles.h4.copyWith(
                                        color: AppColors.orangeryYellow,
                                        fontWeight: FontWeight.bold),
                                  ))),
                          const SizedBox(
                            height: 4,
                          ),
                          Container(
                              width: size.width * 9.7 / 10,
                              height: _heightContainerSalary,
                              decoration: const BoxDecoration(
                                  color: AppColors.lightGreen,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        offset: Offset(3, 6),
                                        blurRadius: 6)
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  TextBoxSalary(
                                    textSalaryJob: 'Tối thiểu :',
                                  ),
                                  TextBoxSalary(
                                    textSalaryJob: 'Tối đa :',
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    //Tính chất công việc
                    CategoryWidget(
                      numberColum: 2,
                      center: true,
                      itemsSelected: JobFilter.listFilterNatural,
                      categories: natural,
                      nameCategory: StringApp.natural,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
