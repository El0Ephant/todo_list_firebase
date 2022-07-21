import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:another_flushbar/flushbar.dart';

import 'package:todo_list/pages/sign_up_page.dart';
import 'package:todo_list/pages/home_page.dart';

import 'package:todo_list/todo_theme.dart';
import 'package:todo_list/widgets/auth/sign_in_fields.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  String? login;
  String? password;

  _setLogin(String val) => login = val;
  _setPassword(String val) => password = val;

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.bodyText1;
    final style = Theme.of(context).textTheme.bodyText2;

    return Scaffold(
      backgroundColor: TodoTheme.backColor,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(height: 7.h,),
            Text("Вход", style: headerStyle),

            SignInFields(setLogin: _setLogin, setPassword: _setPassword,),

            SizedBox(height: 3.h,),
            ElevatedButton(onPressed: ()=>_signIn(context), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(TodoTheme.backColor), elevation: MaterialStateProperty.all(10.0)), child: const Text("Войти"),),
            SizedBox(height: 3.h,),
            Text("Нет аккаунта?", style: headerStyle),
            TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));}, child: Text("Зарегистрироваться", style: style!.copyWith(color: TodoTheme.mainColor)),),
          ],
        ),
      ),
    );
  }

  Future<void> _signIn(BuildContext context) async {
    try {
      if (login != null && password != null) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: login!, password: password!);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
      }
    }
    on FirebaseAuthException catch (e) {
      await Flushbar(
        message: e.message,
        duration: const Duration(seconds: 4),
        backgroundColor: TodoTheme.extremeColor,
      ).show(context);
    }
  }
}