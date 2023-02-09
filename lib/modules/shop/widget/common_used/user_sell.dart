import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/service/size_screen.dart';
import 'package:student_app/widgets/stateless/icons_contact.dart';

class UserSell extends StatelessWidget {
  final String name;

  const UserSell({
    Key? key,
    required this.name,
  }) : super(key: key);

  Widget circleImageText() {
    List<String> nameLists = name.toUpperCase().trim().split(' ');
    String nameDisplay = nameLists.length > 1
        ? nameLists[nameLists.length - 2].substring(0, 1) +
            nameLists[nameLists.length - 1].substring(0, 1)
        : nameLists[nameLists.length - 1].substring(0, 1);
    return Padding(
      padding: EdgeInsets.only(right: SizeScreen.sizeSpace / 2),
      child: CircleAvatar(
        backgroundColor: AppColors.orangeryYellow,
        radius: SizeScreen.sizeBox - SizeScreen.sizeSpace / 2,
        child: AutoSizeText(
          nameDisplay,
          style: AppTextStyles.h4
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          maxLines: 1,
        ), //Text
      ),
    ); //CircleAvatar;
  }

  Widget nameDisplay() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(right: SizeScreen.sizeSpace),
        child: Text(
          name,
          textAlign: TextAlign.left,
          style: AppTextStyles.h4.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeScreen.sizeBox * 1.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: circleImageText(),
            flex: 36,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: nameDisplay(),
            flex: 128,
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 128,
            child: IconContacts(),
          ),
        ],
      ),
    );

  }
}
