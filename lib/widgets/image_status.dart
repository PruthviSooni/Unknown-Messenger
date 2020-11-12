import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share/share.dart';
import 'package:unknown_messenger/utils/constants.dart';

Directory path = Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class StatusImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Directory('${path.path}').existsSync()) {
      var list = path
          .listSync()
          .map((e) => e.path)
          .where(
            (element) => element.endsWith('.jpg'),
          )
          .toList();
      if (list.length > 0) {
        return ListView.builder(
            itemCount: list.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (ctx, index) {
              String albumName = 'Media';
              var imagePath = list[index];
              return Card(
                  margin: EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        children: [
                          Image.file(
                            File(imagePath),
                            width: MediaQuery.of(context).size.width,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            width: MediaQuery.of(context).size.width,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: darkAccent.withOpacity(.9),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      print(imagePath);
                                      GallerySaver.saveImage(imagePath)
                                          .then((value) => print('saved'));
                                    },
                                    icon: Icon(Icons.file_download),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Share.share(imagePath)
                                          .then((value) => print('shared'));
                                    },
                                    icon: Icon(Icons.share),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      )));
            });
      }
      return Center(
        child: Text('WhatsApp is not Installed!'),
      );
    } else {
      return Container();
    }
  }
}
