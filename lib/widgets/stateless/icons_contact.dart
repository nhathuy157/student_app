import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/service/size_screen.dart';

class IconContacts extends StatelessWidget {
  bool isZalo;
  bool isMess;
  bool isGmail;
  bool isPhone;
  bool isOther;
  double sizeIcon = SizeScreen.sizeIcon;
  double sizeIconImage = SizeScreen.sizeBox;
  double sizeSpace = SizeScreen.sizeSpace;
  IconContacts(
      {Key? key,
      this.isZalo = true,
      this.isPhone = true,
      this.isMess = true,
      this.isGmail = true,
      this.isOther = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () {
              print('hello bugs');
            },
            child: Image.asset(
              ImgAssets.icZalo,
              width: sizeIcon,
              height: sizeIcon,
            ),
          ),
          flex: 1,
        ),
        SizedBox(
          width: sizeSpace,
        ),
        Flexible(
          child: GestureDetector(
            child: Image.asset(
              ImgAssets.icMess,
              width: sizeIcon,
              height: sizeIcon,
            ),
          ),
          flex: 1,
        ),
        SizedBox(
          width: sizeSpace,
        ),
        Flexible(
          child: isGmail
              ? GestureDetector(
                  child: Image.asset(
                    ImgAssets.icGmail,
                    width: sizeIcon,
                    height: sizeIcon,
                  ),
                )
              : const SizedBox(),
          flex: 1,
        ),
        isGmail
            ? SizedBox(
                width: sizeSpace,
              )
            : const SizedBox(),
        Flexible(
          child: isPhone
              ? GestureDetector(
                  child: Icon(
                    Icons.phone,
                    size: sizeIcon,
                    color: AppColors.mainColor,
                  ),
                )
              : const SizedBox(),
          flex: 1,
        ),
        isPhone
            ? SizedBox(
                width: sizeSpace,
              )
            : const SizedBox(),
        Flexible(
          child: isOther
              ? GestureDetector(
                  child: Icon(
                    Icons.more_horiz_outlined,
                    color: AppColors.mainColor,
                    size: sizeIcon,
                  ),
                )
              : const SizedBox(),
          flex: 1,
        ),
      ],
    );
  }
}
