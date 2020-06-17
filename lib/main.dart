import 'package:chat/models/user.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
        child:MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
    );
  }
}
