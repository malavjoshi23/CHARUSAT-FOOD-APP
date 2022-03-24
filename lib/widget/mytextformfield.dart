import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  MyTextFormField({this.title, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      //obscureText: true,
      decoration: InputDecoration(
        fillColor: const Color(0xfff5d8e4),
        filled: true,
        hintText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
