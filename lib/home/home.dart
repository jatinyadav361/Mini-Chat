import 'package:chat/home/new_data.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/auth.dart';
import 'package:chat/shared/Loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService _authService = AuthService();

  bool loading = false;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          FlatButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NewUserData();
              }));
            },
            label: Text('Settings'),
            icon: Icon(Icons.settings),
          ),
          FlatButton.icon(
            onPressed: () async {
              setState(() {
                loading = true;
              });
              dynamic result = await _authService.signOut(user.uid);
              if (result != null) {
                Fluttertoast.showToast(msg: 'Failed');
                setState(() {
                  loading = false;
                });
              } else {
                Fluttertoast.showToast(msg: 'Logged Out Successfully!');
                setState(() {
                  loading = false;
                });
              }
            },
            label: Text('SignOut'),
            icon: Icon(Icons.lock_open),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(left: 15, right: 15),
            children: [

            ],
          ),
          Positioned(
            child: loading ? Loading() : Container(),
          ),
        ],
      ),
    );
  }
}
