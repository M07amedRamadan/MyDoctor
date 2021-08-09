import 'dart:convert';
import 'dart:io';
import 'package:my_doctor/signin.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'AppLocalizations.dart';
import 'package:http/http.dart' as http;

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {



  TextEditingController _name = TextEditingController();
  TextEditingController _specialist = TextEditingController();
  TextEditingController _place = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool _isHidden = true, _isHidden1 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          AppLocalization.of(context).translate('Registration'),
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
        backgroundColor: Colors.white54,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue[50],
              Colors.blue[400],
            ],
          )),
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              children: <Widget>[

                TextFormField(
                  controller: _name,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      hintText: AppLocalization.of(context).translate('Name1'),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppLocalization.of(context).translate('required');
                    }
                    return null;
                  },
                  onSaved: (String name) {},
                ),
                SizedBox(height: 15),
                TextFormField(
                    controller: _specialist,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalization.of(context).translate('Specialist1'),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    )),
                SizedBox(height: 15),
                TextFormField(
                    controller: _place,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalization.of(context).translate('clinic_place'),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    )),
                SizedBox(height: 15),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.number,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      hintText: AppLocalization.of(context).translate('Phone'),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppLocalization.of(context).translate('required');
                    }
                    return null;
                  },
                  onSaved: (String phone) {},
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      hintText: AppLocalization.of(context).translate('E-mail'),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppLocalization.of(context).translate('required');
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Enter the mail correctly ");
                    }
                    return null;
                  },
                  onSaved: (String email) {},
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _password,
                  obscureText: _isHidden,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      hintText:
                          AppLocalization.of(context).translate('Password'),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: _showHideText,
                          icon: _isHidden
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppLocalization.of(context).translate("Required");
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _confirmpassword,
                  obscureText: _isHidden1,
                  cursorHeight: 20,
                  decoration: InputDecoration(
                      hintText: AppLocalization.of(context)
                          .translate('Re_Enter Password'),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: _showHideText1,
                          icon: _isHidden1
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility))),
                  validator: (value) {
                    if (value.isEmpty) {
                      return AppLocalization.of(context).translate("Required");
                    }
                    if (_password.text != _confirmpassword.text) {
                      return "Password do not match Re_Enter it!";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    color: Colors.blue,
                    child: Text(
                      AppLocalization.of(context).translate('Confirm'),
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: () {
                      if (formkey.currentState.validate()) {
                        // store data to local database
                        RegistrationUser();
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.blue[300],
                                title: Text(
                                  AppLocalization.of(context)
                                      .translate("error"),
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 35),
                                ),
                                content: Text(
                                  AppLocalization.of(context)
                                      .translate('short1'),
                                  style: TextStyle(fontSize: 25),
                                ),
                                actions: <Widget>[
                                  RaisedButton(
                                      child: Text(
                                        AppLocalization.of(context)
                                            .translate('end'),
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      color: Colors.blue[400],
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      })
                                ],
                              );
                            });
                      }
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 5),
                    //padding must not be null
                    child: Row(children: [
                      Text(AppLocalization.of(context).translate('detail'),
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.blue,
                          )),
                      GestureDetector(
                        child: Text(
                          AppLocalization.of(context).translate('logl'),
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                      )
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showHideText() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _showHideText1() {
    setState(() {
      _isHidden1 = !_isHidden1;
    });
  }



  Future RegistrationUser() async {
    var URL = "https://phpclinic.000webhostapp.com/Doctor/signup.php";
    Map mapeddate = {
      // 'image': _imageFile.path,
      'name': _name.text,
      'clinicPlace': _place.text,
      'specialist': _specialist.text,
      'phone': _phone.text,
      'email': _email.text,
      'password': _password.text
    };
    print("JSON DATA: ${mapeddate}");
    http.Response reponse = await http.post(URL, body: mapeddate);
    var data = jsonDecode(reponse.body);
    print("DATA:${data}");

    if (json.decode(reponse.body) == "Error") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.blue[300],
              title: Text(
                AppLocalization.of(context).translate("error"),
                style: TextStyle(color: Colors.blue, fontSize: 35),
              ),
              content: Text(
                'You have an account try another one',
                style: TextStyle(fontSize: 25),
              ),
              actions: <Widget>[
                RaisedButton(
                    child: Text(
                      AppLocalization.of(context).translate('end'),
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Colors.blue[400],
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            );
          });
    } else {
      if (json.decode(reponse.body) == "Success") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignIn()));
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.blue[300],
                title: Text(
                  "Done",
                  style: TextStyle(color: Colors.blue, fontSize: 35),
                ),
                content: Text(
                  'account created Now sign in',
                  style: TextStyle(fontSize: 25),
                ),
                actions: <Widget>[
                  RaisedButton(
                      child: Text(
                        AppLocalization.of(context).translate('end'),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.blue[400],
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.blue[300],
                title: Text(
                  AppLocalization.of(context).translate("error"),
                  style: TextStyle(color: Colors.blue, fontSize: 35),
                ),
                content: Text(
                  'Some thing went wrong',
                  style: TextStyle(fontSize: 25),
                ),
                actions: <Widget>[
                  RaisedButton(
                      child: Text(
                        AppLocalization.of(context).translate('end'),
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Colors.blue[400],
                      onPressed: () {
                        Navigator.of(context).pop();
                      })
                ],
              );
            });
      }
    }
  }
}
