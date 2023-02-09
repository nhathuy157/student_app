import 'package:flutter/material.dart';
import 'package:student_app/modules/admin/widget/textbox.dart';
import 'package:student_app/service/size_screen.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';

class TextBoxDescriptionWidget extends StatelessWidget {
  final String textAddJob;
  const TextBoxDescriptionWidget({Key? key, required this.textAddJob})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 2, bottom: 4),
            child: Text(
              textAddJob,
              style: AppTextStyles.h4.copyWith(
                  color: AppColors.orangeryYellow, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: SizeScreen.sizeWidthScreen * 2.5 / 10,
              width: SizeScreen.sizeWidthScreen,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.lightGreen, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 4),
                      blurRadius: 4)
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Heloo sdasadaaaaaaaawad sdaaaaaaaaa dwaddd sadddddddddd sadwad awdawd',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
