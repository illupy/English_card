import 'package:app/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build (BuildContext context){
    void initState() {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    }
    return MaterialApp(
        home: LandingPage());
  }


}





