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
  BetterPlayerController _controller;

  bool _showControl = true;

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
          enableFullscreen: false,
          enableOverflowMenu: false,
          enableSkips: false,
          showControls: _showControl,
          enablePlaybackSpeed: false,
          enableProgressBar: false,
          controlBarColor: darkAccent,
        ),
      ),
      betterPlayerDataSource: _dataSource,
    );
    bool _isPlaying = await _controller.isPlaying();
    _controller.addEventsListener((event) {
      if (_isPlaying) {
        setState(() {
          _showControl = true;
        });
      } else {
        setState(() {
          _showControl = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _isPlaying() async {}

  @override
  void didChangeDependencies() {
    _isPlaying();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        color: darkAccent,
        elevation: 5,
        child: AspectRatio(
          aspectRatio: 16 / 10,
          child: Column(
            children: [
              Flexible(
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
                              .then((value) => Scaffold.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                          'Video is Saved in Gallery/Movies'))))
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
        );
  }
}
