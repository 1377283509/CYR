
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:photo_view/photo_view.dart';

class ImagePage extends StatefulWidget {
  final File image;

  ImagePage(this.image);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PhotoView(
            imageProvider: FileImage(widget.image),
          )
      ),
    );
  }
}
