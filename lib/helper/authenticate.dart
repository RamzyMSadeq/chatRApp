
import 'package:chatapp/views/login.dart';
import 'package:chatapp/views/signin.dart';
import 'package:chatapp/views/signin2.dart';
import 'package:chatapp/views/signup.dart';
import 'package:chatapp/views/signup2.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn2();
    } else {
      return SignUp2(toggleView: toggleView,);
    }
  }
}
