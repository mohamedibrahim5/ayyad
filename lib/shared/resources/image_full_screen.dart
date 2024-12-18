import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class NetworkImageViewerScreen extends StatelessWidget {
  final String imageUrl;
  final bool fileImage  ;

  const NetworkImageViewerScreen({super.key, required this.imageUrl,this.fileImage = false});

  @override
  Widget build(BuildContext context) {
    return fileImage ?
    PhotoView(
      filterQuality: FilterQuality.high,
      imageProvider:FileImage(File(imageUrl)) ,
    ) : PhotoView(
      filterQuality: FilterQuality.high,
      imageProvider:NetworkImage(imageUrl) ,
    );
  }
}
