import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'menu.dart';
import 'new.dart';


class Reserv extends StatefulWidget {
  @override
  _ReservState createState() => _ReservState();
}

class _ReservState extends State<Reserv> {
  List appoientment = [];
  bool isLoading = false;

  void initState() {
    super.initState();
    this.appointmentUser();
  }
  Future appointmentUser() async {
    setState(() {
      isLoading = true;
    });

    var URL = "https://phpclinic.000webhostapp.com/Doctor/viewAppointment.php";
    Map mapeddate = {
      'doctor_id':Profile1[0]['doctor_id'],
    };
    print("JSON DATA: ${mapeddate}");

    http.Response response = await http.post(URL, body: mapeddate);
      appoientment = jsonDecode(response.body);

    print("appoientment is Data  : ${appoientment}");

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          title: Text('appointments',
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
      body:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.white,
                  Colors.blue,
                ],
              )),
          child: getBody()),


    );
  }

  Widget getBody() {
    return ListView.builder(
        itemCount: appoientment.length,
        itemBuilder: (context, index) {
          return getCard(appoientment[index]);
        });
  }

  Widget getCard(item) {
    var appointment_id = item['appointment_id'];
    var appointment_day = item['appointment_day'];
    var from = item['From'];
    var to = item['To'];


    return Card(
        child: new ExpansionTile(
            title: Row(children: <Widget>[
              Icon(Icons.access_time_rounded),
              SizedBox(
                width: 10,
              ),
              Text("My Appointment",
                  style: GoogleFonts.varelaRound(
                      fontSize: 18.0, color: Colors.blue))
            ]),
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: [
                      Text("  AppointmentId : ",
                          style: GoogleFonts.varelaRound(
                              fontSize: 18.0, color: Colors.blue)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(appointment_id.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("  Day : ",
                          style: GoogleFonts.varelaRound(
                              fontSize: 18.0, color: Colors.blue)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(appointment_day.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("  From : ",
                          style: GoogleFonts.varelaRound(
                              fontSize: 18.0, color: Colors.blue)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(from.toString()),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("  To : ",
                          style: GoogleFonts.varelaRound(
                              fontSize: 18.0, color: Colors.blue)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(to.toString()),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 60),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        color: Colors.blue,
                        child: Text('Delete',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        onPressed: () async {
                          appointmentDelete();
                        }),),
                ],
              ),
            ]));
  }
  Future appointmentDelete() async {
    var URL = "https://phpclinic.000webhostapp.com/Doctor/deleteAppointment.php";
    Map mapeddate = {
      'appointment_id':appoientment[0]['appointment_id'],
    };
    print("JSON DATA appointment_id: ${mapeddate}");

    http.Response response = await http.post(URL, body: mapeddate);
    var data = jsonDecode(response.body);
    print("Data Decoded : ${data}");

    if(data == "success") {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.blue[300],
              title: Text("Done",
                style: TextStyle(color: Colors.blue, fontSize: 35),
              ),
              content: Text(
                'Your appointment deleted',
                style: TextStyle(fontSize: 25),
              ),
              actions: <Widget>[
                RaisedButton(
                    child: Text('end',
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
    else{showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue[300],
            title: Text("error",
              style: TextStyle(color: Colors.blue, fontSize: 35),
            ),
            content: Text(
              'Some thing went wrong',
              style: TextStyle(fontSize: 25),
            ),
            actions: <Widget>[
              RaisedButton(
                  child: Text('end',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  color: Colors.blue[400],
                  onPressed: () {
                    Navigator.of(context).pop();
                  })
            ],
          );
        });}
  }
}
