import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/service/size_screen.dart';

import '../../config/string/string_app.dart';
import '../../config/themes/app_text_styles.dart';

class NoResult extends StatelessWidget {
  const NoResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            child: Text(
              StringApp.noFoundResult,
              style: AppTextStyles.h1.copyWith(fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Image(
                image: AssetImage('assets/images/ic_no_result.png'),
                width: 240,
                height: 240),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            child: Text(
              StringApp.weCantFind,
              style: AppTextStyles.h4,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
