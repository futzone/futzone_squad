import 'dart:ui';

import 'package:futzone_squad/core/models/player.dart';

class PositionedPlayer {
  Player player;
  Offset position;

  PositionedPlayer({required this.player, required this.position});

  PositionedPlayer copyWith({Player? player, Offset? position}) {
    return PositionedPlayer(player: player ?? this.player, position: position ?? this.position);
  }

  static final topGK = PositionedPlayer(player: Player.defaultPlayer(1), position: Offset(160, 480));
  static final bottomGK = PositionedPlayer(player: Player.defaultPlayer(1), position: Offset(160, 500));
}
