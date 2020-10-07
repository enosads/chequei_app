import 'package:chequei/widgets/tile.dart';
import 'package:flutter/material.dart';

class AppBottomSheet extends StatelessWidget {
  String title;
  Widget child;

  AppBottomSheet({this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: _getBody(),
          ),
        ),
      ),
    );
  }

  _getBody() {
    List<Widget> body = [
      SizedBox(
        height: 16,
      ),
      title != null
          ? Tile(
              bold: true,
              title: TitleTile(
                title,
                bold: true,
              ),
            )
          : Container(),
    ];
    if (child != null) {
      body.add(child);
    }
    return body;
  }
}
