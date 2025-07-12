import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futzone_squad/core/config/app_theme.dart';
import 'package:futzone_squad/core/constants/templates.dart';
import 'package:futzone_squad/core/extensions/double.dart';
import 'package:futzone_squad/core/models/player.dart';
import 'package:futzone_squad/providers/players_provider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../core/config/app_fonts.dart';
import '../../core/config/app_router.dart';
import '../../core/utils/image_saver.dart';
import '../../providers/image_provider.dart';
import '../pages/main_page.dart';
import '../widgets/app_loading_widget.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_toast_widgets.dart';

class FifaCardScreen extends StatefulWidget {
  const FifaCardScreen({super.key});

  @override
  State<FifaCardScreen> createState() => _FifaCardScreenState();
}

class _FifaCardScreenState extends State<FifaCardScreen> {
  Template _template = Template.values.first;
  final ScreenshotController _screenshotController = ScreenshotController();
  final theme = AppColors();
  Player? _player;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FIFA Player Card")),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            24.h,
            PopupMenuButton(
              child: IgnorePointer(
                ignoring: true,
                child: AppTextField(
                  title: "Card template",
                  onlyRead: true,
                  controller: TextEditingController(text: "Template ${_template.id}"),
                  theme: theme,
                ),
              ),
              itemBuilder:
                  (context) => [
                    for (final item in Template.values)
                      PopupMenuItem(
                        child: Row(
                          children: [
                            Image.asset(item.path, height: 48, width: 48),
                            Expanded(child: Text(item.id.toMeasure)),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            _template = item;
                          });
                        },
                      ),
                  ],
            ),
            24.h,
            Consumer(
              builder: (context, ref, child) {
                return ref
                    .watch(playersProvider)
                    .when(
                      error: (error, st) => AppLoadingScreen(),
                      loading: () => AppLoadingScreen(),
                      data: (players) {
                        return PopupMenuButton(
                          child: IgnorePointer(
                            ignoring: true,
                            child: AppTextField(
                              title: "O'yinchini tanlang",
                              controller: TextEditingController(text: _player?.fullname),
                              theme: theme,
                              onlyRead: true,
                            ),
                          ),
                          itemBuilder:
                              (context) => [
                                for (final item in players)
                                  PopupMenuItem(
                                    child: Row(
                                      children: [
                                        PlayerImageScreen(item, theme, 48, 16),
                                        Expanded(child: Text(item.fullname)),
                                      ],
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _player = item;
                                      });
                                    },
                                  ),
                              ],
                        );
                      },
                    );
              },
            ),

            24.h,
            if (_player != null)
              Screenshot(
                controller: _screenshotController,
                child: Stack(

                  children: [
                    Container(
                      width: 400,
                      height: 560,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(_template.path), fit: BoxFit.cover),

                        ///
                      ),
                      padding: EdgeInsets.only(left: 44, right: 44, top: 64, bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Row(
                              spacing: 10,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ///
                                      Text(
                                        _player!.score.toString(),
                                        style: TextStyle(
                                          fontSize: 32,
                                          fontFamily: boldFamily,
                                          fontWeight: FontWeight.w900,
                                          color: _template.color,
                                        ),
                                      ),
                                      Container(
                                        margin: 4.tb,
                                        width: 48,
                                        height: 2,
                                        color: _template.color.withValues(alpha: 0.2),
                                      ),

                                      Text(
                                        _player!.position.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: mediumFamily,
                                          fontWeight: FontWeight.bold,
                                          color: _template.color,
                                        ),
                                      ),

                                      Container(
                                        margin: 4.tb,
                                        width: 48,
                                        height: 2,
                                        color: _template.color.withValues(alpha: 0.2),
                                      ),
                                      Flag(_player?.country, size: 48),
                                      Container(
                                        margin: 4.tb,
                                        width: 48,
                                        height: 2,
                                        color: _template.color.withValues(alpha: 0.2),
                                      ),
                                      Brand(_player!.club, size: 48),
                                      8.h,
                                    ],
                                  ),
                                ),
                                Expanded(flex: 5, child: PlayerImageScreen(_player!, theme, 220, 16)),

                                ///
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                12.h,
                                Center(
                                  child: Text(
                                    _player!.fullname.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: mediumFamily,
                                      color: _template.color,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 2,
                                  color: _template.color.withValues(alpha: 0.2),
                                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                                ),
                                8.h,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    24.w,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_player!.pac} PAC",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: _template.color,
                                            ),
                                          ),
                                          Text(
                                            "${_player!.pas} PAS",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: _template.color,
                                            ),
                                          ),
                                          Text(
                                            "${_player!.sho} SHO",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: _template.color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 2,
                                      height: 80,
                                      // height: double.infinity,
                                      color: _template.color.withValues(alpha: 0.2),
                                      // margin: EdgeInsets.symmetric(vertical: 4, horizontal: 24),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_player!.dri} DRI",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: _template.color,
                                            ),
                                          ),
                                          Text(
                                            "${_player!.def} DEF",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: _template.color,
                                            ),
                                          ),
                                          Text(
                                            "${_player!.phy} PHY",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: _template.color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    24.w,
                                  ],
                                ),

                                ///
                              ],
                            ),
                          ),

                          ///
                        ],
                      ),
                    ),
                    Positioned(
                      // top: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text("squad.futzone.uz", style: TextStyle(color: Colors.black54))],
                      ),
                    ),
                  ],
                ),
              ),
            24.h,
            if (_player != null)
              MaterialButton(
                onPressed: () async {
                  showAppLoadingDialog(context);
                  if (kIsWeb) {
                    final bytes = await _screenshotController.capture();
                    if (bytes == null) return;

                    await savePng(bytes, DateTime.now().millisecondsSinceEpoch.toString()).then((_) {
                      AppRouter.close(context);
                      ShowToast.success(context, "Saqlandi!");
                      AppRouter.open(context, MainPage());
                    });
                    return;
                  }

                  final dir = await getApplicationDocumentsDirectory();
                  await _screenshotController.captureAndSave(dir.path, pixelRatio: 2).then((_) {
                    AppRouter.close(context);
                    ShowToast.success(context, "Saqlandi!");
                    AppRouter.open(context, MainPage());
                  });
                },
                padding: EdgeInsets.only(left: 48, right: 48, top: 16, bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                color: theme.mainColor,
                child: Row(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.save, color: Colors.white, size: 20),
                    Text(
                      "Rasmni saqlash",
                      style: TextStyle(
                        fontFamily: mediumFamily,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PlayerImageScreen extends ConsumerWidget {
  final Player player;
  final AppColors theme;
  final double size;
  final double radius;

  const PlayerImageScreen(this.player, this.theme, this.size, this.radius, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(imageProvider(player.image ?? player.id))
        .when(
          data: (imageBytes) {
            if (imageBytes == null) {
              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  // border: Border.all(color: theme.secondaryTextColor),
                  color: Colors.transparent,
                ),
                child: Center(child: Icon(Icons.person, size: size)),
              );
            }
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                image: DecorationImage(image: MemoryImage(imageBytes), fit: BoxFit.cover),
                // border: Border.all(color: theme.secondaryTextColor),
                color: Colors.transparent,
              ),
            );
          },
          error: (e, s) {
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                // border: Border.all(color: theme.secondaryTextColor),
                color: Colors.transparent,
              ),
              child: Center(child: Icon(Icons.person, size: size)),
            );
          },
          loading: () => const AppLoadingScreen(),
        );
  }
}
