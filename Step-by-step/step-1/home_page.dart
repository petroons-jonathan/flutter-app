import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // create structure (scaffold = échafaudage)
    return new Scaffold(
      // create application bar
      appBar: new AppBar(
        // create a title
        title: new Text("Morpion"),
      ),
      body: new Container()
    );
  }
}