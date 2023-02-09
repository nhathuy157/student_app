import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/enums/menu_actions.dart';

import 'package:student_app/config/routes/routes.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/show_error_dialog.dart';
import 'package:student_app/modules/sign_in_sign_up/widget/show_login_dialog.dart';
import 'package:student_app/service/auth/auth_service.dart';
class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  
 
 @override
  void initState() {
   super.initState();
   
FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
  if (user == null) {
    showLoginDialog(context, 'Bạn cần đăng nhập để thực hiện chức năng này.');
  } else {
    print('User is signed in!');
  }
 });
   }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: const Text('Test Login'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: ((value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  await AuthService.firebase().logOUt();
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routes.signInPage, (_) => false);
                }
            }
          }), itemBuilder: ((context) {
            return [
              const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, child: Text('Log out'))
            ];
          })),
        ],
      ),
      body: const Center(child: Text('Hello world')),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Log out'))
          ],
        );
      }).then((value) => value ?? false);
}