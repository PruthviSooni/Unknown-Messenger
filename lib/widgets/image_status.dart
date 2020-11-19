import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unknown_messenger/utils/constants.dart';
import 'package:unknown_messenger/widgets/status_images.dart';

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
        return StaggeredGridView.countBuilder(
            physics: BouncingScrollPhysics(),
            crossAxisCount: 2,
            itemCount: list.length,
            itemBuilder: (ctx, index) {
              var imagePath = list[index];
              return Images(
                imagePath: imagePath,
              );
            },
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            shrinkWrap: true,
            staggeredTileBuilder: (int index) =>
                new StaggeredTile.count(1, index.isEven ? 2 : 1));
      }
      return Center(
        child: Text('No Status Images Found'),
      );
    } else {
      return Container();
    }
  }
}
