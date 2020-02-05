import 'package:flutter/material.dart';

class GameButton {
  //give an id to the button 
  final id;
  // give the "x" or "O" 
  String text;
  // color of background 
  Color bg;
  // say if the button is already clicked
  bool enabled; 
  // GameButton class
  GameButton({
    this.id,
    this.text="",
    this.bg= Colors.grey,
    this.enabled = true,
  });
}