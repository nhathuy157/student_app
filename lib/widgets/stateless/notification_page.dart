// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:student_app/config/string/string_app.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/service/size_screen.dart';

import 'icon_button_back.dart';

enum ENotification { error, netWork }

class NotificationPage extends StatelessWidget {
  late String title;
  late String detail;
  late String imgAsset;
  bool icBack;
  ENotification notification;
  NotificationPage({
    Key? key,
    this.icBack = true,
    required this.notification,
  }) : super(key: key);
  initData() {
    switch (notification) {
      case ENotification.error:
        title = StringApp.error;
        detail = StringApp.encouragement;
        imgAsset = ImgAssets.error;
        break;
      case ENotification.netWork:
        title = StringApp.notConnect;
        detail = StringApp.pleaseTryAgain;
        imgAsset = ImgAssets.noInternet;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    initData();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(SizeScreen.sizeSpace / 2),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(imgAsset),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 1),
                      child: TextNotification(
                        title: title,
                        detail: detail,
                      ))
                ],
              ),
            ),
            icBack
                ? Positioned(
                    top: SizeScreen.sizeSpace,
                    left: SizeScreen.sizeSpace,
                    child: IconButtonBack(showDecoration: true))
                : Container(),
          ],
        ),
      ),
    );
  }
}

class TextNotification extends StatelessWidget {
  bool haveBorder;
  String title;
  String detail;
  TextNotification(
      {Key? key,
      this.haveBorder = false,
      required this.title,
      required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: haveBorder
          ? BoxDecoration(border: Border.all(color: Colors.red))
          : null,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    title,
                    style: AppTextStyles.h3,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  child: Text(
                    detail,
                    style: AppTextStyles.h5,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
