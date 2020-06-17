import 'package:chat/shared/Loading.dart';
import 'package:flutter/material.dart';
import 'package:chat/services/auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register(this.toggleView);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  bool loading = false;

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register User'),
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
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value){
                      email = value;
                    },
                    validator: (val){
                      return val.isEmpty ? 'Enter your registered email' : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(20)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    onChanged: (value){
                      password = value;
                    },
                    validator: (val) {
                      return val.length<6 ? 'Password must be minimum 6 character long' : null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius:BorderRadius.circular(20)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: RaisedButton(
                    child: Text('Register'),
                    onPressed: () async{
                      if(_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                        if(result == null) {
                          Fluttertoast.showToast(msg: 'Error registering user!');
                          error = 'Enter a valid email';
                          loading = false;
                        } else {
                          Fluttertoast.showToast(msg: 'User registered successfully!');
                          setState(() {
                            loading = false;
                          });
                        }
                      }
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: FlatButton(
                    child: Text('Already a user? LogIn'),
                    onPressed: (){
                      widget.toggleView();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(child:Text(error,textScaleFactor: 1.25,style: TextStyle(color: Colors.red),)),
                )
              ],
            ),
          ),

          Positioned(
            child: loading ? Loading():Container(),
          ),

        ],
      ),
    );
  }
}
