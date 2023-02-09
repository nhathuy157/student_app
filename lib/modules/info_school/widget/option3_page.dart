/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../constants/assets_part.dart';
import '../../../widgets/stateless/icon_button_back.dart';
import '../../../widgets/stateless/id_developing.dart';
import 'option3/option3_item1.dart';
import 'option3/option3_item3.dart';

class Option3Page extends StatelessWidget {
  const Option3Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.lightGreen,
          title: const Text('Cơ cấu tổ chức', style: AppTextStyles.h2),
          leading: GestureDetector(
            child: IconButtonBack(),
          ),
        ),
        body: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const DangUy()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: deviceHeight * 0.1,
                    width: deviceWidth * 0.8,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ignore: prefer_const_constructors
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                const Icon(Icons.people, color: Colors.black),
                          ),
                          Text('Đảng ủy',
                              style: AppTextStyles.h2.copyWith(
                                color: Colors.black,
                              ))
                        ]),
                  ),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  ToastLog.isDeveloping();
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: deviceHeight * 0.1,
                    width: deviceWidth * 0.8,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ignore: prefer_const_constructors
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(ImgAssets.schoolcouncil),
                          ),
                          Text('Hội đồng trường',
                              style: AppTextStyles.h2.copyWith(
                                color: Colors.black,
                              ))
                        ]),
                  ),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BanGiamHieu()));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    height: deviceHeight * 0.1,
                    width: deviceWidth * 0.8,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ignore: prefer_const_constructors
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(ImgAssets.administrators),
                          ),
                          Text('Ban giám hiệu',
                              style: AppTextStyles.h2.copyWith(
                                color: Colors.black,
                              ))
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
