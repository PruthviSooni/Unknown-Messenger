import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:splashscreen/splashscreen.dart';

import './screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.isAdapterRegistered(0);
  await Hive.openBox('numbers');
  runApp(
    MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF189D0E),
      ),
      home: App(),
    ),
  );
}

class App extends StatelessWidget {
  Future<Widget> loadFromFuture() async {
    return Future.value(Hive.openBox('numbers')).then((value) => Home());
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: Home(),
      routeName: Home.routeName,
      image: Image.asset(
        'images/unknown_logo.png',
      ),
      photoSize: 150,
      title: Text(
        'Unknown Messenger',
        style: TextStyle(fontSize: 26),
      ),
      imageBackground: AssetImage('images/background.jpg'),
    );
  }
}
