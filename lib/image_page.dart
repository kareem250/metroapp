import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class Images extends StatelessWidget {
  const Images({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('metro images'),
        backgroundColor: Color(0xFF42A5F5),
        centerTitle: true,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: AssetImage('assets/images/my.png'),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered,
        ),
      ),
    );
  }
}
