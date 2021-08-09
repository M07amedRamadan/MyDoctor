import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_doctor/profile.dart';
import 'package:my_doctor/reservations.dart';
import 'AppLocalizations.dart';
import 'MyAppointment.dart';
import 'appointments.dart';
import 'menu.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              AppLocalization.of(context).translate('main_page'),
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.blue),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(Icons.list),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Menu()));
                  }),
            ]),
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
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    color: Colors.blue,
                    child: ListTile(
                      title: Text(
                          AppLocalization.of(context).translate('profile'),
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                      leading: Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                    },
                  ),
                  SizedBox(height: 40),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    color: Colors.blue,
                    child: ListTile(
                      title: Text('Show Appointments',
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                      leading: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Reserv()));
                    },
                  ),
                  SizedBox(height: 40),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40))),
                    color: Colors.blue,
                    child: ListTile(
                      title: Text(
                          AppLocalization.of(context).translate('reservations'),
                          style: TextStyle(fontSize: 25, color: Colors.white)),
                      leading: Icon(
                        Icons.pending_actions,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Reservations()));
                    },
                  ),
                ],
              ),
            )));
  }
}
