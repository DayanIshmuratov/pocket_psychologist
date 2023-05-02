import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImagePage extends StatelessWidget {
  final String path;
  const ImagePage({Key? key, required this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: Container(
        child: PhotoView(imageProvider: AssetImage(path),
        ),
      ),
      
      // InteractiveViewer(
      //   boundaryMargin: EdgeInsets.all(double.infinity),
      //   minScale: 1,
      //   maxScale: 2.5,
      //   child: Image.asset(path),
      // ),
    );
  }
}
