import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/modules/map/widget/common_used/text_item.dart';
import 'package:student_app/service/size_screen.dart';

class IconTextIconButton extends StatelessWidget {
  final Icon icon;
  final String text;
  final Icon iconTrailing;
  VoidCallback onTap;
  IconTextIconButton({
    Key? key,
    this.icon = const Icon(
      Icons.signal_cellular_connected_no_internet_4_bar_outlined,
    ),
    this.text = '',
    this.iconTrailing = const Icon(Icons.abc),
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeScreen.sizeSpace),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          border: Border(
            bottom: BorderSide(
              color: AppColors.greyBlur,
              width: 1,
            ),
          ),
        ),
        child: ListTile(
          title: IconText(
            isPadding: false,
            icon: icon,
            text: text,
            isBorder: false,
          ),
          trailing: iconTrailing,
        ),
      ),
    );
  }
}
