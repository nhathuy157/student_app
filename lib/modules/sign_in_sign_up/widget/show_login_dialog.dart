import 'package:flutter/material.dart';
import 'package:student_app/config/routes/routes.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';

Future<void> showLoginDialog(
  BuildContext context,
  String text,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
         title:  Text('Thông báo', style: AppTextStyles.h3.copyWith(
           fontWeight: FontWeight.bold,
           color: AppColors.orangeryYellow
         )),
          content: Text(text),
          actions: [
            TextButton(
              style:  ButtonStyle(
               padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
               backgroundColor: MaterialStateProperty.all<Color>(AppColors.mainColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0)
            
          )
        )
               
              ),
              onPressed: (() {
                Navigator.of(context).pushNamedAndRemoveUntil(Routes.signInPage, (route) => false);
              }),
              child: const Text('Đăng Nhập'),
            )
          ],
        );
      });
}