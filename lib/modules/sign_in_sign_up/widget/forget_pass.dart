// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/config/routes/routes.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/utils.dart';

import '../../../widgets/stateless/id_developing.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final deviceHeight = MediaQuery.of(context).size.height;
    // final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Reset Password',
              style: AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold)),
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back,
              color: AppColors.mainColor,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Text('Reset your password ',
                  style:
                      AppTextStyles.h3.copyWith(fontWeight: FontWeight.bold)),
            ),
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Please enter your email address',
                  style: AppTextStyles.h4.copyWith(),
                )),
            SizedBox(height: 20),
            TextFormField(
              controller: emailController,
              cursorColor: AppColors.mainColor,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                label: Text('Email',
                    style: TextStyle(color: Colors.black.withOpacity(0.5))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.mainColor, width: 2)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // IsDeveloping.isLock();
                resetPassword();
              },
              icon: Icon(Icons.email_outlined),
              label: Text("Reset Password",
                  style: AppTextStyles.h3.copyWith(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                  primary: AppColors.mainColor),
            )
          ]),
        ),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());

      Utils.showSnackBar('Password reset email sent');
    } on FirebaseException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
  }
}
