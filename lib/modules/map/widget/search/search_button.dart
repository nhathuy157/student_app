import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/map/widget/search/search_delegate.dart';
import 'package:student_app/service/size_screen.dart';
import 'dart:developer' as devtools show log;

class SearchBoxButton extends StatefulWidget {
  const SearchBoxButton({Key? key}) : super(key: key);

  @override
  State<SearchBoxButton> createState() => _SearchBoxButtonState();
}

class _SearchBoxButtonState extends State<SearchBoxButton> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    devtools.log('Sized box:' + SizeScreen.sizeBox.toString());
    devtools.log('Sized space:' + SizeScreen.sizeSpace.toString());
    return Container(
      height: SizeScreen.sizeBox + SizeScreen.sizeSpace / 2,
      width: double.maxFinite,
      margin: EdgeInsets.only(
          right: SizeScreen.sizeSpace * 1.5, left: SizeScreen.sizeSpace / 2),
      child: OutlinedButton(
        onPressed: () {
          showSearch(
            context: context,
            delegate: BuildingSearchDelegate(typeSearch: 1),
            useRootNavigator: false,
          );

          //  Navigator.of(context, rootNavigator: useRootNavigator).push(_SearchPageRoute<T>(
          //   delegate: delegate,
          // ));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0))),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Tìm kiếm tại đây",
            style: AppTextStyles.h4.copyWith(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
