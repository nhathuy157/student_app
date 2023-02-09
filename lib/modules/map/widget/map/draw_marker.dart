import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

Future<BitmapDescriptor> createCustomMarkerBitmap(String title,
    {required TextStyle textStyle, required Color backgroundColor}) async {
  TextSpan span = TextSpan(
    style: textStyle,
    text: title,
  );
  TextPainter painter = TextPainter(
    text: span,
    textAlign: TextAlign.center,
    textDirection: ui.TextDirection.ltr,
    maxLines: 2,
  );
  painter.text = TextSpan(
    text: title.toString(),
    style: textStyle,
  );
  ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  Canvas canvas = Canvas(pictureRecorder);
  painter.layout();
  painter.paint(canvas, const Offset(20.0, 10.0));
  int textWidth = painter.width.toInt();
  int textHeight = painter.height.toInt();
  canvas.drawRRect(
      RRect.fromLTRBAndCorners(0, 0, textWidth + 40, textHeight + 20,
          bottomLeft: const Radius.circular(10),
          bottomRight: const Radius.circular(10),
          topLeft: const Radius.circular(10),
          topRight: const Radius.circular(10)),
      Paint()..color = backgroundColor);
  var arrowPath = Path();
  arrowPath.moveTo((textWidth + 40) / 2 - 15, textHeight + 20);
  arrowPath.lineTo((textWidth + 40) / 2, textHeight + 40);
  arrowPath.lineTo((textWidth + 40) / 2 + 15, textHeight + 20);
  arrowPath.close();
  canvas.drawPath(arrowPath, Paint()..color = backgroundColor);
  painter.layout();
  painter.paint(canvas, const Offset(20.0, 10.0));

  ui.Picture p = pictureRecorder.endRecording();
  ByteData? pngBytes = await (await p.toImage(
          painter.width.toInt() + 40, painter.height.toInt() + 50))
      .toByteData(format: ui.ImageByteFormat.png);
  Uint8List data = Uint8List.view(pngBytes!.buffer);
  return BitmapDescriptor.fromBytes(data);
}
