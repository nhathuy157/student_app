/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'package:flutter/material.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/widgets/stateless/icon_button_back.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../widget/option1_page.dart';
import '../widget/option3_page.dart';

class InfoSchoolPage extends StatelessWidget {
  const InfoSchoolPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.lightGreen,
      appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
        elevation: 0,
        title: const Text('Thông tin trường', style: AppTextStyles.h2),
        leading: GestureDetector(
          child: IconButtonBack(),
        ),
      ),

      //      iconTheme: const IconThemeData(
      //      color: AppColors.mainColor,

      //      //change your color here
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Option1Page()),
                );
              },
              child: Container(
                width: deviceWidth *0.90,
                height: deviceHeight*0.14,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(ImgAssets.target),
                  ),
                  Expanded(
                    child: Text("Tầm nhìn, sứ mệnh và giá trị cốt lõi",
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Image.asset(ImgAssets.rightRow)
                ]),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    border: Border(
                      top: BorderSide(width: 1, color: AppColors.mainColor),
                      right: BorderSide(width: 1, color: AppColors.mainColor),
                      bottom: BorderSide(width: 1, color: AppColors.mainColor),
                      left: BorderSide(width: 1, color: AppColors.mainColor),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 24),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: deviceWidth *0.90,
                height: deviceHeight*0.14,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(ImgAssets.history),
                  ),
                  Expanded(
                    child: Text("Lịch sử hình thành và phát triển",
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Image.asset(ImgAssets.rightRow)
                ]),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    border: Border(
                      top: BorderSide(width: 1, color: AppColors.mainColor),
                      right: BorderSide(width: 1, color: AppColors.mainColor),
                      bottom: BorderSide(width: 1, color: AppColors.mainColor),
                      left: BorderSide(width: 1, color: AppColors.mainColor),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 24),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Option3Page()),
                );
              },
              child: Container(
                width: deviceWidth *0.90,
                height: deviceHeight*0.14,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(ImgAssets.organization),
                  ),
                  Expanded(
                    child: Text("Cơ cấu tổ chức",
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Image.asset(ImgAssets.rightRow)
                ]),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    border: Border(
                      top: BorderSide(width: 1, color: AppColors.mainColor),
                      right: BorderSide(width: 1, color: AppColors.mainColor),
                      bottom: BorderSide(width: 1, color: AppColors.mainColor),
                      left: BorderSide(width: 1, color: AppColors.mainColor),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
