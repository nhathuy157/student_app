import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/widgets/stateless/notification_page.dart';

import '../../config/string/string_app.dart';
import '../../service/size_screen.dart';
import 'icon_button_back.dart';

// ignore: must_be_immutable
class CatchErrorPage extends StatelessWidget {
  bool haveConnect;
  CatchErrorPage({Key? key, required this.haveConnect}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            haveConnect
                ? NotificationPage(
                  notification: ENotification.error,
                  )
                :  NotificationPage(
                  notification: ENotification.netWork,
                  ),
            Positioned(
                top: SizeScreen.sizeSpace,
                left: SizeScreen.sizeSpace,
                child: IconButtonBack(showDecoration: true)),
          ],
        ),
      ),
    );
  }
}
