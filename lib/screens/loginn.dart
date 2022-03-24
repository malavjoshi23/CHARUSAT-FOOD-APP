import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/screens/homepage.dart';
import 'package:food_app/screens/signup.dart';
import 'package:food_app/widget/haveaccountornot.dart';
import 'package:food_app/widget/mybutton.dart';
import 'package:food_app/widget/mypasswordtextformField.dart';
import 'package:food_app/widget/mytextformfield.dart';
import 'package:food_app/widget/toptitle.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  bool isLoading = false;
  UserCredential authResult;
  void submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomePage(),
        ),
      );
    } on PlatformException catch (e) {
      String message = "Please check internet connection";
      if (e.message != null) {
        message = e.message.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message.toString()),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      setState(() {
        isLoading = false;
      });
    }

    isLoading = false;
    setState(() {
      isLoading = false;
    });
  }

  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = new RegExp(p);

  void validation() {
    if (email.text.isEmpty && password.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Both Field are Empty")));
    }
    if (email.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email is empty")),
      );
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email is not valid")),
      );
    } else if (password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password is empty")),
      );
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password is too short")),
      );
    } else {
      submit();
    }
  }

  final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();

  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      backgroundColor: const Color(0xff122547),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            reverse: true,
            // padding: EdgeInsets.all(32),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
