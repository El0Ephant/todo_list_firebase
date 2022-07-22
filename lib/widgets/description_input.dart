import 'package:flutter/material.dart';


class DescriptionInput extends StatelessWidget {
  const DescriptionInput({super.key, required this.update, required this.initial});

  final Function update;
  final String initial;

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initial,
        style: Theme.of(context).textTheme.bodyText2,
        decoration: InputDecoration(
          hintStyle: Theme.of(context).textTheme.bodyText2,
          hintText: 'Описание',
        ),
        onChanged: (value){update(value);},
      ),
    );
  }
}
