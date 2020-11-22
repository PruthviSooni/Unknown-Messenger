import 'package:avatar_glow/avatar_glow.dart';
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
        height: (mediaQuery.height / 4),
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
            Container(
              margin: EdgeInsets.only(left: 50),
              alignment: Alignment.centerLeft,
              child: AvatarGlow(
                endRadius: 60,
                glowColor: darkAccent,
                repeat: true,
                showTwoGlows: true,
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Color(0xff1ebea5),
                    child: Image.asset(
                      'images/unknown_whatsapp.png',
                      height: 50,
                    ),
                    radius: 40.0,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 60, top: 15),
              alignment: Alignment.center,
              child: Text(
                'Unknown\nMessenger',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, color: darkAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
