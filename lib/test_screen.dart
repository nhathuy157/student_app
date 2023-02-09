// ignore_for_file: must_be_immutable, non_constant_identifier_names, avoid_unnecessary_containers

/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'package:flutter/material.dart';
import 'package:student_app/service/action/map/fake_data_map.dart';

import 'config/routes/routes.dart';
import 'config/string/string_use.dart';
import 'config/themes/app_text_styles.dart';
import 'service/action/shop/fake_data_shop.dart';
import 'service/size_screen.dart';

class TestScreen extends StatelessWidget {
  TestScreen({Key? key}) : super(key: key);
  List<String> namePages = [
    Routes.shopTestPage,
    Routes.testFilePage,
    Routes.homePage,
    Routes.shoppingPage,
    Routes.mapPage,
    Routes.askHotelPage,
    Routes.infoSchoolPage,
    Routes.signInPage,
    Routes.showPostDetailPage,
    Routes.jobPage,
    Routes.jobResultPage,
    Routes.jobDetailsPage,
    Routes.hotelPage,
    Routes.welcomePage,
    Routes.error,
    Routes.noResult,
    Routes.addJob,
    Routes.addHotel,
    Routes.hotelDetail,
    Routes.noteView,
    Routes.userSettingRoute
  ];
  @override
  Widget build(BuildContext context) {
    SizeScreen().getSize(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringUse.testApp),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 80, right: 80),
                itemCount: namePages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(namePages[index]);
                      },
                      child: Text(
                        namePages[index],
                        style: AppTextStyles.h3,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
