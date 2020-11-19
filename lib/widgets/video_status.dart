import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unknown_messenger/utils/constants.dart';
import 'package:unknown_messenger/widgets/video_items.dart';

class StatusVideos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Directory('${path.path}').existsSync()) {
      var videoList = path
          .listSync()
          .map((e) => e.path)
          .where((element) => element.endsWith('.mp4'))
          .toList();
      if (videoList.length > 0) {
        print(videoList);
        return ListView.builder(
            itemCount: videoList.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (ctx, index) {
              return VideoItems(
                file: File(videoList[index]),
              );
            });
      } else {
        return Center(
          child: Text('No status videos found'),
        );
      }
    } else {
      return Center(
        child: Text('No found'),
      );
    }
  }
}
