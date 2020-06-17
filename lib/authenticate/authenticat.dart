import 'package:chat/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:chat/authenticate/login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool register = false;

  void toggleView() {
    setState(() {
      register = !register;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(register == false) {
      return Login(toggleView);
    } else {
      return Register(toggleView);
    }
  }
}
