import 'package:flutter/material.dart';
import 'package:unknown_messenger/utils/constants.dart';
import 'package:unknown_messenger/widgets/image_status.dart';
import 'package:unknown_messenger/widgets/video_status.dart';

class StatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: darkAccent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: darkAccent,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Status Saver', style: TextStyle(color: darkAccent)),
          bottom: TabBar(
            indicatorColor: darkAccent,
            tabs: [
              Tab(
                child: Text('Images', style: TextStyle(color: darkAccent)),
                icon: Icon(
                  Icons.image,
                  size: 20,
                  color: darkAccent,
                ),
              ),
              Tab(
                child: Text(
                  'Videos',
                  style: TextStyle(color: darkAccent),
                ),
                icon: Icon(
                  Icons.video_collection,
                  size: 20,
                  color: darkAccent,
                ),
              )
            ],
          ),
          backgroundColor: Theme.of(context).accentColor.withOpacity(.8),
        ),
        body: TabBarView(
          children: [
            StatusImages(),
            StatusVideos(),
          ],
        ),
      ),
    );
  }
}
