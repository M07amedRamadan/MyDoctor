import 'dart:convert';
import 'package:my_doctor/AppLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AppLocalizations.dart';
import 'menu.dart';
import 'package:http/http.dart' as http;
import 'new.dart';

class Reservations extends StatefulWidget {
  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  List reservations = [];
  bool isLoading = false;

  void initState() {
    super.initState();
    this.fetchDoctors();
  }

  fetchDoctors() async {
    setState(() {
      isLoading = true;
    });
    Map mappeddata = {
      'doctor_id': Profile1[0]['doctor_id'],
    };
    var url = "https://phpclinic.000webhostapp.com/Doctor/viewReservation.php";
    var response = await http.post(url, body: mappeddata);

    setState(() {
      reservations = jsonDecode(response.body);
    });
    var doctorId = Profile1[0]['doctor_id'];
    print("the doctor id is : ${doctorId}");
    print('the response body is: ${reservations}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            AppLocalization.of(context).translate('Reservations'),
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Menu()));
                }),
          ]),
      body: Container(
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
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.white,
                Colors.blue,
              ],
            )),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(" Number ",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text((index + 1).toString(),
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        )),
                  ],
                ),
                getCard(reservations[index]),
              ],
            ),
          );
        });
  }

  Widget getCard(item) {
    var reservation_day = item['reservation_day'];
    var reservation_time = item['reservation_time'];
    var username = item['username'];
    var mobile = item['mobile'];

    return Card(
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Text(" Name ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(username.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(" Phone : ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(mobile.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(" Day: ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(reservation_day.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(" Reservation Time : ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(reservation_time.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                ],
              ),
            ],
          )),
    );
  }
}
