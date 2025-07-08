import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

class ImageDatabase {
  Future<void> saveImage(String id, Uint8List image) async {
    final box = await Hive.openBox(id);
    await box.put('key', image);
  }

  Future<void> deleteImage(String id) async {
    final box = await Hive.openBox(id);
    await box.clear();
  }

  Future<Uint8List?> getImage(String id) async {
    final box = await Hive.openBox(id);
    final image = await box.get('key');
    return image;
  }
}
