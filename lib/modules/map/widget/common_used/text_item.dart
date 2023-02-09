import 'package:auto_size_text/auto_size_text.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:student_app/service/size_screen.dart';

class IconText extends StatelessWidget {
  Icon? icon;
  String text;
  String? text2;
  String? text3;
  bool isBorder;
  bool isSizedBoxBeforeText;
  bool isPadding;
  Widget extraWidget;
  TextStyle style;

  IconText({
    this.icon,
    required this.text,
    this.text2 = '',
    this.text3 = '',
    this.style = AppTextStyles.h3,
    this.extraWidget = const SizedBox(),
    this.isBorder = true,
    this.isSizedBoxBeforeText = true,
    this.isPadding = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeScreen.sizeWidthScreen,
      padding: isPadding
          ? EdgeInsets.symmetric(
              horizontal: SizeScreen.sizeSpace * 3,
              vertical: SizeScreen.sizeSpace * 2)
          : null,
      decoration: isBorder
          ? const BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border(
                  bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              )))
          : null,
      child: Row(
        children: [
          icon ?? const SizedBox(),
          isSizedBoxBeforeText
              ? SizedBox(
                  width: SizeScreen.sizeBox,
                )
              : const SizedBox(),
          Flexible(
            child: AutoSizeText(
              "$text $text2 $text3",
              style: style,
              maxLines: 2,
            ),
          ),
          extraWidget,
        ],
      ),
    );
  }
}
