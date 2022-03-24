import 'package:flutter/material.dart';

class HaveAccountOrNot extends StatelessWidget {
  final String title, subTitle;
  final VoidCallback onTap;
  HaveAccountOrNot({this.onTap, this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            subTitle,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
