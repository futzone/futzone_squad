import 'dart:typed_data';
import 'save_image_web.dart' as saw;

Future<void> savePng(Uint8List pngBytes, String fileName) async {
  await saw.savePng(pngBytes, fileName);
}
