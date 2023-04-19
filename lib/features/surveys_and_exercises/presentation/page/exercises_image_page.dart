import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  final String path;
  const ImagePage({Key? key, required this.path}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: EdgeInsets.all(double.infinity),
          minScale: 1,
          maxScale: 2.5,
          child: Image.asset(path),
        ),
      ),
    );
  }
}
