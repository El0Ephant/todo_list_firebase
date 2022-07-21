import 'package:flutter/material.dart';

class SignUpFields extends StatelessWidget {
  SignUpFields({super.key, required this.setLogin, required this.setPassword});

  final void Function(String s) setLogin;
  final void Function(String s) setPassword;

  String? password;

  void setFirstPassword(String? s) {
    password = s;
  }

  String? Function(String? s) _validator(RegExp regex, String message, Function(String s) update) {
    return (String? s) {
      if (s != null && regex.hasMatch(s)) {
        update(s);
        return null;
      }

      return message;

    };
  }

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyText2;

    return Column(
      children: [
        TextFormField(
          style: style,
          decoration: const InputDecoration(
            labelText: "Почта",
          ),
          validator: _validator(RegExp(r'^\w+@\w+\.\w+$'), 'Введите почту', setLogin),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),

        TextFormField(
          style: style,
          decoration: const InputDecoration(
            labelText: "Пароль",
          ),
          validator: _validator(RegExp(r'^(?=.*[A-Z])^(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$'), 'Введите пароль', setFirstPassword),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: true,
        ),

        TextFormField(
          style: style,
          decoration: const InputDecoration(
            labelText: "Повторите пароль",
          ),
          validator: (String? s){if (s != password) {return "Пароли не совпадают";} setPassword(password!); return null;},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: true,
        ),
      ],
    );
  }
}
