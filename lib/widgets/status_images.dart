import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share/share.dart';
import 'package:unknown_messenger/utils/constants.dart';

class Images extends StatelessWidget {
  const Images({
    Key key,
    @required this.imagePath,
  }) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showBottomSheet(context, imagePath: imagePath),
      child: Card(
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.file(
                    File(imagePath),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
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
                            onPressed: () async {
                              GallerySaver.saveImage(imagePath).then((value) {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Image is saved in Gallery/Pictures.',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: darkAccent,
                                  ),
                                );
                              }).catchError((e) => print(e));
                            },
                            icon: Icon(Icons.file_download),
                          ),
                          IconButton(
                            onPressed: () {
                              Share.shareFiles([imagePath]);
                            },
                            icon: Icon(Icons.share),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }

  void _showBottomSheet(context, {imagePath}) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Image.file(
              File(imagePath),
              fit: BoxFit.contain,
            ));
  }
}
