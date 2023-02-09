import 'package:flutter/material.dart';
import 'package:student_app/config/themes/app_colors.dart';
final messengerKey = GlobalKey<ScaffoldMessengerState>();
class Utils{

static showSnackBar(String? text){
    if(text == null) {
      return;
    }
    final snackBar = SnackBar(content: Text(text), backgroundColor: AppColors.mainColor);
    messengerKey.currentState!
    ..removeCurrentSnackBar()
    ..showSnackBar(snackBar);
  }
}