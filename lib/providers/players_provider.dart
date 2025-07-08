import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futzone_squad/core/database/players_database.dart';

final playersProvider = FutureProvider((ref) async {
  final PlayersDatabase playersDatabase = PlayersDatabase();
  return await playersDatabase.getPlayers();
});
