import 'package:flutter/material.dart';
import 'package:unknown_messenger/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key key,
    @required this.mediaQuery,
    this.onPressed,
  }) : super(key: key);
  final onPressed;
  final Size mediaQuery;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        alignment: Alignment.topCenter,
        width: mediaQuery.width,
        height: 190,
        decoration: BoxDecoration(
            color: Color(0xFF1ebea5),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(48))),
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.all(25),
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: (Icon(
                      Icons.info_outline,
                      color: darkAccent,
                    )),
                    onPressed: onPressed)),
            Align(
              alignment: Alignment.center,
              child: Image(
                image: AssetImage('images/unknown_whatsapp.png'),
                width: 50,
                color: darkAccent,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.bottomCenter,
              child: Text(
                'UnKnown Messenger',
                style: TextStyle(fontSize: 32, color: darkAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
