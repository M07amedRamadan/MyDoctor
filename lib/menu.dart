import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_doctor/main.dart';
import 'package:my_doctor/profile.dart';
import 'package:share/share.dart';
import 'AppLocalizations.dart';
import 'MyAppointment.dart';
import 'appointments.dart';

class Menu extends StatefulWidget {
  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalization.of(context).translate('User_Name'),
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(AppLocalization.of(context).translate('My_Page'),
                style: TextStyle(
                  fontSize: 20,
                )),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(AppLocalization.of(context).translate('Settings'),
                style: TextStyle(
                  fontSize: 20,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailedSetting()));
            },
          ),
          ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(AppLocalization.of(context).translate('Information'),
                  style: TextStyle(
                    fontSize: 20,
                  )),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.blue[300],
                        title: Text(
                          AppLocalization.of(context).translate('Information'),
                          style: TextStyle(color: Colors.blue, fontSize: 35),
                        ),
                        content: Text(
                          AppLocalization.of(context).translate('short'),
                          style: TextStyle(fontSize: 25),
                        ),
                        actions: <Widget>[
                          RaisedButton(
                              child: Text(
                                AppLocalization.of(context).translate('end'),
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
              }),
          ListTile(
            leading: Icon(Icons.question_answer),
            title: Text(AppLocalization.of(context).translate('Who We Are'),
                style: TextStyle(
                  fontSize: 20,
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.blue[300],
                      title: Text(
                        AppLocalization.of(context).translate('Who We Are'),
                        style: TextStyle(color: Colors.blue, fontSize: 35),
                      ),
                      content: Text(
                        AppLocalization.of(context).translate('info'),
                        style: TextStyle(fontSize: 25),
                      ),
                      actions: <Widget>[
                        RaisedButton(
                            child: Text(
                              AppLocalization.of(context).translate('end'),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            color: Colors.blue[400],
                            onPressed: () {
                              Navigator.of(context).pop();
                            })
                      ],
                    );
                  });
            },
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text(AppLocalization.of(context).translate('Share App'),
                style: TextStyle(
                  fontSize: 20,
                )),
            onTap: () {
              Share.share('text');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(AppLocalization.of(context).translate('Logout'),
                style: TextStyle(
                  fontSize: 20,
                )),
            onTap: () {
              exit(0);
            },
          ),
        ],
      ),
    ));
  }
}

class DetailedSetting extends StatelessWidget {
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
              AppLocalization.of(context).translate('Settings'),
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
          padding: EdgeInsets.all(10),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                color: Colors.blue,
                child: ListTile(
                  title: Text('Add Appointment',
                      style: TextStyle(fontSize: 25, color: Colors.white)),
                  leading: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Addition()));
                },
              ),
              SizedBox(height: 40),
              Container(
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  color: Colors.blue,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.language,
                        color: Colors.black,
                        size: 35,
                      ),
                      DropdownButton(
                        underline: SizedBox(),
                        hint: Text(
                            AppLocalization.of(context).translate('change_lan'),
                            style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                        items: Language.languageList()
                            .map<DropdownMenuItem<Language>>(
                                (e) => DropdownMenuItem(
                                    value: e,
                                    child: Row(
                                      children: [
                                        Text(e.name,
                                            style: TextStyle(
                                                fontSize: 25,
                                                color: Colors.blue)),
                                        SizedBox(width: 30),
                                        Text(e.flag,
                                            style: TextStyle(fontSize: 25)),
                                      ],)))
                            .toList(),
                        onChanged: (Language lang) {
                          _changeLanguage(lang, context);},),
                    ]),
              ),
            ],
          ),
        ));
  }

  void _changeLanguage(Language language, BuildContext _context) {
    Locale _temp;
    switch (language.languageCode) {
      case "en":
        _temp = Locale(language.languageCode, 'US');
        break;
      case "ar":
        _temp = Locale(language.languageCode, 'EG');
        break;
      default:
        _temp = Locale('en', 'ar');
    }
    MyDoctor.setLocale(_context, _temp);
  }
}

class Language {
  final int id;
  final String name;
  final String flag;
  final String languageCode;

  Language(this.flag, this.id, this.languageCode, this.name);

  static List<Language> languageList() {
    return <Language>[
      Language('🇪🇬', 1, 'ar', 'Arabic'),
      Language('🇺🇸', 2, 'en', 'English')
    ];
  }
}
