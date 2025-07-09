import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futzone_squad/core/config/app_theme.dart';
import 'package:futzone_squad/core/constants/schemas.dart';
import 'package:futzone_squad/providers/players_provider.dart';

import '../../core/models/player.dart';
import '../../core/models/positioned_player.dart';
import '../../providers/image_provider.dart';
import '../widgets/app_loading_widget.dart';

class SchemeScreen extends HookWidget {
  final String scheme;
  final String count;
  final String cardType;
  final AppColors theme;

  const SchemeScreen({
    super.key,
    required this.cardType,
    required this.scheme,
    required this.count,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final players = useState(ValueNotifier<List<PositionedPlayer>>([]));

    final formations = Schemas().generateOffsets(count, 400, 600);

    useEffect(() {
      players.value.value = [
        PositionedPlayer.bottomGK,
        ...List.generate(formations.length, (index) {
          return PositionedPlayer(player: Player.defaultPlayer(index + 2), position: formations[index]);
        }),
      ];

      return () {};
    });

    return Consumer(
      builder: (context, ref, child) {
        final playersList = ref.watch(playersProvider).value ?? [];

        return DragTarget<PositionedPlayer>(
          onAcceptWithDetails: (details) {
            final renderBox = context.findRenderObject() as RenderBox;
            final localOffset = renderBox.globalToLocal(details.offset);
            details.data.position = localOffset;
          },
          builder:
              (context, candidateData, rejectedData) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/soccer field background 1003.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: 400,
                height: 620,
                child: Stack(
                  children:
                      players.value.value.map((posPlayer) {
                        return Positioned(
                          left: posPlayer.position.dx,
                          top: posPlayer.position.dy,
                          child: PopupMenuButton<Player>(
                            onSelected: (selectedPlayer) {
                              final playerIndex = players.value.value.indexWhere(
                                (el) => el.player.number == posPlayer.player.number,
                              );
                              if (playerIndex == -1) return;

                              players.value.value = [
                                ...players.value.value
                                  ..[playerIndex] = PositionedPlayer(
                                    player: selectedPlayer,
                                    position: posPlayer.position,
                                  ),
                              ];
                            },
                            itemBuilder: (context) {
                              return [
                                for (final item in playersList)
                                  PopupMenuItem(value: item, child: Text("${item.number}.${item.fullname}")),
                              ];
                            },
                            child: Draggable<PositionedPlayer>(
                              data: posPlayer,
                              feedback: _buildPlayerIcon(posPlayer.player, ref),
                              childWhenDragging: Opacity(opacity: 0.5, child: _buildPlayerIcon(posPlayer.player, ref)),
                              child: _buildPlayerIcon(posPlayer.player, ref),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
        );
      },
    );
  }

  Widget _buildPlayerIcon(Player player, ref) {
    log(player.id);
     return Container(
      height: 100,
      width: 80,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/145_fut_immortals_hero.png"), fit: BoxFit.cover),
      ),

      child:
          player.id.isEmpty
              ? null
              : Column(
                children: [
                  ref
                      .watch(imageProvider(player.image ?? player.id))
                      .when(
                        data: (imageBytes) {
                          if (imageBytes == null) {
                            return Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                // image: DecorationImage(image: MemoryImage(imageBytes)),
                                border: Border.all(color: theme.secondaryTextColor),
                              ),
                              child: Center(child: Icon(Icons.person, size: 64)),
                            );
                          }
                          return Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(image: MemoryImage(imageBytes)),
                              border: Border.all(color: theme.secondaryTextColor),
                            ),
                          );
                        },
                        error: (e, s) {
                          return Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              // image: DecorationImage(image: MemoryImage(imageBytes)),
                              border: Border.all(color: theme.secondaryTextColor),
                            ),
                            child: Center(child: Icon(Icons.person, size: 64)),
                          );
                        },
                        loading: () => AppLoadingScreen(),
                      ),
                ],
              ),
    );
  }
}
