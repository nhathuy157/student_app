
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/routes/routes.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/email_feild.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/show_error_dialog.dart';
import 'package:student_app/service/auth/auth_exceptions.dart';

import 'package:student_app/widgets/stateless/icon_button_back.dart';




class UserAccount extends StatefulWidget {
  const UserAccount({ Key? key }) : super(key: key);

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  final nameController = TextEditingController();
   final emailController = TextEditingController();
   final phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser;
 
    @override
    void dispose() {
    nameController.dispose();
    
    emailController.dispose();
    super.dispose();
  }
    return Scaffold(
       appBar: AppBar(
        backgroundColor: AppColors.lightGreen,
       
        title: const Text('Tài khoản của tôi', style: AppTextStyles.h2),
        leading: GestureDetector(
          child: IconButtonBack(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Tên đăng nhập', style: AppTextStyles.h4)),
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                     alignment: Alignment.centerLeft,
                      width: deviceWidth *0.8,
                      height: deviceHeight *0.08,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all( Radius.circular(10)),
                        border: Border.all(width: 1, color: AppColors.mainColor),
                      ),
                      child: Text('${user?.displayName}', style: AppTextStyles.h4)
                    )
                  )
                ],
              ),
       
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Email', style: AppTextStyles.h4)),
 Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                     alignment: Alignment.centerLeft,
                      width: deviceWidth *0.8,
                      height: deviceHeight *0.08,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all( Radius.circular(10)),
                        border: Border.all(width: 1, color: AppColors.mainColor),
                      ),
                      child: Text('${user?.email}', style: AppTextStyles.h4)
                    )
                  )
                
                ],),

               Container(
                 padding:  const EdgeInsets.symmetric(horizontal: 20),
                 decoration:  BoxDecoration(
                    borderRadius: const BorderRadius.all( Radius.circular(10)),
                        border: Border.all(width: 1, color: AppColors.mainColor),
                 ),
                 width: deviceWidth*0.8,
                 height: deviceHeight *0.3,
                 child: Column(
                   children: [
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 8.0),
                       child: Text("Thông tin liên hệ", style: AppTextStyles.h3.copyWith(
                         fontWeight: FontWeight.bold
                       )),
                     ),
                     Column(
                       children: [
                          Container(
                            padding: const EdgeInsets.only( top:12),
                    alignment: Alignment.centerLeft,
                    child: const Text('Số điện thoại', style: AppTextStyles.h4)),
 Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                     alignment: Alignment.centerLeft,
                      width: deviceWidth *0.7,
                      height: deviceHeight *0.07,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all( Radius.circular(10)),
                        border: Border.all(width: 1, color: Colors.black),
                      ),
                      child: const Text('', style: AppTextStyles.h4)
                    )
                  ),
                       
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                      Row(children: [
                        Image.asset(ImgAssets.imgMess, width: deviceWidth*0.1),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Messenger', style: AppTextStyles.h4),
                        )
                      ],),
                     Row(
                       children: [
                         Image.asset(ImgAssets.icZalo,  width: deviceWidth*0.1),
                         const Padding(
                           padding: EdgeInsets.all(8.0),
                           child: Text('Zalo', style: AppTextStyles.h4),
                         )
                       ],
                     )
                       ],)
                       ],
                     )
                     
                   ],
                 ),
               ),
 
                  
                 
                // SizedBox(
                //   width: deviceWidth*0.6,
                //   height: deviceHeight*0.08,
                  
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //                       primary: AppColors.mainColor,
                //                       shape: RoundedRectangleBorder(
                //                           borderRadius:
                //                               BorderRadius.circular(16))),
                //     onPressed: () async {  
                //       final name = nameController.text.trim();
                //       final email = emailController.text.trim();
                //       final phoneNumber = phoneNumberController.text.trim();
                //       try{

                //         await user?.updateDisplayName(name);
                //         await user?.updateEmail(email);
                //         await user?.linkWithPhoneNumber(phoneNumber);
                //         Navigator.pushNamedAndRemoveUntil(context, Routes.userSettingRoute, (route) => false);
                //       }
                      
                //       on EmailAlreadyInUseAuthException {
                //         await showErrorDialog(
                //                         context,
                //                         'Email đã được sử dụng',
                //                       );
                //       };
                      
                      
                //     },
                    
                //     child: Text("Thay đổi",
                //     style: AppTextStyles.h3.copyWith(
                //       color: Colors.white
                //     )
                //     ),
                //   ),
                // ),
                               
                              
                 Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  )
            ],

          ),
        ),
      ),

    );
  }
}