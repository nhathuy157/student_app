import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:student_app/config/routes/routes.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/info_account/screen/info_user.dart';
import 'package:student_app/modules/info_account/screen/user_account.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/forget_pass.dart';
import 'package:student_app/service/auth/auth_service.dart';
import 'package:student_app/widgets/stateless/icon_button_back.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({Key? key}) : super(key: key);

 @override



  @override
  State<UserSetting> createState() => _UserSettingState();


}

class _UserSettingState extends State<UserSetting> {

 

  @override
  Widget build(BuildContext context) {
     
    

     final user = FirebaseAuth.instance.currentUser;
   
String? username = user?.displayName;
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: Colors.white,
       
         title: const Text('Thông tin tài khoản', style: AppTextStyles.h2),
          leading: GestureDetector(
          child: IconButtonBack(),
        ),
      ),

      body: Column(

        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Center(
                 child: Container(
                padding: const EdgeInsets.only(bottom:100),
                   
                      width: deviceWidth*0.2,
                      height: deviceHeight*0.2,
                      child: const Text(''),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        
                          shape: BoxShape.circle,
                          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                    
                 )),
               ),
               
               Container(
                  child: Text(username.toString(), style: AppTextStyles.h3.copyWith(
                         fontWeight: FontWeight.bold
                       )),
               )
               
              ]
            ),
          ),
            Container(
               padding: const EdgeInsets.all( 20),
              
               width: double.infinity,
               color: Colors.white,
              child: Column(
              
                children: [
                  
                   Padding(
                     padding: const EdgeInsets.only(bottom: 20),
                     child: Container(
                       alignment: Alignment.centerLeft,
                       child: Text('Cài đặt tài khoản', style: AppTextStyles.h3.copyWith(
                         fontWeight: FontWeight.bold
                       )),

                  ),
                   ),
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: GestureDetector(
                      onTap: (){
                        
                      Navigator.pushNamed(context, Routes.userAccount);
                          
                      
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(Icons.account_circle),
                            ),
                             Container(
                              child: const Text('Tài khoản của tôi', style: AppTextStyles.h3),
                            )
                            
                          ],
                        )
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: GestureDetector(
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const InfoUser()));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(Icons.person_search_rounded),
                            ),
                             Container(
                              child: const Text('Thông tin cá nhân', style: AppTextStyles.h3),
                            )
                            
                          ],
                        )
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: GestureDetector(
                      onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgetPassword()));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(Icons.change_circle_sharp),
                            ),
                             Container(
                              child: const Text('Đổi mật khẩu', style: AppTextStyles.h3),
                            )
                            
                          ],
                        )
                      ),
                    ),
                    
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical:8),
                    child: GestureDetector(
                      onTap: () async {
                        final shouldLogout= await showLogOutDialog(context);
                        if(shouldLogout){
                          await AuthService.firebase().logOUt();
                          Navigator.pushNamedAndRemoveUntil(context, Routes.signInPage, (route) => false);
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 2, color: Colors.black)
                          )
                        ),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            // ignore: prefer_const_constructors
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const Icon(Icons.logout_sharp),
                            ),
                             Padding(
                               padding: const EdgeInsets.only(top: 8),
                               child: Container(
                                child: const Text('Đăng xuất', style: AppTextStyles.h3),
                            ),
                             )
                            
                          ],
                        )
                      ),
                    ),
                  )

                ],
              ),
            )
        ],

      )
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Bạn có chắc muốn đăng xuất ?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Hủy')),
            TextButton(
              
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child:   const Text('Đăng xuất')),
                
          ],
        );
      }).then((value) => value ?? false);
}