 import 'package:image/image.dart' as img;
 import 'package:flutter/services.dart';

Uint8List compressImage(Uint8List originalBytes, {int height = 300, int width = 300, int quality = 60}) {
  final image = img.decodeImage(originalBytes);
  if (image == null) return originalBytes;

  final resized = img.copyResize(image, width: width, height: height);

  return Uint8List.fromList(img.encodeJpg(resized, quality: quality));
}
