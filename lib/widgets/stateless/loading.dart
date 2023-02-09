import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:student_app/service/size_screen.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  static const spinkit = SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backGround,
      child: Center(
        child: SpinKitDualRing(
          color: AppColors.mainColor,
          lineWidth: SizeScreen.sizeSpace,
          size: SizeScreen.sizeIcon * 2,
        ),
      ),
    );
  }
}
