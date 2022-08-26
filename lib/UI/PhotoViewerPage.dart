import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerPage extends StatefulWidget {
  static const String route = '/PhotoViewerPage';
  String url;
  bool local;

  PhotoViewerPage({required this.url, this.local = false});

  @override
  _PhotoViewerPageState createState() => _PhotoViewerPageState();
}

class _PhotoViewerPageState extends State<PhotoViewerPage> {
  late BuildContext _buildContext;
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      appBar: visible
          ? AppBar(
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.white),
            )
          : null,
      // backgroundColor: primaryColor,
      body: InkWell(
        onLongPress: () {},
        onTap: () {
          setState(() {
            visible = !visible;
          });
        },
        child: PhotoView(
          // loadingBuilder: (context,event){
          //
          // },
          // imageProvider: widget.url!=null&& widget.url!=""?NetworkImage(widget.url):AssetImage("src/profile_avatar.png"),
          imageProvider: widget.local
              ? FileImage(File(widget.url))
              : NetworkImage(widget.url) as dynamic,
          errorBuilder: (context, object, stack) {
            return Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Image.asset("src/profile_avatar.png"));
          },
          // loadFailedChild: Container(color: Colors.black, alignment: Alignment.center,child: Image.asset("src/profile_avatar.png")),
        ),
      ),
    );
  }
}
