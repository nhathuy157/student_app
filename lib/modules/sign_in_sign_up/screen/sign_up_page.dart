// ignore_for_file: prefer_const_constructors

/* cSpell:disable */
/* spell-checker: disable */
/* spellchecker: disable */
/* cspell: disable-line */
/* cspell: disable-next-line */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_app/config/routes/routes.dart';
import 'package:student_app/modules/home/screen/home_page.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/show_error_dialog.dart';
import 'package:student_app/service/auth/auth_exceptions.dart';
import 'package:student_app/service/auth/auth_service.dart';
import 'package:student_app/service/auth/auth_user.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';
import '../../../constants/assets_part.dart';
import '../../../widgets/stateless/id_developing.dart';
import '../widget/email_feild.dart';

// ignore: must_be_immutable
class SignUpPage extends StatefulWidget {

 
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  var _isVisible = false;
  final emailController = TextEditingController();
  final passwordsController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  @override
  void dispose() {
    usernameController.dispose();
    passwordsController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
var user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      color: Colors.transparent,
                      height: deviceHeight * 0.26,
                      child: Image.asset(ImgAssets.logo)),
                  Container(
                      color: Colors.transparent,
                      height: deviceHeight * 0.1,
                      child: Image.asset(ImgAssets.signUp)),
                  Container(
                      height: deviceHeight * 0.48,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: LayoutBuilder(builder: (ctx, constraints) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                height: constraints.maxHeight * 0.2,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF0F0F0),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 1,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Center(
                                    child: TextField(
                                      controller: usernameController,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Username"),
                                    ),
                                  ),
                                )),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            Container(
                                height: constraints.maxHeight * 0.2,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF0F0F0),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 1,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Form(
                                    key: formKey,
                                    child: Center(
                                      child: EmailFieldWidget(
                                          controller: emailController),
                                    ),
                                  ),
                                )),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            Container(
                                height: constraints.maxHeight * 0.2,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF0F0F0),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      blurRadius: 1,
                                      offset: const Offset(0, 3),
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Center(
                                    child: TextFormField(
                                      obscureText: _isVisible ? false : true,
                                      controller: passwordsController,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _isVisible = !_isVisible;
                                                });
                                              },
                                              icon: Icon(
                                                  _isVisible
                                                      ? Icons.visibility
                                                      : Icons.visibility_off,
                                                  color: Colors.grey)),
                                          border: InputBorder.none,
                                          hintText: "Password"),
                                    ),
                                  ),
                                )),
                            Container(
                                width: deviceWidth * 0.6,
                                height: constraints.maxHeight * 0.2,
                                margin: EdgeInsets.only(
                                    top: constraints.maxHeight * 0.06),
                                child: ElevatedButton(
                                  onPressed: () async {
                                   //  IsDeveloping.isLock();
                                    final username =
                                        usernameController.text.trim();
                                    final email = emailController.text.trim();
                                    final password =
                                        passwordsController.text.trim();
                                    try {
                                   await AuthService.firebase().createUser(
                                        username: username,
                                        email: email,
                                        password: password,
                                   );
                                     
                                      await AuthService.firebase()
                                          .sendEmailVerification();
                                   
                                  
                                      await user?.reload();
                                      user = FirebaseAuth.instance.currentUser;
                                       user?.updateDisplayName(username);
                                    
                                    
                                     
                                      Navigator.of(context)
                                          .pushNamed(Routes.verifyEmailRoute);
                                    } on EmailAlreadyInUseAuthException {
                                      await showErrorDialog(
                                        context,
                                        'Email đã được sử dụng',
                                      );
                                    } on WeakPasswordAuthException {
                                      await showErrorDialog(
                                        context,
                                        'Mật khẩu yếu',
                                      );
                                    } on InvalidEmailUseAuthException {
                                      await showErrorDialog(
                                        context,
                                        'Email không hợp lệ',
                                      );
                                    } on GenericAuthException {
                                      await showErrorDialog(
                                        context,
                                        'Lỗi xác thực',
                                      );
                                    }
                                  },
                                  child: Text("Sign Up",
                                      style: AppTextStyles.h3.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColors.mainColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16))),
                                )),
                            SizedBox(height: constraints.maxHeight * 0.02),
                            RichText(
                                text: TextSpan(
                                    text: 'Already have an account ? ',
                                    style: AppTextStyles.h4
                                        .copyWith(color: Colors.black),
                                    children: [
                                  TextSpan(
                                    text: ' Sign in',
                                    style: AppTextStyles.h4
                                        .copyWith(color: AppColors.mainColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          Routes.signInPage,
                                          (route) => false,
                                        );
                                      },
                                  )
                                ]))
                          ],
                        );
                      })),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  )
                ]),
          ),
        ));
  }
}

