import 'file:///C:/Users/jatin/AndroidStudioProjects/chat/lib/services/auth.dart';
import 'package:chat/models/user.dart';
import 'package:chat/shared/Loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {

  final Function toggleView;

  Login(this.toggleView);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

  AuthService _authService = AuthService();

  String email;
  String password;
  String error = '';

  bool loading = false;

  bool passwordReset = false;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    final user = Provider.of<User>(context);

    return  Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),

      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val ){
                      email = val ;
                    },
                    validator: (val) {
                      return val.isEmpty ? 'Enter valid email address' : null ;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (val ){
                      password = val ;
                    },
                    validator: (val) {
                      return val.length<6 ? 'Password must be minimum 6 char long' : null ;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: RaisedButton(
                    child: Text('Login'),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        print(user);
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await  _authService.signInWithEmailAndPassword(email, password);
                        if(result != null) {
                          Fluttertoast.showToast(msg: 'Logged In Successfully!');
                          loading = false;
                        }
                        else {
                          passwordReset = true;
                          Fluttertoast.showToast(msg: 'Login Failed');
                          setState(() {
                            loading = false;
                          });
                          error = 'Please enter valid credentials';
                        }
                      }
                    },
                  ),
                ),
                Center(
                  child: FlatButton(
                    child: Text('Create new account',textScaleFactor: 1.3,),
                    onPressed: (){
                      widget.toggleView();
                    },
                  ),
                ),
                SizedBox(height: 15,),
                Center(
                  child: Text(error,
                    textScaleFactor: 1.4,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            child: loading ? Loading() : Container(),
          ),
        ],
      ),
    );
  }
}
