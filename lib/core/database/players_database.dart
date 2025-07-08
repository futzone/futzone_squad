import 'package:futzone_squad/core/models/player.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class PlayersDatabase {
  Future<Box> _openBox() async {
    final Box box = await Hive.openBox('players');
    return box;
  }

  Future<void> save(Player player) async {
    var box = await _openBox();
    Player newPlayer = player;
    if (newPlayer.id.isEmpty) newPlayer.id == Uuid().v4();
    await box.put(player.id, player.toJson());
  }

  Future<void> delete(String id) async {
    var box = await _openBox();
    await box.delete(id);
  }

  Future<List<Player>> getPlayers() async {
    var box = await _openBox();

    final List<Player> list = [];
    for (final item in box.values) {
      try {
        list.add(Player.fromJson(item));
      } catch (e) {
        ///
      }
    }

    return list;
  }
}
