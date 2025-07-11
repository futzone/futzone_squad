import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

Future<void> savePng(Uint8List pngBytes, String fileName) async {
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/$fileName.png';
  final file = File(path);
  await file.writeAsBytes(pngBytes);
  print('Saved to $path');
}
