

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/routes/routes.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/sign_in_sign_up/screen/sign_in_page.dart';


import 'package:student_app/service/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final auth = FirebaseAuth.instance;
  late User user ;
  late Timer timer;
  void initState(){
user = auth.currentUser!;
user.sendEmailVerification();
timer=  Timer.periodic(Duration(seconds: 3), (timer) {

  checkEmailVerified();
 });

    super.initState();
  }

  
  @override

  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context)  {
final deviceWidth = MediaQuery.of(context).size.width;
final deviceHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email'),
      backgroundColor: AppColors.mainColor,
      ),
      body: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
 Center(
         child:Container(
           padding: const EdgeInsets.only(left: 15),
          width: double.infinity,
        alignment: Alignment.center,
         child: Text('An email has been sent to ${user.email} please verify', style: AppTextStyles.h3,),
         )
         
       ),
       SizedBox( height:  deviceHeight*0.02,)
       ,
        SizedBox(
          width: deviceWidth*0.6,
          child: ElevatedButton.icon(
           
                onPressed: () {

                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.signInPage, (route) => false);
                 } , icon:Icon(Icons.arrow_back) , 
                
               label: Text("Return sign in",
              style: AppTextStyles.h3.copyWith(color:Colors.white )),
              style: ElevatedButton.styleFrom(
              
                minimumSize: Size.fromHeight(50),
                primary: AppColors.mainColor
              ),
              ),
        )
        ]
      )
      
        
    );

  }
  Future<void> checkEmailVerified() async{
    user = auth.currentUser!;
    await user.reload();
    if(user.emailVerified){
      timer.cancel();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.signInPage, (route) => false);
    }
  }
}
