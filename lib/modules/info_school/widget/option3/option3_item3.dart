/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../config/themes/app_text_styles.dart';
import '../../../../constants/assets_part.dart';
import '../../../../widgets/stateless/icon_button_back.dart';

class BanGiamHieu extends StatefulWidget {
  const BanGiamHieu({Key? key}) : super(key: key);

  @override
  State<BanGiamHieu> createState() => _BanGiamHieuState();
}

class _BanGiamHieuState extends State<BanGiamHieu> {
  Icon cusIcon = const Icon(Icons.search, color: AppColors.mainColor);
  // ignore: non_constant_identifier_names
  Widget CusSearchBar = const Text("Ban giám hiệu", style: AppTextStyles.h2);
  List _members = [];
  Future<void> readJsonDU() async {
    final String dataJson =
        await rootBundle.loadString(DataAssets.info_ban_giam_hieu);
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
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (cusIcon.icon == Icons.search) {
                    cusIcon = const Icon(Icons.cancel);

                    CusSearchBar = const TextField(
                        textInputAction: TextInputAction.go,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Tìm kiếm",
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ));
                  } else {
                    cusIcon =
                        const Icon(Icons.search, color: AppColors.mainColor);
                    CusSearchBar =
                        const Text("Ban giám hiệu", style: AppTextStyles.h2);
                  }
                });
              },
              icon: cusIcon,
            )
          ],
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
                                            height: 72,
                                            width: 320,
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
