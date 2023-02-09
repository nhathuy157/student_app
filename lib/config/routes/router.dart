// ignore_for_file: no_duplicate_case_values

import 'package:flutter/material.dart';
import 'package:student_app/modules/admin/screen/add_hotel.dart';
import 'package:student_app/modules/admin/screen/add_job.dart';
import 'package:student_app/modules/home/screen/home_page.dart';
import 'package:student_app/modules/info_account/screen/info_user.dart';
import 'package:student_app/modules/info_account/screen/user_account.dart';
import 'package:student_app/modules/info_account/screen/user_setting.dart';

import 'package:student_app/modules/info_school/screen/info_school_page.dart';
import 'package:student_app/modules/job/screen/job_result_page.dart';
import 'package:student_app/modules/map/screen/body_sheet.dart';
import 'package:student_app/modules/map/screen/description_page.dart';
import 'package:student_app/modules/map/screen/information_page.dart';
import 'package:student_app/modules/map/screen/overview_page.dart';
import 'package:student_app/modules/map/screen/photos_page.dart';

import 'package:student_app/modules/sign_in_sign_up/screen/sign_in_page.dart';

import 'package:student_app/modules/sign_in_sign_up/screen/sign_up_page.dart';
import 'package:student_app/modules/sign_in_sign_up/screen/verify_email_view.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/note_view.dart';

import 'package:student_app/widgets/stateless/notification_page.dart';
import 'package:student_app/widgets/stateless/no_result.dart';

import '../../constants/constant.dart';
import '../../modules/hotel/screen/ask_hotel_page.dart';
import '../../modules/hotel/screen/hotel_page.dart';
import '../../modules/job/screen/job_details_page.dart';
import '../../modules/job/screen/job_page.dart';
import '../../modules/map/screen/map_page.dart';

import '../../modules/shop/screen/shopping_page.dart';
import '../../modules/shop/screen/show_post_detail_page.dart';
import '../../modules/test_screen/shop_test.dart';
import '../../modules/test_screen/test_file.dart';
import '../../modules/welcome/screen/welcome_page.dart';
import '../../test_screen.dart';

class Routers {
  static Route<dynamic>? generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'TestScreen':
        {
          if (TEST) {
            return MaterialPageRoute(builder: (_) => TestScreen());
          }
          return MaterialPageRoute(
              builder: (_) => Scaffold(
                    body: Center(
                      child: Text('No router defined for ${settings.name}'),
                    ),
                  ));
        }
      case 'ShopTestPage':
        {
          return MaterialPageRoute(builder: (_) => const ShopTestPage());
        }
      case 'TestFilePage':
        {
          return MaterialPageRoute(builder: (_) => const TestFilePage());
        }

      /// router shopping
      case 'ShoppingPage':
        {
          return MaterialPageRoute(builder: (_) => ShoppingPage());
        }
      case 'ShowPostDetailPage':
        {
          return MaterialPageRoute(
              builder: (_) => const ShowPostDetailPage(
                    idPost: "",
                  ));
        }

      /// router home
      case 'WelcomePage':
        {
          return MaterialPageRoute(builder: (_) => const WelcomePage());
        }

      /// router job
      case 'JobPage':
        {
          return MaterialPageRoute(builder: (_) => const JobPage());
        }
      case 'JobResultPage':
        {
          return MaterialPageRoute(builder: (_) => JobResultPage());
        }
      // case 'JobDetailsPage':
      //   {
      //     return MaterialPageRoute(builder: (_) => JobDetailsPage());
      //   }

      /// router map
      case 'MapPage':
        {
          return MaterialPageRoute(builder: (_) => const MapPage());
        }
      case 'information':
        {
          return MaterialPageRoute(builder: (_) => const InformationPage());
        }
      case 'body-sheet':
        {
          return MaterialPageRoute(builder: (_) => BodySheet());
        }
      case 'overview':
        {
          return MaterialPageRoute(builder: (_) => const OverViewPage());
        }

      case 'photo':
        {
          return MaterialPageRoute(builder: (_) => const PhotosViewPage());
        }
      case 'description':
        {
          return MaterialPageRoute(builder: (_) => const DescriptionPage());
        }

      ///Router hotel
      case 'AskHotelPage':
        {
          return MaterialPageRoute(builder: (_) => const AskHotelPage());
        }
      case 'HotelPage':
        {
          return MaterialPageRoute(builder: (_) => HotelPage());
        }
      case 'InfoSchoolPage':
        {
          return MaterialPageRoute(builder: (_) => const InfoSchoolPage());
        }

      case 'SignInPage':
        {
          return MaterialPageRoute(builder: (_) => const SignInPage());
        }
      case 'HomePage':
        {
          return MaterialPageRoute(builder: (_) => const HomePage());
        }
      case 'NoteView':
        {
          return MaterialPageRoute(builder: (_) => const NotesView());
        }
      case 'SignUpPage':
        {
          return MaterialPageRoute(builder: (_) => SignUpPage());
        }
      case 'VerifyEmail':
        {
          return MaterialPageRoute(builder: (_) => const VerifyEmailView());
        }
      case 'UserSetting':
        {
          return MaterialPageRoute(builder: (_) => const UserSetting());
        }
      case 'InfoUser':
        {
          return MaterialPageRoute(builder: (_) => const InfoUser());
        }
      case 'UserSetting':
        return MaterialPageRoute(builder: (_) => const UserSetting());

      case 'Error':
        {
          return MaterialPageRoute(
              builder: (_) => NotificationPage(
                    notification: ENotification.error,
                  ));
        }
      case 'NoResult':
        {
          return MaterialPageRoute(builder: (_) => const NoResult());
        }
      case 'AddJob':
        {
          return MaterialPageRoute(builder: (_) => const AddJobPage());
        }
      case 'AddHotel':
        {
          return MaterialPageRoute(builder: (_) => const AddHotelPage());
        }

      case 'UserAccount':
        return MaterialPageRoute(builder: (_) => const UserAccount());
      // case 'HotelDetail':
      //   {
      //     return MaterialPageRoute(builder: (_) => const HotelDetailsPage());
      //   }
    }
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text('No router defined for ${settings.name}'),
              ),
            ));
  }
}
