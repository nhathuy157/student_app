import 'package:flutter/material.dart';

import '../../config/string/string_use.dart';
import '../../config/themes/app_colors.dart';
import '../../config/themes/app_text_styles.dart';
import '../../service/size_screen.dart';

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  double widthSearch = 0;
  double numberIcon;
  String string;
  final VoidCallback onTap;
  SearchWidget(
      {Key? key,
      required this.numberIcon,
      required this.onTap,
      this.string = StringUse.productNeed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    widthSearch = SizeScreen.sizeWidthScreen -
        (numberIcon * (SizeScreen.sizeBox + SizeScreen.sizeSpace * 2) +
            SizeScreen.sizeSpace * 2);
    return Container(
        margin: EdgeInsets.all(SizeScreen.sizeSpace),
        height: SizeScreen.sizeAppBar,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: widthSearch,
            padding: EdgeInsets.only(
                left: SizeScreen.sizeSpace / 2,
                right: SizeScreen.sizeSpace / 2),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: AppColors.mainColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeScreen.sizeBox * 1 / 9))),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(children: [
                const SizedBox(
                    height: 40,
                    width: 40,
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
                Text(string, style: AppTextStyles.h6),
              ]),
            ),
          ),
        ));
  }
}
