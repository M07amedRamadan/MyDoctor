import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_doctor/reservations.dart';
import 'AppLocalizations.dart';
import 'appointments.dart';
import 'home.dart';
import 'menu.dart';
import 'package:http/http.dart' as http;
import 'new.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<Comeing> futurePost;

  @override
  void initState() {
    super.initState();
    futurePost = getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              title: Text(
                AppLocalization.of(context).translate('profile'),
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                    color: Colors.blueAccent),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                    icon: Icon(Icons.list),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Menu()));
                    }),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
                color: Colors.blue[400],
                shape: CircularNotchedRectangle(),
                child: Container(
                  height: 60,
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
                                        builder: (context) => Addition()));
                              },
                              child: Icon(Icons.work_outlined, size: 40)),
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
            body: FutureBuilder<Comeing>(
              future: futurePost,
              builder: (context, snapshot) {
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
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                        imageProfile(),
                          SizedBox(height: 25),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text:
                                    AppLocalization.of(context).translate("Dr"),
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.black,
                                )),
                            TextSpan(
                                text: "${snapshot.data.name}",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white)),
                          ])),
                          SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.blue[300],
                            child: TabBar(
                                labelPadding:
                                    EdgeInsets.only(left: 50, right: 30),
                                indicatorColor: Colors.white,
                                isScrollable: true,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.black87,
                                labelStyle: TextStyle(fontSize: 20),
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  // Creates border
                                  // color: Colors.greenAccent
                                ),
                                tabs: [
                                  Tab(
                                      text: AppLocalization.of(context)
                                          .translate('Information')),
                                  Tab(
                                      text: AppLocalization.of(context)
                                          .translate('det')),
                                ]),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 10),
                              color: Colors.blue[400],
                              child: TabBarView(children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: AppLocalization.of(context)
                                                .translate("Specialist"),
                                            style: TextStyle(
                                                fontSize: 23,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: "${snapshot.data.specialist}",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white)),
                                      ])),
                                      SizedBox(height: 20),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: AppLocalization.of(context)
                                                .translate("doctor_phone"),
                                            style: TextStyle(
                                                fontSize: 23,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: "${snapshot.data.phone}",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white)),
                                      ])),
                                    ]),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: AppLocalization.of(context)
                                                .translate("Places"),
                                            style: TextStyle(
                                                fontSize: 23,
                                                color: Colors.black)),
                                        TextSpan(
                                            text:
                                                "${snapshot.data.clinicPlace}",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white)),
                                      ])),
                                      SizedBox(height: 20),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: AppLocalization.of(context)
                                                .translate("id"),
                                            style: TextStyle(
                                                fontSize: 23,
                                                color: Colors.black)),
                                        TextSpan(
                                            text: "${snapshot.data.doctor_id}",
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white)),
                                      ])),
                                    ]),
                              ]),
                            ),
                          ),
                        ]),
                  ),
                );
              },
            )));
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white60,
          backgroundImage: _imageFile == null
              ? AssetImage('assets/images/profile.jfif')
              : FileImage(File(_imageFile.path)),
          radius: 70,
        ),
        Positioned(
            bottom: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: ((builder) => bottomSheet(context)));
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.red,
                size: 40,
              ),
            ))
      ]),
    );
  }

  Widget bottomSheet(BuildContext context1) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue[400],
              Colors.blue[100],
            ],
          )),
      height: 120,
      width: MediaQuery.of(context1).size.width,
      child: Column(
        children: [
          Text(
            AppLocalization.of(context).translate('select_photo'),
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 20,
              ),
              FlatButton.icon(
                  onPressed: () {
                    pickPhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text(AppLocalization.of(context).translate('Camera'))),
              FlatButton.icon(
                  onPressed: () {
                    pickPhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label:
                  Text(AppLocalization.of(context).translate('Gallery'))),
            ],
          )
        ],
      ),
    );
  }

  void pickPhoto(ImageSource source) async {
    final PickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = PickedFile;
    });
  }


Future<Comeing> getData() async {
  print("new one : ${Profile1}");
  return Comeing.fromJson(Profile1[0]);
}
}

class Comeing {
  var doctor_id;
  var name;
  var image;
  var phone;
  var specialist;
  var clinicPlace;

  Comeing(
      {this.doctor_id,
        this.name,
        this.image,
        this.phone,
        this.specialist,
        this.clinicPlace});

  factory Comeing.fromJson(Map<String, dynamic> json) {
    return Comeing(
        doctor_id: json['doctor_id'],
        name: json['name'],
        image: json['image'],
        phone: json['phone'],
        specialist: json['specialist'],
        clinicPlace: json['clinicPlace']);
  }
}