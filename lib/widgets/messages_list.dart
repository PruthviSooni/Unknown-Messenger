import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../utils/constants.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessagesList extends StatelessWidget {
  final ScrollController scrollController;

  const MessagesList({this.scrollController});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box('numbers').listenable(),
      builder: (_, Box box, child) {
        if (box.isNotEmpty) {
          return ListView.builder(
              controller: scrollController,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (_, index) {
                final _items = box.toMap();
                var data = _items[index];
                return Theme(
                  data: ThemeData.light().copyWith(
                      accentColor: darkAccent, primaryColor: darkAccent),
                  child: ExpansionTile(
                    title: Text(
                      "${data['number']}",
                      style: TextStyle(
                          color: darkAccent, fontWeight: FontWeight.bold),
                    ),
                    expandedAlignment: Alignment.topLeft,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Message:',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: darkAccent),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${data['message']}' ?? "",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: darkAccent,
                              ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _formatDate(data['timeStamp']),
                          style: TextStyle(color: darkAccent),
                        ),
                      ),
                    ],
                    subtitle: Text(
                      timeago.format(
                        DateTime.parse(data['timeStamp']),
                      ),
                      style: TextStyle(color: darkAccent),
                    ),
                    childrenPadding: EdgeInsets.only(
                        left: 15, bottom: 10, right: 10, top: 0),
                  ),
                );
              });
        }
        return Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Text(
            'No History',
            style: TextStyle(
              color: darkAccent,
            ),
          ),
        );
      },
    );
  }

  String _formatDate(String date) {
    return DateFormat.yMMMd().add_jm().format(DateTime.parse(date));
  }
}
