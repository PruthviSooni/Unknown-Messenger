import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../utils/constants.dart';
import 'messages_list.dart';

class NumberHistory extends StatefulWidget {
  const NumberHistory({
    Key key,
  }) : super(key: key);

  @override
  _NumberHistoryState createState() => _NumberHistoryState();
}

class _NumberHistoryState extends State<NumberHistory> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ValueListenableBuilder(
        valueListenable: Hive.box('numbers').listenable(),
        builder: (_, Box box, Widget __) {
          return DraggableScrollableSheet(
            minChildSize: 0.20,
            maxChildSize: .60,
            initialChildSize: .2,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                    color: greenAccent,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(48))),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 5),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10),
                        child: ScrollConfiguration(
                          behavior: MyBehavior(),
                          child: SingleChildScrollView(
                            controller: scrollController,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.history,
                                        color: darkAccent,
                                      ),
                                      Text(
                                        "History",
                                        style: TextStyle(color: darkAccent),
                                      ),
                                    ],
                                  ),
                                ),
                                box.isNotEmpty
                                    ? Container(
                                        margin: EdgeInsets.only(left: 15),
                                        alignment: Alignment.topLeft,
                                        child: FlatButton.icon(
                                          onPressed: () async {
                                            await Future.delayed(
                                                Duration(milliseconds: 100),
                                                () {
                                              setState(() {
                                                Hive.box('numbers').clear();
                                              });
                                            });
                                          },
                                          icon: Icon(
                                            Icons.clear,
                                            color: darkAccent,
                                          ),
                                          label: Text(
                                            'Clear',
                                            style: TextStyle(color: darkAccent),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                      child: MessagesList(
                        scrollController: scrollController,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
