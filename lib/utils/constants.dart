import 'dart:io';

import 'package:flutter/material.dart';

var darkAccent = Color(0xff273443);
var greenAccent = Color(0xff1ebea5);
Directory path = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
var kInputDecoration = InputDecoration(
    hintText: "Enter Number Here",
    fillColor: darkAccent,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(width: 0),
    ));

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
