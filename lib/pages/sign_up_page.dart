import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:todo_list/widgets/auth/sign_up_fields.dart';
import 'package:todo_list/pages/sign_in_page.dart';
import 'package:todo_list/todo_theme.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  String? login;
  String? password;

  _setLogin(String val) => login = val;
  _setPassword(String val) => password = val;

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context).textTheme.bodyText1;
    final style = Theme.of(context).textTheme.bodyText2;

    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        backgroundColor: TodoTheme.backColor,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 7.h,),
              Text("Регистрация", style: headerStyle),

              SignUpFields(setLogin: _setLogin, setPassword: _setPassword),

              SizedBox(height: 3.h,),
              ElevatedButton(onPressed: (){_signUp(context);}, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(TodoTheme.backColor), elevation: MaterialStateProperty.all(10.0)), child: const Text("Зарегистрироваться"),),
              SizedBox(height: 3.h,),
              Text("Уже есть аккаунт?", style: headerStyle),
              TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));}, child: Text("Войти", style: style!.copyWith(color: TodoTheme.mainColor)),),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signUp(BuildContext context) async {
    try {
      if (login != null && password != null) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: login!, password: password!);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInPage()), (route) => false);
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
