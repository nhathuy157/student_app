import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/routes/routes.dart';
import 'package:student_app/constants/assets_part.dart';
import 'package:student_app/modules/sign_in_sign_up/screen/sign_up_page.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/email_feild.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/forget_pass.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/show_error_dialog.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/utils.dart';
import 'package:student_app/service/auth/auth_exceptions.dart';
import 'package:student_app/service/auth/auth_provider.dart';
import 'package:student_app/service/auth/auth_service.dart';
import 'package:student_app/widgets/stateless/id_developing.dart';

import '../../../config/themes/app_colors.dart';
import '../../../config/themes/app_text_styles.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final formKey = GlobalKey<FormState>();
  var _isVisible = false;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
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
                      height: deviceHeight * 0.3,
                      child: Image.asset(ImgAssets.logo)),
                  Container(
                      color: Colors.transparent,
                      height: deviceHeight * 0.1,
                      child: Image.asset(ImgAssets.title)),
                  Container(
                      height: deviceHeight * 0.4,
                      // color: Colors.red,
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
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Form(
                                    key: formKey,
                                    child: Center(
                                      child:
                                          EmailFieldWidget(controller: _email),
                                    ),
                                  ),
                                )),
                            SizedBox(height: constraints.maxHeight * 0.018),
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
                                    child: TextField(
                                      controller: _password,
                                      obscureText: _isVisible ? false : true,
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
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ForgetPassword()));
                                      },
                                      child: Text("Forgot Password",
                                          style: AppTextStyles.h4.copyWith(
                                            color: Colors.black,
                                          )))
                                ]),
                            Container(
                                width: deviceWidth * 0.6,
                                height: constraints.maxHeight * 0.2,
                                margin: EdgeInsets.only(
                                    top: constraints.maxHeight * 0.06),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    //     IsDeveloping.isLock();
                                    final email = _email.text.trim();
                                    final password = _password.text.trim();
                                    try {
                                      await AuthService.firebase().login(
                                        email: email,
                                        password: password,
                                      );
                                      final user =
                                          AuthService.firebase().currentUser;
                                      if (user!.isEmailVerified) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          Routes.homePage,
                                          (route) => false,
                                        );
                                      } else {
                                        //user's email is NOT verified
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                          Routes.verifyEmailRoute,
                                          (route) => false,
                                        );
                                      }
                                    } on UserNotFoundAuthException {
                                      await showErrorDialog(
                                        context,
                                        'Người dùng không tồn tại',
                                      );
                                    } on WrongPasswordAuthException {
                                      await showErrorDialog(
                                        context,
                                        'Sai mật khẩu',
                                      );
                                    } on GestureRecognizer {
                                      await showErrorDialog(
                                        context,
                                        'Lỗi xác thực',
                                      );
                                    }
                                  },
                                  child: Text("Sign In",
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
                                    text: 'Don\'t have an Account!',
                                    style: AppTextStyles.h4
                                        .copyWith(color: Colors.black),
                                    children: [
                                  TextSpan(
                                    text: ' Sign up',
                                    style: AppTextStyles.h4
                                        .copyWith(color: AppColors.mainColor),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpPage()),
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
