import 'package:flutter/material.dart';

class ImageBox extends StatelessWidget {
  ImageBox(this.image, this.height);

  final ImageProvider<Object> image;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: image,
          ),
          boxShadow: <BoxShadow>[BoxShadow(blurRadius: 30, spreadRadius: 7, color: Colors.black38)],
        ));
  }
}
