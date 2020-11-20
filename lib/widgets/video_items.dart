import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share/share.dart';
import 'package:unknown_messenger/utils/constants.dart';

class VideoItems extends StatefulWidget {
  final File file;

  const VideoItems({Key key, this.file}) : super(key: key);

  @override
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  BetterPlayerController _controller, _controller_2;
  bool mounted= false;

  @override
  void initState() {
    initController();
    super.initState();
  }

  Future<void> initController() async {
    BetterPlayerDataSource _dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.FILE,
      widget.file.path,
    );
    _controller = BetterPlayerController(
      BetterPlayerConfiguration(
        fit: BoxFit.fitWidth,
        fullScreenByDefault: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
        ),
      ),
      betterPlayerDataSource: _dataSource,
    );
     _controller_2 = BetterPlayerController(
      BetterPlayerConfiguration(
        fit: BoxFit.fitWidth,
        aspectRatio: 10 / 16,
        fullScreenByDefault: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSkips: false,
          enableFullscreen: false,
          enableOverflowMenu: false,
        ),
      ),
      betterPlayerDataSource: _dataSource,
    );
     }
  
 

  @override
  void dispose() {
    _controller.dispose();
    _controller_2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        initController();
        showModalBottomSheet(
            builder: (ctx) {
              return AspectRatio(
                aspectRatio: 10 / 16,
                child: BetterPlayer(
                  controller: _controller_2,
                ),
              );
            },
            context: context);
      },
      child: Card(
          color: darkAccent,
          elevation: 5,
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: Column(
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: BetterPlayer(
                    controller: _controller,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Share.shareFiles(
                              [widget.file.path],
                            ).catchError((e) => print(e));
                          },
                          icon: Icon(Icons.share)),
                      IconButton(
                          onPressed: () async {
                            GallerySaver.saveVideo(
                              widget.file.path,
                            )
                                .then((value) =>
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Video is Saved in Gallery/Movies',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor: darkAccent,
                                      ),
                                    ))
                                .catchError((e) => print(e));
                          },
                          icon: Icon(Icons.download_rounded)),
                    ],
                  ),
                )
              ],
            ),
          )
          // : Center(
          //     child: CircularProgressIndicator(),
          //   ),
          ),
    );
  }
}
