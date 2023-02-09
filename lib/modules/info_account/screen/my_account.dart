import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/routes/routes.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/show_error_dialog.dart';
import 'package:student_app/service/auth/auth_exceptions.dart';
import 'package:student_app/service/auth/auth_service.dart';
import 'package:student_app/widgets/stateless/icon_button_back.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({ Key? key }) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
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
                    child: TextField(
                     controller:  nameController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                    hintText: user?.displayName
                      ),
                    ),
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
                    child: TextField(
                     controller:  emailController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                    hintText: user?.email,
                      ),
                    ),
                  )
                
                ],),

                Column(
                  children: [
                    Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Số điện thoại', style: AppTextStyles.h4)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: TextField(
                        controller:  phoneNumberController,
                        decoration:  InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: user?.phoneNumber,
                        )
                      ),
                    )
                  ],
                ),
  Column(
                  children: [
                    Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Zalo', style: AppTextStyles.h4)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: TextField(
                        controller:  phoneNumberController,
                        decoration:  InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: user?.phoneNumber,
                        )
                      ),
                    )
                  ],
                ),
                  Column(
                  children: [
                    Container(
                    alignment: Alignment.centerLeft,
                    child: const Text('Messenger', style: AppTextStyles.h4)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: TextField(
                        controller:  phoneNumberController,
                        decoration:  InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: user?.phoneNumber,
                        )
                      ),
                    )
                  ],
                ),
                 
                SizedBox(
                  width: deviceWidth*0.6,
                  height: deviceHeight*0.08,
                  
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                                      primary: AppColors.mainColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                    onPressed: () async {  
                      final name = nameController.text.trim();
                      final email = emailController.text.trim();
                      final phoneNumber = phoneNumberController.text.trim();
                      try{

                        await user?.updateDisplayName(name);
                        await user?.updateEmail(email);
                        await user?.linkWithPhoneNumber(phoneNumber);
                        Navigator.pushNamedAndRemoveUntil(context, Routes.userSettingRoute, (route) => false);
                      }
                      
                      on EmailAlreadyInUseAuthException {
                        await showErrorDialog(
                                        context,
                                        'Email đã được sử dụng',
                                      );
                      };
                      
                      
                    },
                    
                    child: Text("Thay đổi",
                    style: AppTextStyles.h3.copyWith(
                      color: Colors.white
                    )
                    ),
                  ),
                ),
                               
                              
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