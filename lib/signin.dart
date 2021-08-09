import 'dart:convert';
import 'package:my_doctor/registration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'AppLocalizations.dart';
import 'home.dart';
import 'new.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formkey = GlobalKey<FormState>();
  bool _isHidden = true;

  TextEditingController _password = TextEditingController();
  TextEditingController _email = TextEditingController();

  static var profile;

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
            AppLocalization.of(context).translate('log'),
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
            child: Form(
              key: formkey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    cursorHeight: 20,
                    decoration: InputDecoration(
                      hintText: AppLocalization.of(context).translate('enter'),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalization.of(context)
                            .translate("required");
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Enter the mail correctly");
                      }
                      return null;
                    },
                    onSaved: (String email) {},
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: _password,
                    cursorHeight: 20,
                    obscureText: _isHidden,
                    decoration: InputDecoration(
                        hintText:
                            AppLocalization.of(context).translate('passwod'),
                        hintStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                        suffixIcon: IconButton(
                            onPressed: _showHideText,
                            icon: _isHidden
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return AppLocalization.of(context)
                            .translate('required');
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 10),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        color: Colors.blue,
                        child: Text(
                          AppLocalization.of(context).translate('assurance'),
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        onPressed: () async {
                          if (formkey.currentState.validate()) {
                            Signin(_email.text, _password.text);
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
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          color: Colors.blue[400],
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          })
                                    ],
                                  );
                                });
                            print("Failed");
                          }
                        }),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(children: [
                        Text(AppLocalization.of(context).translate('dtails'),
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.blue,
                            )),
                        GestureDetector(
                          child: Text(
                            AppLocalization.of(context).translate('sign'),
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registration()));
                          },
                        )
                      ])),
                ],
              ),
            ),
          ),
        ));
  }

  void _showHideText() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future Signin(String email, password) async {
    var URL = "https://phpclinic.000webhostapp.com/Doctor/SignIn.php";
    // var URL = "https://phpclinic.000webhostapp.com/additional/sign_in.php";
    Map mappeddata = {
      'email': email,
      'password': password,
    };
    print("Your data is: ${mappeddata}");
    var response = await http.post(URL, body: mappeddata);
    print("response.body is :${response.body}");
    var data = json.decode(response.body);
    if (response != null) {
      if (data == "dont have an account") {
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
                  'dont have an account',
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
        if (data == "false") {
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
                    'incorrect password or mail',
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
          profile = json.decode(response.body);
          Profile1 = profile;
          print("Profile1 is :${Profile1}");
          Fluttertoast.showToast(
              msg: "Welcome", toastLength: Toast.LENGTH_LONG);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      }
    }
  }
}
