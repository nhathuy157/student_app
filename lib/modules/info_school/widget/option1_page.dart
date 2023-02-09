/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_app/constants/assets_part.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../widgets/stateless/icon_button_back.dart';

class Option1Page extends StatefulWidget {
  const Option1Page({Key? key}) : super(key: key);
  @override
  State<Option1Page> createState() => _Option1PageState();
}

class _Option1PageState extends State<Option1Page> {
  List _items = [];
 
  Future<void> readJson() async {
    final String dataJson = await rootBundle.loadString(DataAssets.option1);
    final data = await json.decode(dataJson);
    setState(() {
      _items = data["items"];
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.lightGreen,
        appBar: AppBar(
          backgroundColor: AppColors.lightGreen,
          title: const Text('Tầm nhìn, sứ mệnh giá trị cốt lõi',
              style: AppTextStyles.h2),
          leading: GestureDetector(
            child:IconButtonBack()
          ),
        ),
        body: FutureBuilder(
          future: readJson(),
          builder: (context, index) => Column(
            children: [
              // Display the data loaded from sample.json

              Expanded(
                child: ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: AppColors.lightGreen,
                        margin: const EdgeInsets.all(10),
                        elevation: 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(_items[index]["image"],
                                      color: AppColors.mainColor),
                                ),
                                Text(_items[index]["name"],
                                    style: AppTextStyles.h3.copyWith(
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                            Center(
                              child: Container(
                                  padding: const EdgeInsets.all(8),
                                  alignment: Alignment.center,
                                  height: deviceHeight*0.15,
                                  width: deviceWidth *0.86,
                                  child: Text(_items[index]["description"],
                                      style: AppTextStyles.h4),
                                  decoration: const BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.mainColor,
                                          blurRadius: 3,
                                          offset: Offset(0, 3),
                                        )
                                      ],
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: Border(
                                        top: BorderSide(
                                            width: 1,
                                            color: AppColors.mainColor),
                                        left: BorderSide(
                                            width: 1,
                                            color: AppColors.mainColor),
                                        bottom: BorderSide(
                                            width: 1,
                                            color: AppColors.mainColor),
                                        right: BorderSide(
                                            width: 1,
                                            color: AppColors.mainColor),
                                      ))),
                            )
                          ],
                        ));
                  },
                ),
              )
            ],
          ),
        ));
  }
}
