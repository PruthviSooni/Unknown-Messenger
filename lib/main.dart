import 'package:flutter/material.dart';

import './screens/home.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(primaryColor: Color(0xFF189D0E)),
      home: Home(),
    );
  }
}
