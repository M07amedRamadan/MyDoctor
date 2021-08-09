import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_doctor/welcome.dart';
import 'AppLocalizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyDoctor());
}

class MyDoctor extends StatefulWidget {
  static void setLocale(BuildContext _context,Locale locale){
    _MyDoctorState state = _context.findAncestorStateOfType<_MyDoctorState>();
    state.setLocale(locale);
  }
  @override
  _MyDoctorState createState() => _MyDoctorState();
}

class _MyDoctorState extends State<MyDoctor> {
  Locale _locale;
  void setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Screen',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          canvasColor: Colors.white),
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return locale;
          }
        }
        return supportedLocales.first;
      },
      home: Welcome(),
    );
  }
}
