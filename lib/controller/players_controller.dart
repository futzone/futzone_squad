import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futzone_squad/core/config/app_router.dart';
import 'package:futzone_squad/core/database/images_database.dart';
import 'package:futzone_squad/core/database/players_database.dart';
import 'package:futzone_squad/core/models/player.dart';
import 'package:futzone_squad/providers/players_provider.dart';
import 'package:futzone_squad/ui/widgets/app_loading_widget.dart';
import 'package:uuid/uuid.dart';

import '../core/services/image_compressor.dart';

class PlayersController {
  final BuildContext context;
  final WidgetRef ref;

  PlayersController({required this.ref, required this.context});

  final PlayersDatabase _database = PlayersDatabase();
  final ImageDatabase _imageDatabase = ImageDatabase();

  Future<String?> _saveImage(String id, image) async {
    // _imageDatabase.deleteImage(id);

    final compressed = compressImage(image);
    await _imageDatabase.saveImage(id, compressed);
    return id;
  }

  void createPlayer({
    required String name,
    required dynamic image,
    required String club,
    required String country,
    required String position,
    required String number,
    required String pac,
    required String sho,
    required String dri,
    required String pas,
    required String def,
    required String phy,
  }) async {
    showAppLoadingDialog(context);
    final id = Uuid().v4();

    Player player = Player(
      club: club,
      country: country,
      image: await _saveImage(id, image),
      id: id,
      fullname: name,
      position: position,
      number: int.tryParse(number) ?? 13,
      pac: int.tryParse(pac) ?? 50,
      sho: int.tryParse(sho) ?? 50,
      pas: int.tryParse(pas) ?? 50,
      dri: int.tryParse(dri) ?? 50,
      def: int.tryParse(def) ?? 50,
      phy: int.tryParse(phy) ?? 50,
      score:
          (((int.tryParse(pac) ?? 50) +
                      (int.tryParse(pas) ?? 50) +
                      (int.tryParse(sho) ?? 50) +
                      (int.tryParse(dri) ?? 50) +
                      (int.tryParse(def) ?? 50) +
                      (int.tryParse(phy) ?? 50)) /
                  6)
              .round(),
    );

    await _database.save(player).then((val) {
      AppRouter.close(context);
      ref.invalidate(playersProvider);
      ref.refresh(playersProvider);
      AppRouter.close(context);
    });
  }

  void updatePlayer({
    required String id,
    required String name,
    required dynamic image,
    required String club,
    required String country,
    required String position,
    required String number,
    required String pac,
    required String sho,
    required String dri,
    required String pas,
    required String def,
    required String phy,
  }) async {
    showAppLoadingDialog(context);

    Player updatedPlayer = Player(
      id: id,
      fullname: name,
      image: await _saveImage(id, image),
      club: club,
      country: country,
      position: position,
      number: int.tryParse(number) ?? 13,
      pac: int.tryParse(pac) ?? 50,
      sho: int.tryParse(sho) ?? 50,
      pas: int.tryParse(pas) ?? 50,
      dri: int.tryParse(dri) ?? 50,
      def: int.tryParse(def) ?? 50,
      phy: int.tryParse(phy) ?? 50,
      score:
          (((int.tryParse(pac) ?? 50) +
                      (int.tryParse(pas) ?? 50) +
                      (int.tryParse(sho) ?? 50) +
                      (int.tryParse(dri) ?? 50) +
                      (int.tryParse(def) ?? 50) +
                      (int.tryParse(phy) ?? 50)) /
                  6)
              .round(),
    );

    await _database.save(updatedPlayer).then((val) {
      AppRouter.close(context);
      ref.invalidate(playersProvider);
      ref.refresh(playersProvider);
      AppRouter.close(context);
    });
  }

  void deletePlayer(String id) async {
    showAppLoadingDialog(context);

    await _database.delete(id).then((val) {
      AppRouter.close(context);
      ref.invalidate(playersProvider);
      ref.refresh(playersProvider);
      AppRouter.close(context);
    });
  }
}
