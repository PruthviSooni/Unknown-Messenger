import 'package:country_code_picker/country_code_picker.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:unknown_messenger/utils/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _number = TextEditingController();
  TextEditingController _message = TextEditingController();
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String _code = '+91';

  @override
  void initState() {
    super.initState();
  }

  _showSnackBar(msg) {
    _key.currentState.showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: darkAccent,
    ));
  }

  @override
  void dispose() {
    _number.dispose();
    super.dispose();
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              alignment: Alignment.topCenter,
              width: mediaQuery.width,
              height: 200,
              decoration: BoxDecoration(
                  color: Color(0xFF1ebea5),
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(48))),
              child: Center(
                child: Row(
                  children: [
                    SizedBox(width: 40),
                    Image(
                      image: AssetImage('images/unknown_whatsapp.png'),
                      width: 50,
                      color: darkAccent,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'UnKnown Messenger',
                        style: TextStyle(fontSize: 32, color: darkAccent),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ), //
          Positioned(
            top: 240,
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
                    softWrap: true,
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
                        print(_code);
                      },
                      initialSelection: 'IN',
                      favorite: ['+91', 'IN'],
                      // backgroundColor: darkAccent,
                      dialogTextStyle: TextStyle(color: darkAccent),
                      searchStyle: TextStyle(color: darkAccent),
                      searchDecoration: InputDecoration(
                          fillColor: darkAccent,
                          hintText: 'Search Country',
                          enabledBorder: UnderlineInputBorder(),
                          border: UnderlineInputBorder()),
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: TextField(
                          controller: _number,
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
                    keyboardType: TextInputType.text,
                    minLines: 1,
                    maxLines: 3,
                    decoration: kInputDecoration.copyWith(
                        hintText: 'Enter Your Message'),
                  ),
                ),
                SizedBox(height: 10),
                FlatButton(
                  onPressed: () async {
                    bool isInstalled =
                        await DeviceApps.isAppInstalled('com.whatsapp');
                    if (_number.text.isEmpty && _message.text.isEmpty) {
                      _showSnackBar('Please enter Number and Message');
                    } else if (_number.text.length < 10) {
                      _showSnackBar("Enter valid number");
                    } else if (_message.text.length < 5) {
                      _showSnackBar('Message length should be 5 letters');
                    } else if (!isInstalled) {
                      _showSnackBar('Please Install WhatsApp first!');
                    } else {
                      FlutterOpenWhatsapp.sendSingleMessage(
                          '$_code${_number.text}', '${_message.text}');
                    }
                  },
                  color: Color(0xff1ebea5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  child: Text(
                    'Send Message',
                    style: TextStyle(color: darkAccent),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(bottom: 10),
              width: mediaQuery.width,
              height: 200,
              decoration: BoxDecoration(
                  color: Color(0xFF1ebea5),
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(48))),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Created By: Pruthvi_Soni',
                  style: TextStyle(
                      color: darkAccent,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
