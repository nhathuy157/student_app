import 'package:flutter/material.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';

class TextBoxWidget extends StatelessWidget {
  final String textAddJob;
  const TextBoxWidget({Key? key, required this.textAddJob}) : super(key: key);

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
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, offset: Offset(0, 4), blurRadius: 4)
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
          )
        ],
      ),
    );
  }
}
