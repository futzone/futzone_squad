import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futzone_squad/core/config/app_fonts.dart';
import 'package:futzone_squad/core/config/app_theme.dart';
import 'package:futzone_squad/core/constants/schemas.dart';
import 'package:futzone_squad/core/constants/templates.dart';
import 'package:futzone_squad/providers/players_provider.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core/models/player.dart';
import '../../core/models/positioned_player.dart';
import '../../providers/image_provider.dart';
import '../widgets/app_loading_widget.dart';

class SchemeScreen extends HookWidget {
  final String scheme;
  final String count;
  final String cardType;
  final AppColors theme;
  final Template template;

  const SchemeScreen({
    super.key,
    required this.template,
    required this.cardType,
    required this.scheme,
    required this.count,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final players = useState<List<PositionedPlayer>>([]);
    final formations = Schemas().generateOffsets(count, scheme, 400, 600);

    useEffect(() {
      players.value = [
        PositionedPlayer.bottomGK,
        ...List.generate(formations.length, (index) {
          return PositionedPlayer(player: Player.defaultPlayer(index + 2), position: formations[index]);
        }),
      ];

      return () {};
    }, [scheme, count]);

    return Consumer(
      builder: (context, ref, child) {
        return DragTarget<PositionedPlayer>(
          onAcceptWithDetails: (details) {
            final renderBox = context.findRenderObject() as RenderBox;
            final localOffset = renderBox.globalToLocal(details.offset);

            final currentList = players.value;
            final playerToMove = details.data;

            final index = currentList.indexWhere((p) => p == playerToMove);
            if (index != -1) {
              final newList = List<PositionedPlayer>.from(currentList);

              newList[index] = newList[index].copyWith(position: localOffset);
              players.value = newList;
            }
          },
          builder: (context, candidateData, rejectedData) {
            return ref
                .watch(playersProvider)
                .when(
                  error: (error, st) => const SizedBox(),
                  loading: () => const SizedBox(),
                  data: (playersList) {
                    return Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/soccer field background 1003.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 400,
                      height: 620,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 4,
                            left: 0,
                            right: 0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("squad.futzone.uz", style: TextStyle(color: Colors.white54))],
                            ),
                          ),
                          ...players.value.map((posPlayer) {
                            return Positioned(
                              left: posPlayer.position.dx,
                              top: posPlayer.position.dy,
                              child: PopupMenuButton<Player>(
                                onSelected: (selectedPlayer) {
                                  final currentList = players.value;
                                  final index = currentList.indexOf(posPlayer);

                                  if (index != -1) {
                                    final newList = List<PositionedPlayer>.from(currentList);
                                    newList[index] = PositionedPlayer(
                                      player: selectedPlayer,
                                      position: posPlayer.position,
                                    );

                                    players.value = newList;
                                  }
                                },
                                itemBuilder: (context) {
                                  final kPlayers = playersList.where(
                                    (el) => players.value.where((item) => item.player.id == el.id).isEmpty,
                                  );

                                  return [
                                    for (final item in kPlayers)
                                      PopupMenuItem(value: item, child: Text("${item.number}.${item.fullname}")),
                                  ];
                                },
                                child: Draggable<PositionedPlayer>(
                                  data: posPlayer,
                                  feedback: _buildPlayerIcon(posPlayer.player, ref),
                                  childWhenDragging: Opacity(
                                    opacity: 0.5,
                                    child: _buildPlayerIcon(posPlayer.player, ref),
                                  ),
                                  child: _buildPlayerIcon(posPlayer.player, ref),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                );
          },
        );
      },
    );
  }

  Widget _buildPlayerIcon(Player player, WidgetRef ref) {
    log("Building icon for: ${player.fullname} num: ${player.number}");
    return Container(
      height: 100,
      width: 80,
      padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(template.path), fit: BoxFit.cover)),
      child:
          player.id.isEmpty
              ? null
              : Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              player.score.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: boldFamily,
                                color: template.color,
                              ),
                            ),

                            Flag(player.country, size: 18),
                            Brand(player.club, size: 18),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: ref
                            .watch(imageProvider(player.image ?? player.id))
                            .when(
                              data: (imageBytes) {
                                if (imageBytes == null) {
                                  return Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      // border: Border.all(color: theme.secondaryTextColor),
                                    ),
                                    child: const Center(child: Icon(Icons.person, size: 64)),
                                  );
                                }
                                return Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(image: MemoryImage(imageBytes), fit: BoxFit.cover),
                                    border: Border.all(color: theme.secondaryTextColor),
                                  ),
                                );
                              },
                              error: (e, s) {
                                return Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: theme.secondaryTextColor),
                                  ),
                                  child: const Center(child: Icon(Icons.person, size: 64)),
                                );
                              },
                              loading: () => const AppLoadingScreen(),
                            ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Text(
                      player.fullname,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: regularFamily,
                        fontWeight: FontWeight.bold,
                        color: template.color,
                      ),
                    ),
                  ),
                  // Text(player.fullname),
                ],
              ),
    );
  }
}
