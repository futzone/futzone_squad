import 'package:flutter/material.dart';
import 'package:futzone_squad/core/config/app_fonts.dart';
import 'package:futzone_squad/core/config/app_router.dart';
import 'package:futzone_squad/core/extensions/device_type.dart';
import 'package:futzone_squad/core/extensions/double.dart';
import 'package:futzone_squad/ui/pages/players_page.dart';
import 'package:futzone_squad/ui/pages/team_page.dart';
import 'package:futzone_squad/ui/widgets/app_theme_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../screens/fifa_card_screen.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressedPlayers() => AppRouter.go(context, PlayersPage());
    void onPressedTeam() => AppRouter.go(context, TeamPage());
    void onPressedCard() => AppRouter.go(context, FifaCardScreen());

    return AppThemeBuilder(
      builder: (theme) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Futzone Squad Maker", style: TextStyle(fontFamily: boldFamily)),
            actions: [
              IconButton(
                onPressed: () async {
                  await launchUrlString('https://t.me/qahorovz');
                },
                icon: Icon(Icons.telegram_outlined),
              ),
              8.w,
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (context.isDesktop)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 24,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          padding: EdgeInsets.only(top: 48, bottom: 48, left: 40, right: 40),
                          color: theme.accentColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          onPressed: onPressedCard,
                          child: Column(
                            spacing: 12,
                            children: [
                              Image.asset("assets/images/img.png", height: 200),
                              Text(
                                "Player FIFA CARD",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: mediumFamily,
                                  color: theme.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          padding: EdgeInsets.only(top: 48, bottom: 48, left: 40, right: 40),
                          color: theme.accentColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          onPressed: onPressedTeam,
                          child: Column(
                            spacing: 12,
                            children: [
                              Image.asset(
                                "assets/images/soccer field background 1003.jpg",
                                height: 200,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Text(
                                "Jamoa tuzish",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: mediumFamily,
                                  color: theme.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          padding: EdgeInsets.only(top: 48, bottom: 48, left: 40, right: 40),
                          color: theme.accentColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          onPressed: onPressedPlayers,
                          child: Column(
                            spacing: 12,
                            children: [
                              Image.asset(
                                "assets/images/img_1.png",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "Futbolchilar",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: mediumFamily,
                                  color: theme.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              if (context.isTablet)
                Expanded(
                  child: GridView(
                    padding: 24.all,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                    ),
                    children: [
                      MaterialButton(
                        padding: EdgeInsets.only(top: 48, bottom: 48, left: 40, right: 40),
                        color: theme.accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        onPressed: onPressedCard,
                        child: Column(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: Image.asset(
                                "assets/images/img.png",
                                height: double.infinity,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Text(
                              "Player FIFA CARD",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: mediumFamily,
                                color: theme.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        padding: EdgeInsets.only(top: 48, bottom: 48, left: 40, right: 40),
                        color: theme.accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        onPressed: onPressedTeam,
                        child: Column(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: Image.asset(
                                "assets/images/soccer field background 1003.jpg",
                                height: double.infinity,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Text(
                              "Jamoa tuzish",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: mediumFamily,
                                color: theme.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        padding: EdgeInsets.only(top: 48, bottom: 48, left: 40, right: 40),
                        color: theme.accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        onPressed: onPressedPlayers,
                        child: Column(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: Image.asset(
                                "assets/images/img_1.png",
                                height: double.infinity,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Text(
                              "Futbolchilar",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: mediumFamily,
                                color: theme.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              if (context.isMobile)
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 24,
                      children: [
                        MaterialButton(
                          padding: EdgeInsets.only(top: 48, bottom: 48, left: 40, right: 40),
                          color: theme.accentColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          onPressed: onPressedCard,
                          child: Column(
                            spacing: 12,
                            children: [
                              Image.asset(
                                "assets/images/img.png",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "Player FIFA CARD",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: mediumFamily,
                                  color: theme.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          padding: EdgeInsets.only(top: 48, bottom: 48, left: 40, right: 40),
                          color: theme.accentColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          onPressed: onPressedTeam,
                          child: Column(
                            spacing: 12,
                            children: [
                              Image.asset(
                                "assets/images/soccer field background 1003.jpg",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "Jamoa tuzish",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: mediumFamily,
                                  color: theme.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                          padding: EdgeInsets.only(top: 48, bottom: 48, left: 40, right: 40),
                          color: theme.accentColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          onPressed: onPressedPlayers,
                          child: Column(
                            spacing: 12,
                            children: [
                              Image.asset(
                                "assets/images/img_1.png",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "Futbolchilar",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: mediumFamily,
                                  color: theme.textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        20.h,
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
