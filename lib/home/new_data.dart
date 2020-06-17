import 'dart:io';

import 'package:chat/models/user.dart';
import 'package:chat/services/database.dart';
import 'package:chat/shared/Loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class NewUserData extends StatefulWidget {
  @override
  _NewUserDataState createState() => _NewUserDataState();
}

class _NewUserDataState extends State<NewUserData> {

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  String _firstName;
  String _lastName;
  String _photoUrl;

  File _image;

  bool loading = false;


  Future _getImageFromGallery() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if(image != null) {
      setState(() {
        _image = File('$image');
      });
    }
  }


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          backgroundImage: null,
                          radius: 100,
                          child: ClipOval(
                            child: SizedBox(
                              height: 180,
                              width: 180,
                              child: _image != null ? Image.file(_image) : null
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        tooltip: 'Click to select profile picture',
                        onPressed: (){
                          //todo
                        },
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: firstNameController,
                    keyboardType: TextInputType.text,
                    onChanged: (val){
                      _firstName = val;
                    },
                    validator: (val) {
                      return val.isEmpty ? 'Please enter your first name': null;
                    },
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextFormField(
                    controller: lastNameController,
                    keyboardType: TextInputType.text,
                    onChanged: (val){
                      _lastName = val;
                    },
                    validator: (val) {
                      return val.isEmpty ? 'Please enter your last name': null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: RaisedButton(
                    child: Text('Update'),
                    onPressed: () async{
                      if(_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });

                        var result = await FireStoreService(uid:user.uid).updateUserData(
                          '$_firstName $_lastName',null,user.email
                        );

                        if(result == null) {
                          Fluttertoast.showToast(msg: 'User Details Updated Successfully!');
                          setState(() {
                            loading = false;
                          });
                        } else {
                          Fluttertoast.showToast(msg: 'Try again later!');
                          setState(() {
                            loading = false;
                          });
                        }

                        Navigator.pop(context);
                      }
                    },
                  ),
                )

              ],
            ),
          ),

          Positioned(
            child: loading ? Loading():Container(),
          )

        ],
      ),
    );
  }
}
