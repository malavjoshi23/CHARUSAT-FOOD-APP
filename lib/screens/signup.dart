import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/screens/homepage.dart';
import 'package:food_app/screens/loginn.dart';
import 'package:food_app/widget/gender.dart';
import 'package:food_app/widget/haveaccountornot.dart';
import 'package:food_app/widget/mybutton.dart';
import 'package:food_app/widget/mypasswordtextformField.dart';
import 'package:food_app/widget/mytextformfield.dart';
import 'package:food_app/widget/toptitle.dart';

class Signup extends StatefulWidget {
  const Signup({Key key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isMale = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController password = TextEditingController();

  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static RegExp regExp = RegExp(p);
  bool isLoading = false;
  UserCredential authResult;
  void submit() async {
    setState(() {
      isLoading = true;
    });
    try {
      authResult = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
    } on PlatformException catch (e) {
      String message = "Please check internet connection";
      if (e.message != null) {
        message = e.message.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    await FirebaseFirestore.instance
        .collection("UserData")
        .doc(authResult.user.uid)
        .set({
      "UserName": fullName.text,
      "UserEmail": email.text,
      "UserId": authResult.user.uid,
      "UserNumber": phoneNumber.text,
      "UserAddress": address.text,
      "UserGender": isMale == true ? "Male" : "Female"
    });
    setState(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomePage(),
        ),
      );
      isLoading = false;
    });
  }

  void validation() {
    if (email.text.isEmpty &&
        password.text.isEmpty &&
        fullName.text.isEmpty &&
        address.text.isEmpty &&
        phoneNumber.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("All Field are Empty")));
    } else if (fullName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("FullName is empty")),
      );
    } else if (!regExp.hasMatch(email.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email is not valid")),
      );
    } else if (phoneNumber.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Phone Number is empty")),
      );
    } else if (phoneNumber.text.length < 11) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Phone Number must be 10 digits")),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      key: scaffold,
      backgroundColor: const Color(0xff122547),

      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const TopTitle(
                subsTitle: "Create an Account",
                title: "SignUp",
              ),
              Container(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyTextFormField(
                      controller: fullName,
                      title: "Full Name",
                    ),
                    MyTextFormField(
                      controller: email,
                      title: "Email",
                    ),
                    MyTextFormField(
                      controller: phoneNumber,
                      title: "Phone NUmber",
                    ),
                    MyTextFormField(
                      controller: address,
                      title: "Address",
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = !isMale;
                        });
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          isMale == false ? "Female" : "Male",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: const Color(0xfff5d8e4),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    MyPasswordTextFormField(
                      controller: password,
                      title: "Password",
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
              ),
              isLoading == false
                  ? MyButton(
                      name: "Sign Up",
                      onPressed: () {
                        validation();
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
              Container(
                height: 20,
              ),
              HaveAccountOrNot(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => Login(),
                      ),
                    );
                  },
                  title: "I already have an account  ",
                  subTitle: "Login"),
            ],
          ),
        ),
      ),
    );
  }
}
