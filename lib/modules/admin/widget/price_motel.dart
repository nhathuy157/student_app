import 'package:flutter/material.dart';
import 'package:student_app/modules/admin/widget/dropdown_category_salary.dart';
import 'package:student_app/modules/admin/widget/dropdown_price_motel.dart';
import 'package:student_app/service/size_screen.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';

class TextBoxAndComboBoxMotel extends StatelessWidget {
  // final String textAddJob;
  const TextBoxAndComboBoxMotel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 2, bottom: 4),
                child: Text(
                  'Giá',
                  style: AppTextStyles.h4.copyWith(
                      color: AppColors.orangeryYellow,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 2, bottom: 4, left: 190),
                child: Text(
                  'Loại',
                  style: AppTextStyles.h4.copyWith(
                      color: AppColors.orangeryYellow,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: SizeScreen.sizeWidthScreen * 4.5 / 10,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 4)
                  ],
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.all(18.0),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: AppColors.lightGreen)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: AppColors.lightGreen))),
                  textAlign: TextAlign.start,
                  maxLines: 1,
                ),
              ),
              Container(
                child: Text(
                  '/',
                  style: AppTextStyles.h4.copyWith(
                      color: AppColors.orangeryYellow,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
              ),
              DropDownCategorySalaryMotel()
            ],
          )
        ],
      ),
    );
  }
}
