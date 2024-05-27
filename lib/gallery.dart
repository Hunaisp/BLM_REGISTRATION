import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  // List of asset paths
  final List<String> assetPaths = [
    'assets/b1.jpg',
    'assets/b2.jpeg',
    'assets/b3.jpeg',
    'assets/b4.jpeg',
    'assets/b5.jpeg',
    'assets/b6.jpg',
    'assets/b7.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF54B435),
        centerTitle: true,
        title: Text('Photo Gallery'),
      ),
      body: ListView.builder(
        itemCount: assetPaths.length,
        itemBuilder: (context, index) {
          // Large images
          if (index % 4 == 0) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: FullWidthImage(imagePath: assetPaths[index]),
            );
          }
          // Small images
          else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
              child: HalfWidthImage(imagePath: assetPaths[index]),
            );
          }
        },
      ),
    );
  }
}

class FullWidthImage extends StatelessWidget {
  final String imagePath;

  FullWidthImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}

class HalfWidthImage extends StatelessWidget {
  final String imagePath;

  HalfWidthImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Image.asset(imagePath, fit: BoxFit.cover),
    );
  }
}
