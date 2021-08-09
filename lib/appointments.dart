import 'dart:convert';
import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_doctor/profile.dart';
import 'package:my_doctor/reservations.dart';
import 'AppLocalizations.dart';
import 'MyAppointment.dart';
import 'home.dart';
import 'package:http/http.dart' as http;

import 'new.dart';

class Addition extends StatefulWidget {
  @override
  _AdditionState createState() => _AdditionState();
}

class _AdditionState extends State<Addition> {


  TimeOfDay _clockdate1;

  TimeOfDay _clockdate2;

  String dayChoose = 'Saturday';
  List dayitem = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  TextEditingController _clockdat1 = TextEditingController();
  TextEditingController _clockdat2 = TextEditingController();



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
              AppLocalization.of(context).translate('appointments'),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Reserv()));
                  }),
            ]),
        bottomNavigationBar: BottomAppBar(
            color: Colors.blue,
            shape: CircularNotchedRectangle(),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue[100],
                  Colors.blue[400],
                ],
              )),
              height: 80,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          child: Icon(Icons.home_rounded, size: 40)),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()));
                          },
                          child: Icon(Icons.person, size: 40)),
                      FlatButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Reservations()));
                          },
                          child: Icon(Icons.archive, size: 40)),
                      SizedBox.shrink()
                    ]),
              ),
            )),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue[50],
                  Colors.blue[400],
                ],
              )),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "The day is: ",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      DropdownButton(
                        hint: Text('choose Day'),
                        value: dayChoose,
                        onChanged: (newvalue) {
                          setState(() {
                            dayChoose = newvalue;
                          });
                        },
                        items: (dayitem.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList()),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  child: TextField(
                    readOnly: true,
                    // focusNode: AlwaysDisabledFocusNode(),
                    controller: _clockdat1,
                    onTap: () {
                      _clockTabFrom(context);
                    },
                    decoration: InputDecoration(
                      labelText: ('From '),
                      hintText: ('Start'),
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    readOnly: true,
                    controller: _clockdat2,
                    onTap: () {
                      _clockTabTo(context);
                    },
                    decoration: InputDecoration(
                      labelText: ('To '),
                      hintText: ('End'),
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 60),
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      color: Colors.blue,
                      child: Text(
                        AppLocalization.of(context).translate('Add'),
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      onPressed: () async {
                        appointmentUser();
                      }),),
              ]),
        ));
}
  _clockTabFrom(BuildContext context) async {
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: _clockdate1 != null ? _clockdate1 : TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });
    if (time != null) {
      _clockdate1 = time;

      _clockdat1.text = _clockdate1.format(context).toString();
      _clockdat1.selection = TextSelection.fromPosition(TextPosition(
          offset: _clockdat1.text.length, affinity: TextAffinity.upstream));
    }
  }

  _clockTabTo(BuildContext context) async {
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: _clockdate2 != null ? _clockdate2 : TimeOfDay.now(),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.yellow,
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });
    if (time != null) {
      _clockdate2 = time;
      _clockdat2.text = _clockdate2.format(context).toString();
      _clockdat2.selection = TextSelection.fromPosition(TextPosition(
          offset: _clockdat2.text.length, affinity: TextAffinity.upstream));
    }
  }

  Future appointmentUser() async {
    var URL = "https://phpclinic.000webhostapp.com/Doctor/addAppointment.php";
    Map mapeddate = {
      'appointment_doctor_id':Profile1[0]['doctor_id'],
      'appointment_day': dayChoose,
      'From': _clockdat1.text,
      'To': _clockdat2.text,
    };
    print("JSON DATA: ${mapeddate}");


    http.Response reponse = await http.post(URL, body: mapeddate);
    var data = jsonDecode(reponse.body);
    print("Data Decoded : ${data}");
    if(data == "success" ){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.blue[300],
              title: Text("Done",
                style: TextStyle(color: Colors.blue, fontSize: 35),
              ),
              content: Text(
                'Appointment added successfully',
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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Reserv()));
    }
    else{
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
                'Appointment is added before!',
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


