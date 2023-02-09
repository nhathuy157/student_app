// ignore_for_file: unused_import

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:student_app/constants/constant.dart';
import 'package:student_app/controller/job_fliter.dart';
import 'package:student_app/controller/product_post_controller.dart';
import 'package:student_app/model/other/search_model.dart';
import 'package:student_app/service/action/shop/product_action.dart';
import 'package:student_app/widgets/stateless/notification_page.dart';
import 'package:student_app/model/map/direction.dart';
import 'config/routes/router.dart';
import 'config/routes/routes.dart';
import 'config/string/string_app.dart';
import 'service/size_screen.dart';

// ignore: non_constant_identifier_names

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();

  if (USE_EMULATOR) {
    emulator();
  }
  if (TEST) {
    ErrorWidget.builder = (FlutterErrorDetails details) => TextNotification(
          title: StringApp.error,
          detail: StringApp.encouragement,
          haveBorder: true,
        );
  }
  runApp(const MyApp());
}

Future emulator() async {
  String host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
  FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
  FirebaseFirestore.instance.settings = Settings(
    host: "$host:8080",
    sslEnabled: false,
    persistenceEnabled: false,
  );
  await FirebaseStorage.instance.useStorageEmulator("localhost", 9199);
  await FirebaseAuth.instance.useAuthEmulator(host, 9099);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DirectionPolyline>(
          create: (_) => DirectionPolyline(),
        ),
        ChangeNotifierProvider(create: (context) => ProductPostController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringApp.nameApp,
        theme: ThemeData(
            // primaryColor: AppColors.lightGreen,
            // backgroundColor: AppColors.lightGreen,
            // scaffoldBackgroundColor: AppColors.lightGreen,
            // accentColor: AppColors.lightGreen,
            ),

        initialRoute: TEST ? Routes.testScreen : Routes.welcomePage,
        onGenerateRoute: Routers.generatedRoute,
        //    initialRoute: Routes.welcomePage,
        // onGenerateRoute: Routers.generatedRoute,
      ),
    );
  }
}
