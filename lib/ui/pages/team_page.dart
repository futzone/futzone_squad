import 'package:flutter/material.dart';
import 'package:futzone_squad/core/config/app_fonts.dart';
import 'package:futzone_squad/core/config/app_theme.dart';
import 'package:futzone_squad/core/constants/schemas.dart';
import 'package:futzone_squad/core/extensions/device_type.dart';
import 'package:futzone_squad/core/extensions/double.dart';
import 'package:futzone_squad/ui/widgets/app_simple_button.dart';
import 'package:futzone_squad/ui/widgets/app_text_field.dart';
import 'package:futzone_squad/ui/widgets/app_theme_builder.dart';
import 'package:icons_plus/icons_plus.dart';

import '../screens/scheme_screen.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  String? _selectedScheme;
  String? _selectedCount;
  String? _cardType;

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return Scaffold(
          appBar: AppBar(title: Text("Jamoa tuzish")),
          body: SingleChildScrollView(
            padding: 16.all,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildSchemeWidgets(theme),
                24.h,
                if (!context.isMobile)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 16,
                    children: [for (final item in btnList(theme)) Expanded(child: item)],
                  )
                else
                  Column(spacing: 16, crossAxisAlignment: CrossAxisAlignment.start, children: btnList(theme)),

                24.h,

                Text("Tarkib tuzish", style: TextStyle(fontSize: 20, fontFamily: boldFamily)),
                8.h,
                if (_cardType != null)
                  SchemeScreen(
                    cardType: _cardType!,
                    theme: theme,
                    count: _selectedCount ?? '',
                    scheme: _selectedScheme ?? '',
                  ),
                20.h,
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> btnList(AppColors theme) {
    return [
      SimpleButton(
        onPressed: () {
          setState(() {
            _cardType = "standard";
          });
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 32, right: 32, top: 30, bottom: 30),
          margin: EdgeInsets.only(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.green,
            border: _cardType == "standard" ? Border.all(color: theme.pink, width: 4) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person, size: 80, color: Colors.white),
              Text("Standart", style: TextStyle(fontSize: 16, fontFamily: mediumFamily, color: Colors.white)),
            ],
          ),
        ),
      ),
      SimpleButton(
        onPressed: () {
          setState(() {
            _cardType = "stats";
          });
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 32, right: 32, top: 30, bottom: 30),
          margin: EdgeInsets.only(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.green,
            border: _cardType == "stats" ? Border.all(color: theme.pink, width: 4) : null,
          ),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // height: 200,
                // width: 200,
                child: Stack(
                  children: [
                    Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(120), color: theme.pink),
                          padding: 16.all,
                          child: Icon(Icons.person, size: 48, color: Colors.white),
                        ),
                        0.h,
                        Text(
                          "Statistika bilan",
                          style: TextStyle(fontSize: 16, fontFamily: mediumFamily, color: Colors.white),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 24,
                      child: Row(
                        spacing: 24,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            spacing: 4,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(-1, 1),
                                      blurRadius: 1,
                                      spreadRadius: 1.2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  spacing: 4,
                                  children: [
                                    Text(
                                      '2',
                                      style: TextStyle(fontSize: 12, fontFamily: boldFamily, color: Colors.white),
                                    ),
                                    Icon(Icons.sports_soccer, color: Colors.white, size: 16),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(-1, 1),
                                      blurRadius: 1,
                                      spreadRadius: 1.2,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  spacing: 4,
                                  children: [
                                    Text(
                                      '2',
                                      style: TextStyle(fontSize: 12, fontFamily: boldFamily, color: Colors.white),
                                    ),
                                    Icon(MingCute.shoe_line, color: Colors.white, size: 16),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: theme.mainColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(-1, 1),
                                  blurRadius: 1,
                                  spreadRadius: 1.2,
                                ),
                              ],
                            ),
                            padding: 6.all,
                            child: Text(
                              "8.9",
                              style: TextStyle(fontSize: 14, fontFamily: boldFamily, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      SimpleButton(
        onPressed: () {
          setState(() {
            _cardType = "fifa";
          });
        },

        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 32, right: 32, top: 30, bottom: 30),
          margin: EdgeInsets.only(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.green,
            border: _cardType == "fifa" ? Border.all(color: theme.pink, width: 4) : null,
          ),
          child: Column(
            children: [
              Image.asset("assets/images/178_tots_evo_2.png", height: 120),
              Text("FIFA kartasi", style: TextStyle(fontSize: 16, fontFamily: mediumFamily, color: Colors.white)),
            ],
          ),
        ),
      ),
    ];
  }

  Widget buildSchemeWidgets(AppColors theme) {
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: PopupMenuButton(
            child: IgnorePointer(
              ignoring: true,
              child: AppTextField(
                onlyRead: true,
                title: "O'yinchilar soni",
                controller: TextEditingController(text: _selectedCount),
                theme: theme,
              ),
            ),

            itemBuilder:
                (context) => [
                  for (final item in Schemas().schemas.keys)
                    PopupMenuItem(
                      child: Text(item),
                      onTap: () {
                        setState(() {
                          _selectedCount = item;
                          _selectedScheme = null;
                        });
                      },
                    ),
                ],
          ),
        ),
        Expanded(
          child: PopupMenuButton(
            child: IgnorePointer(
              ignoring: true,
              child: AppTextField(
                onlyRead: true,
                title: "Tarkib sxemasi",
                controller: TextEditingController(text: _selectedScheme),
                theme: theme,
              ),
            ),

            itemBuilder:
                (context) => [
                  for (final item in Schemas().getSchemas(_selectedCount ?? '').keys)
                    PopupMenuItem(
                      child: Text(item),
                      onTap: () {
                        setState(() {
                          _selectedScheme = item;
                        });
                      },
                    ),
                ],
          ),
        ),
      ],
    );
  }
}
