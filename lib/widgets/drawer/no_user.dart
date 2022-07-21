import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo_list/pages/sign_in_page.dart';
import 'package:todo_list/pages/sign_up_page.dart';

import 'package:todo_list/todo_theme.dart';
class NoUser extends StatelessWidget {
  const NoUser({super.key});

  @override
  Widget build(BuildContext context) {
    var headerStyle = Theme.of(context).textTheme.bodyText1!.copyWith(color: TodoTheme.mainColor);
    var style = Theme.of(context).textTheme.bodyText2;
    return Column(
      children: [
        SizedBox(height: 10.h),
        Text("Войдите в свой аккаунт:", style: headerStyle),
        SizedBox(height: 3.h),
        TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));}, child: Text("Авторизоваться", style: style)),
        SizedBox(height: 3.h),
        TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));}, child: Text("Зарегистрироваться", style: style)),

      ],
    );
  }

}