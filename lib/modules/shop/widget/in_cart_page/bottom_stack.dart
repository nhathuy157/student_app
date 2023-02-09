import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/string/string_app.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/controller/cart_controller.dart';
import 'package:student_app/controller/utility.dart';
import 'package:student_app/service/size_screen.dart';

class BottomStack extends StatefulWidget {
  double totalMoney = 0;
  BottomStack({Key? key, required this.totalMoney}) : super(key: key);

  @override
  State<BottomStack> createState() => _BottomStackState();
}

class _BottomStackState extends State<BottomStack> {
  @override
  Widget build(BuildContext context) {
    CartController().caculateTotalMoney();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeScreen.sizeSpace),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: AutoSizeText(
              'Tổng cộng',
              style: AppTextStyles.h3.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: AutoSizeText(
              priceToVND(widget.totalMoney),
              style: AppTextStyles.h3.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.redPrice,
              ),
              maxLines: 1,
            ),
          ),
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: ElevatedButton(
                clipBehavior: Clip.none,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  StringApp.buy,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ))
        ],
      ),
    );
  }
}
