import 'package:flutter/material.dart';
import 'home_page.dart';

// need this to run the app 
void main() => runApp(MyApp());

// the entire application is a widget 
class MyApp extends StatelessWidget {
  @override
  // build widget 
  Widget build(BuildContext context){
    return new MaterialApp(
      theme: ThemeData(primaryColor: Colors.green),
      home: new HomePage(),
    );
  }
}