// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:async';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'dart:math' as ma;
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;

class BitmapDescriptorHelper {
  static Future<Uint8List> getBytesFromAsset(String path, int width,) async {
    ByteData data = await rootBundle.load(path);
    // double aspectRatio = sl<NavigationService>().navigationKey.currentContext?.size?.aspectRatio??0.0;
    // debugPrint('${aspectRatio} int.tryParse((width.w).toString())' );
    // debugPrint('${ui.window.display.size} int.tryParse((width.w).toString())' );
    // debugPrint('${ui.window.display.size.width} int.tryParse((width.w).toString())' );
    // debugPrint('${ui.window.display.size.height} int.tryParse((width.w).toString())' );
    double aspectRatio = ui.window.devicePixelRatio;
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),

      targetWidth:aspectRatio.round() * 10/*int.tryParse(((width.w)/devicePixelRatio).toString())*/ /*int.tryParse(width.h.toString())*/);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // static Future<BitmapDescriptor> getBitmapDescriptorFromSvgAsset(
  //   String assetName, [
  //   Size size = const Size(38, 38),
  // ]) async {
  //   final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);
  //
  //   double devicePixelRatio = ui.window.devicePixelRatio;
  //   int width = (size.width * devicePixelRatio).toInt();
  //   int height = (size.height * devicePixelRatio).toInt();
  //
  //   final scaleFactor = ma.min(
  //     width / pictureInfo.size.width,
  //     height / pictureInfo.size.height,
  //   );
  //
  //   final recorder = ui.PictureRecorder();
  //
  //   ui.Canvas(recorder)
  //     ..scale(scaleFactor)
  //     ..drawPicture(pictureInfo.picture);
  //
  //   final rasterPicture = recorder.endRecording();
  //
  //   final image = rasterPicture.toImageSync(width, height);
  //   final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;
  //
  //   return BitmapDescriptor.bytes(bytes.buffer.asUint8List());
  // }

  // static Future<BitmapDescriptor> getBitmapDescriptorFromAsset(
  //
  //   String assetName, [
  //   Size size = const Size(60, 60),
  // ]) async {
  //   ByteData pictureInfo = await rootBundle.load(assetName);
  //
  //   return BitmapDescriptor.fromBytes(pictureInfo.buffer.asUint8List(),
  //       size: size);
  // }
  //
  // static Future<ui.Image> _getSizedSvgImage(ui.Image svgImage) async {
  //   final size = 50 * ui.window.devicePixelRatio;
  //   final width = size;
  //   final height = width;
  //
  //   final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  //   final Canvas canvas = Canvas(pictureRecorder);
  //   final Rect svgRect = Rect.fromLTRB(
  //       0.0, 0.0, svgImage.width.toDouble(), svgImage.height.toDouble());
  //   final Rect sizedRect =
  //       Rect.fromLTRB(0.0, 0.0, width, height); // owr size here
  //   canvas.drawImageRect(svgImage, svgRect, sizedRect, Paint());
  //   return await pictureRecorder
  //       .endRecording()
  //       .toImage(width.toInt(), height.toInt());
  // }
}
