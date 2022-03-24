import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  MyButton({this.name, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
