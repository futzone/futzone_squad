import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futzone_squad/controller/players_controller.dart';
import 'package:futzone_squad/core/config/app_fonts.dart';
import 'package:futzone_squad/core/config/app_router.dart';
import 'package:futzone_squad/core/config/app_theme.dart';
import 'package:futzone_squad/core/extensions/double.dart';
import 'package:futzone_squad/core/models/player.dart';
import 'package:futzone_squad/providers/image_provider.dart';
import 'package:futzone_squad/providers/players_provider.dart';
import 'package:futzone_squad/ui/widgets/app_loading_widget.dart';
import 'package:futzone_squad/ui/widgets/app_theme_builder.dart';
import 'package:icons_plus/icons_plus.dart';

import '../screens/add_player_screen.dart';

class PlayersPage extends ConsumerWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return AppThemeBuilder(
      builder: (theme) {
        return Scaffold(
          appBar: AppBar(title: Text("Futbolchilar", style: TextStyle(fontFamily: boldFamily))),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AppRouter.go(context, AddPlayerScreen(ref: ref));
            },
            backgroundColor: theme.accentColor,
            child: Icon(Icons.add, size: 32, color: theme.mainColor),
          ),

          body: ref
              .watch(playersProvider)
              .when(
                data: (players) {
                  if (players.isEmpty) {
                    return Center(child: Text("Futbolchilar mavjud emas :("));
                  }

                  return ListView.builder(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
                    itemCount: players.length,
                    itemBuilder: (context, index) {
                      return PlayerCard(player: players[index], theme: theme);
                    },
                  );
                },
                error: (error, stackTrace) {
                  return Text("$error $stackTrace");
                },
                loading: () {
                  return AppLoadingScreen();
                },
              ),
        );
      },
    );
  }
}

class PlayerCard extends ConsumerWidget {
  final Player player;
  final AppColors theme;

  const PlayerCard({super.key, required this.player, required this.theme});

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: PopupMenuButton(
        // padding: 16.bottom,
        itemBuilder:
            (context) => [
              PopupMenuItem(
                child: Row(spacing: 8, children: [Icon(Iconsax.edit_outline), Text("Tahrirlash")]),
                onTap: () {
                  AppRouter.go(context, AddPlayerScreen(ref: ref, player: player));
                },
              ),
              PopupMenuItem(
                child: Row(spacing: 8, children: [Icon(Iconsax.trash_outline, color: Colors.red), Text("O'chirish")]),
                onTap: () {
                  PlayersController controller = PlayersController(ref: ref, context: context);
                  controller.deletePlayer(player.id);
                },
              ),
            ],
        child: Container(
          padding: 12.all,
          // margin: 16.bottom,
          decoration: BoxDecoration(
            color: theme.cardColor,
            boxShadow: [
              BoxShadow(color: Colors.grey.withAlpha(100), blurRadius: 3, spreadRadius: 1.5, offset: Offset(-2, 2)),
            ],

            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            spacing: 16,
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

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Row(
                      children: [
                        Text(
                          player.number.toString(),
                          style: TextStyle(color: theme.mainColor, fontSize: 15, fontFamily: boldFamily),
                        ),
                        Expanded(
                          child: Text(
                            ".${player.fullname} (${player.position})",
                            style: TextStyle(fontFamily: boldFamily, color: theme.textColor),
                          ),
                        ),

                        12.w,
                        Flag(player.country, size: 24),
                        8.w,
                        Brand(player.club, size: 24),
                      ],
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      spacing: 8,
                      runSpacing: 8,
                      direction: Axis.horizontal,

                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("SCORE: ", style: TextStyle(fontFamily: mediumFamily)),
                            Text(
                              player.score.toString(),
                              style: TextStyle(fontFamily: boldFamily, color: theme.mainColor),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("PAC: ", style: TextStyle(fontFamily: mediumFamily)),
                            Text(
                              player.pac.toString(),
                              style: TextStyle(fontFamily: boldFamily, color: theme.mainColor),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("PHY: ", style: TextStyle(fontFamily: mediumFamily)),
                            Text(
                              player.phy.toString(),
                              style: TextStyle(fontFamily: boldFamily, color: theme.mainColor),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("PAS: ", style: TextStyle(fontFamily: mediumFamily)),
                            Text(
                              player.pas.toString(),
                              style: TextStyle(fontFamily: boldFamily, color: theme.mainColor),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("DEF: ", style: TextStyle(fontFamily: mediumFamily)),
                            Text(
                              player.def.toString(),
                              style: TextStyle(fontFamily: boldFamily, color: theme.mainColor),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("SHO: ", style: TextStyle(fontFamily: mediumFamily)),
                            Text(
                              player.sho.toString(),
                              style: TextStyle(fontFamily: boldFamily, color: theme.mainColor),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("DRI: ", style: TextStyle(fontFamily: mediumFamily)),
                            Text(
                              player.dri.toString(),
                              style: TextStyle(fontFamily: boldFamily, color: theme.mainColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
