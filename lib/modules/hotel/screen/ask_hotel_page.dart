// ignore_for_file: deprecated_member_use, avoid_unnecessary_containers

/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:student_app/config/string/string_app.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/controller/category_controller.dart';
import 'package:student_app/controller/hotel_filter.dart';
import 'package:student_app/controller/utility_controller.dart';
import 'package:student_app/model/hotel/category_type_hotel.dart';

import 'package:student_app/model/other/range_money.dart';

import 'package:student_app/service/action/hotel/hotel_category_capacity.dart';
import 'package:student_app/service/action/hotel/hotel_category_type.dart';

import 'package:student_app/service/other/range_money_action.dart';
import 'package:student_app/service/size_screen.dart';
import 'package:student_app/widgets/stateful/category_widget/category_widget.dart';
import 'package:student_app/widgets/stateless/notification_page.dart';
import 'package:student_app/widgets/stateless/loading_page.dart';

import '../../../config/routes/routes.dart';
import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../constants/constants.dart';
import '../../../model/other/category.dart';
import '../../../model/hotel/category_capacity_hotel.dart';
import '../../../model/other/location_category.dart';
import '../../../service/other/category_location.dart';
import '../../../widgets/stateless/catch_error_page.dart';
import '../../../widgets/stateless/icon_button_back.dart';
import '../../../widgets/stateless/icon_button_rounded.dart';
import '../../../widgets/stateless/icon_inside.dart';
import '../../../widgets/stateless/loading.dart';
import '../widget/item_capacity.dart';

import '../widget/item_type_room.dart';

class AskHotelPage extends StatefulWidget {
  const AskHotelPage({Key? key}) : super(key: key);

  @override
  State<AskHotelPage> createState() => _AskHotelPageState();
}

class _AskHotelPageState extends State<AskHotelPage> {
  List<Category> categoryRangeMoney = [];
  List<Category> categoryLocation = [];
  List<Category> categoryCaptacity = [];
  List<Category> categoryType = [];
  bool loading = true;
  bool isError = false;

  Future getData() async {
    try {
      await Future.wait([
        CategoryController().getLocationCategory(),
        CategoryController().getHotelType(),
        CategoryController().getHotelCapacity(),
        CategoryController().getRangeMoneys(),
        CategoryController().getTypeSalary()
      ]);
      categoryRangeMoney = CategoryController().rangeMoneyConvertToCategories();
      categoryLocation = CategoryController().locationConvertToCategories();
      categoryCaptacity =
          CategoryController().hotelCapacityConvertToCategories();
      categoryType = CategoryController().hotelTypeConvertToCategories();
    } catch (e) {
      // handleError(e)
      isError = true;
      UtilityController.instance.checkConnect();
    }
  }

  @override
  void initState() {
    getData().whenComplete(() {
      Timer(const Duration(seconds: 0), () {
        setState(() {
          loading = false;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingPageCatchError(
        isLoading: loading,
        isError: isError,
        widget: Scaffold(
          appBar: AppBar(
              title: const Text(
                StringApp.accommodation,
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
                        Navigator.pushNamed(context, Routes.hotelPage);
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
                  CategoryWidget(
                    numberRow: 1,
                    categories: categoryType,
                    numberColum: 4,
                    center: true,
                    typeShow: TypeShow.showImg,
                    itemsSelected: HotelFilter.listFilterType,
                    nameCategory: StringApp.typeHotel,
                  ),
                  CategoryWidget(
                    categories: categoryLocation,
                    center: true,
                    typeShow: TypeShow.showMore,
                    itemsSelected: HotelFilter.listLocation,
                    nameCategory: StringApp.location,
                  ),
                  CategoryWidget(
                      numberColum: 2,
                      categories: categoryRangeMoney,
                      typeShow: TypeShow.showMore,
                      center: true,
                      itemsSelected: HotelFilter.listRangeMoney,
                      nameCategory: StringApp.money),
                  CategoryWidget(
                      numberColum: 2,
                      categories: categoryCaptacity,
                      itemsSelected: HotelFilter.listFilterCapacity,
                      nameCategory: StringApp.capacity),
                ],
              ),
            ),
          ),
        ));
  }
}
