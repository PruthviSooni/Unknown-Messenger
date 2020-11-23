import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/number_history.dart';
import '../screens/status_screen.dart';
import '../utils/constants.dart';
import '../widgets/customAppbar.dart';

class Home extends StatefulWidget {
  static final routeName = '/Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _number = TextEditingController();
  TextEditingController _message = TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Map<Permission, PermissionStatus> status;
  var numberFiledFocus = FocusNode();
  var messageFiledFocus = FocusNode();
  String _code = '+91';
  String _msg, _num;
  bool expand = false;

  Future _getFile() async {
    Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');
  }

  _showSnackBar(msg) {
    // ignore: deprecated_member_use
    _key.currentState.showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: darkAccent,
    ));
  }

  void insertData() async {
    final box = Hive.box('numbers');
    var data = {
      'number': _num,
      'message': _msg,
      'timeStamp': DateTime.now().toString(),
    };
    box.add(data);
  }

  _onPressed() async {
    bool isInstalled = await DeviceApps.isAppInstalled('com.whatsapp');
    if (_number.text.isEmpty && _message.text.isEmpty) {
      _showSnackBar('Please enter Number and Message');
    } else if (_number.text.length < 10) {
      _showSnackBar("Enter valid number");
    } else if (_message.text.length < 1) {
      _showSnackBar('Message length should be 5 letters');
    } else if (!isInstalled) {
      _showSnackBar('Please Install WhatsApp first!');
    } else {
      insertData();
      FlutterOpenWhatsapp.sendSingleMessage(
          '$_code${_number.text}', '${_message.text}');
    }
  }

  _showDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationIcon: Image.asset(
        'images/unknown_logo.png',
        height: 100,
      ),
      applicationLegalese: 'By Pruthvi Soni',
      applicationName: "Unknown Messenger",
      applicationVersion: "Version 2.0.0",
    );
  }

  @override
  void initState() {
    _getFile();
    _getPermission();
    super.initState();
  }

  _getPermission() async {
    status = await [Permission.storage].request();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff273443),
      key: _key,
      body: Stack(
        children: [
          Container(
            width: mediaQuery.width,
            height: mediaQuery.height,
            child: Image(
              image: AssetImage('images/background.jpg'),
            ),
          ),
          CustomAppBar(
            mediaQuery: mediaQuery,
            onPressed: () => _showDialog(context),
          ), //
          Positioned(
            top: mediaQuery.height / 3.6,
            width: mediaQuery.width,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                    "Send Message Without Saving a Number in WhatsApp",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 10),
                    CountryCodePicker(
                      onChanged: (code) {
                        setState(() {
                          _code = code.dialCode;
                        });
                      },
                      initialSelection: 'IN',
                      favorite: ['+91', 'IN'],
                      // backgroundColor: darkAccent,
                      dialogTextStyle: TextStyle(color: Colors.white),
                      textStyle: TextStyle(color: Colors.white),
                      searchStyle: TextStyle(color: darkAccent),
                      boxDecoration: BoxDecoration(
                        color: darkAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      searchDecoration:
                          kInputDecoration.copyWith(hintText: "Search Country"),
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: TextField(
                          onEditingComplete: () =>
                              FocusScope.of(context).nextFocus(),
                          controller: _number,
                          onChanged: (value) {
                            _num = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: kInputDecoration.copyWith(
                              hintText: 'Enter Number Here'),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: _message,
                    onChanged: (value) {
                      _msg = value;
                    },
                    keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: 3,
                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                    decoration: kInputDecoration.copyWith(
                        hintText: 'Enter Your Message'),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: _onPressed,
                      color: greenAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      child: Text(
                        'Send Message',
                        style: TextStyle(color: darkAccent),
                      ),
                    ),
                    SizedBox(width: 10),
                    FlatButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (ctx) => StatusScreen(),
                          ),
                        );
                      },
                      color: greenAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28)),
                      child: Text(
                        'Status Saver',
                        style: TextStyle(color: darkAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          NumberHistory()
        ],
      ),
    );
  }
}
