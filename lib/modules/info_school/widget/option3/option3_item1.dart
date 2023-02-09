/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/constants/assets_part.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../config/themes/app_text_styles.dart';
import '../../../../widgets/stateless/icon_button_back.dart';

class DangUy extends StatefulWidget {
  const DangUy({Key? key}) : super(key: key);

  @override
  State<DangUy> createState() => _DangUyState();
}

class _DangUyState extends State<DangUy> {
  Icon cusIcon = const Icon(Icons.search, color: AppColors.mainColor);
  // ignore: non_constant_identifier_names
  Widget CusSearchBar = const Text("Đảng ủy", style: AppTextStyles.h2);
  List _members = [];
  Future<void> readJsonDU() async {
    final String dataJson =
        await rootBundle.loadString(DataAssets.info_dang_uy);
    final data = await json.decode(dataJson);
    setState(() {
      _members = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
     final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: CusSearchBar,
          backgroundColor: AppColors.lightGreen,
          leading: GestureDetector(
            child: IconButtonBack(),
          ),

        ),
        body: FutureBuilder(
          future: readJsonDU(),
          builder: (context, index) => Column(
            children: [
              // Display the data loaded from sample.json

              Expanded(
                  child: ListView.builder(
                      itemCount: _members.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          child: Text(
                                              _members[index]["position"],
                                              style: AppTextStyles.h3.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 3,
                                                      color: Colors.black)))),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Container(
                                            padding: const EdgeInsets.all(8),
                                            height: deviceHeight * 0.1,
                                            width: deviceWidth *0.8,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(_members[index]["name"],
                                                      style: AppTextStyles.h4),
                                                  Row(
                                                    children: [
                                                      const Icon(Icons.email),
                                                      Text(
                                                          _members[index]
                                                              ["email"],
                                                          style:
                                                              AppTextStyles.h4),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            decoration: const BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: AppColors.mainColor,
                                                    blurRadius: 4,
                                                    offset: Offset(0, 4),
                                                  )
                                                ],
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)),
                                                border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.mainColor),
                                                  left: BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.mainColor),
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.mainColor),
                                                  right: BorderSide(
                                                      width: 1,
                                                      color:
                                                          AppColors.mainColor),
                                                ))),
                                      )
                                    ])),
                          ),
                        );
                      }))
            ],
          ),
        ));
  }
}
