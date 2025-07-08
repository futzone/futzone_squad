import 'package:futzone_squad/core/database/images_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageProvider = FutureProvider.family((ref, String id) async {
  ImageDatabase imageDatabase = ImageDatabase();
  return await imageDatabase.getImage(id);
});
