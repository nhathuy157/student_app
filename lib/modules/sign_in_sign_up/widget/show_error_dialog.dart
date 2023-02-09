import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Text('Thông báo', style: AppTextStyles.h3.copyWith(
            color: AppColors.orangeryYellow,
          )),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: const Text('OK', style: TextStyle(color: AppColors.mainColor)),
            )
          ],
        );
      });
}