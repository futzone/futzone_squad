import 'package:flutter/material.dart';
import 'package:futzone_squad/core/config/app_fonts.dart';
import 'package:futzone_squad/core/config/app_router.dart';
import 'package:futzone_squad/core/extensions/device_type.dart';
import 'package:futzone_squad/core/extensions/double.dart';
import 'package:futzone_squad/ui/pages/players_page.dart';
import 'package:futzone_squad/ui/pages/team_page.dart';
import 'package:futzone_squad/ui/widgets/app_theme_builder.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressedPlayers() => AppRouter.go(context, PlayersPage());
    void onPressedTeam() => AppRouter.go(context, TeamPage());

    return AppThemeBuilder(
      builder: (theme) {
        return Scaffold(
          appBar: AppBar(title: Text("Futzone Squad Maker", style: TextStyle(fontFamily: boldFamily))),
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
                          onPressed: () {},
                          child: Column(
                            spacing: 12,
                            children: [
                              Image.asset("assets/images/full.jpg", height: 200),
                              Text(
                                "To'liq tarkib tuzish",
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
                                "assets/images/half.jpg",
                                height: 200,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Text(
                                "1 ta jamoa tuzish",
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
                                "assets/images/img.png",
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
                        onPressed: () {},
                        child: Column(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: Image.asset(
                                "assets/images/full.jpg",
                                height: double.infinity,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Text(
                              "To'liq tarkib tuzish",
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
                        onPressed:onPressedTeam,
                        child: Column(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: Image.asset(
                                "assets/images/half.jpg",
                                height: double.infinity,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Text(
                              "1 ta jamoa tuzish",
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
                                "assets/images/img.png",
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
                          onPressed: () {},
                          child: Column(
                            spacing: 12,
                            children: [
                              Image.asset(
                                "assets/images/full.jpg",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "To'liq tarkib tuzish",
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
                                "assets/images/half.jpg",
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                "1 ta jamoa tuzish",
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
                                "assets/images/img.png",
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
