import 'package:flutter/material.dart';
import 'package:student_app/service/size_screen.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';

class TextBoxSalary extends StatelessWidget {
  final String textSalaryJob;
  const TextBoxSalary({Key? key, required this.textSalaryJob})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 6, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: 70,
              padding: const EdgeInsets.only(right: 4, top: 2),
              child: Text(
                textSalaryJob,
                style: AppTextStyles.h5,
              )),
          Container(
            height: 40,
            width: SizeScreen.sizeWidthScreen * 6.8 / 10,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: TextFormField(
              scrollPadding: const EdgeInsets.only(bottom: 2),
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
        ],
      ),
    );
  }
}
