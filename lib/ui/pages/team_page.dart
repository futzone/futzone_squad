import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futzone_squad/core/config/app_fonts.dart';
import 'package:futzone_squad/core/config/app_router.dart';
import 'package:futzone_squad/core/config/app_theme.dart';
import 'package:futzone_squad/core/constants/schemas.dart';
import 'package:futzone_squad/core/constants/templates.dart';
 import 'package:futzone_squad/core/extensions/double.dart';
import 'package:futzone_squad/core/utils/image_saver.dart';
import 'package:futzone_squad/ui/pages/main_page.dart';
import 'package:futzone_squad/ui/widgets/app_loading_widget.dart';
 import 'package:futzone_squad/ui/widgets/app_text_field.dart';
import 'package:futzone_squad/ui/widgets/app_theme_builder.dart';
import 'package:futzone_squad/ui/widgets/app_toast_widgets.dart';
 import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../screens/scheme_screen.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({super.key});

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  String? _selectedScheme;
  String? _selectedCount;
  Template _selectedTemplate = Template.values.first;
  ScreenshotController screenshotController = ScreenshotController();

  final String _cardType = 'fifa';

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
                PopupMenuButton(
                  child: IgnorePointer(
                    ignoring: true,
                    child: AppTextField(
                      title: "Card template",
                      controller: TextEditingController(text: "Template ${_selectedTemplate.id}"),
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
                                _selectedTemplate = item;
                              });
                            },
                          ),
                      ],
                ),
                24.h,

                Text("Tarkib tuzish", style: TextStyle(fontSize: 20, fontFamily: boldFamily)),
                8.h,
                Screenshot(
                  controller: screenshotController,
                  child: SchemeScreen(
                    cardType: _cardType,
                    theme: theme,
                    count: _selectedCount ?? '',
                    scheme: _selectedScheme ?? '',
                    template: _selectedTemplate,
                  ),
                ),
                20.h,
                MaterialButton(
                  onPressed: () async {
                    showAppLoadingDialog(context);
                    if (kIsWeb) {
                      final bytes = await screenshotController.capture();
                      if (bytes == null) return;

                      await savePng(bytes, DateTime.now().millisecondsSinceEpoch.toString()).then((_) {
                        AppRouter.close(context);
                        ShowToast.success(context, "Saqlandi!");
                        AppRouter.open(context, MainPage());
                      });
                      return;
                    }

                    final dir = await getApplicationDocumentsDirectory();
                    await screenshotController.captureAndSave(dir.path, pixelRatio: 2).then((_) {
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
                20.h,
              ],
            ),
          ),
        );
      },
    );
  }

  // List<Widget> btnList(AppColors theme) {
  //   return [
  //     SimpleButton(
  //       onPressed: () {
  //         setState(() {
  //           _cardType = "standard";
  //         });
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         padding: EdgeInsets.only(left: 32, right: 32, top: 30, bottom: 30),
  //         margin: EdgeInsets.only(),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(16),
  //           color: Colors.green,
  //           border: _cardType == "standard" ? Border.all(color: theme.pink, width: 4) : null,
  //         ),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(Icons.person, size: 80, color: Colors.white),
  //             Text("Standart", style: TextStyle(fontSize: 16, fontFamily: mediumFamily, color: Colors.white)),
  //           ],
  //         ),
  //       ),
  //     ),
  //     SimpleButton(
  //       onPressed: () {
  //         setState(() {
  //           _cardType = "stats";
  //         });
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         padding: EdgeInsets.only(left: 32, right: 32, top: 30, bottom: 30),
  //         margin: EdgeInsets.only(),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(16),
  //           color: Colors.green,
  //           border: _cardType == "stats" ? Border.all(color: theme.pink, width: 4) : null,
  //         ),
  //
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             SizedBox(
  //               // height: 200,
  //               // width: 200,
  //               child: Stack(
  //                 children: [
  //                   Column(
  //                     spacing: 4,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(120), color: theme.pink),
  //                         padding: 16.all,
  //                         child: Icon(Icons.person, size: 48, color: Colors.white),
  //                       ),
  //                       0.h,
  //                       Text(
  //                         "Statistika bilan",
  //                         style: TextStyle(fontSize: 16, fontFamily: mediumFamily, color: Colors.white),
  //                       ),
  //                     ],
  //                   ),
  //                   Positioned(
  //                     bottom: 24,
  //                     child: Row(
  //                       spacing: 24,
  //                       crossAxisAlignment: CrossAxisAlignment.end,
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Column(
  //                           spacing: 4,
  //                           children: [
  //                             Container(
  //                               padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
  //                               decoration: BoxDecoration(
  //                                 color: Colors.blue,
  //                                 borderRadius: BorderRadius.circular(24),
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: Colors.black26,
  //                                     offset: Offset(-1, 1),
  //                                     blurRadius: 1,
  //                                     spreadRadius: 1.2,
  //                                   ),
  //                                 ],
  //                               ),
  //                               child: Row(
  //                                 spacing: 4,
  //                                 children: [
  //                                   Text(
  //                                     '2',
  //                                     style: TextStyle(fontSize: 12, fontFamily: boldFamily, color: Colors.white),
  //                                   ),
  //                                   Icon(Icons.sports_soccer, color: Colors.white, size: 16),
  //                                 ],
  //                               ),
  //                             ),
  //                             Container(
  //                               padding: EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
  //                               decoration: BoxDecoration(
  //                                 color: Colors.blue,
  //                                 borderRadius: BorderRadius.circular(24),
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                     color: Colors.black26,
  //                                     offset: Offset(-1, 1),
  //                                     blurRadius: 1,
  //                                     spreadRadius: 1.2,
  //                                   ),
  //                                 ],
  //                               ),
  //                               child: Row(
  //                                 spacing: 4,
  //                                 children: [
  //                                   Text(
  //                                     '2',
  //                                     style: TextStyle(fontSize: 12, fontFamily: boldFamily, color: Colors.white),
  //                                   ),
  //                                   Icon(MingCute.shoe_line, color: Colors.white, size: 16),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                         // Spacer(),
  //                         Container(
  //                           decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(12),
  //                             color: theme.mainColor,
  //                             boxShadow: [
  //                               BoxShadow(
  //                                 color: Colors.black26,
  //                                 offset: Offset(-1, 1),
  //                                 blurRadius: 1,
  //                                 spreadRadius: 1.2,
  //                               ),
  //                             ],
  //                           ),
  //                           padding: 6.all,
  //                           child: Text(
  //                             "8.9",
  //                             style: TextStyle(fontSize: 14, fontFamily: boldFamily, color: Colors.white),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //
  //     SimpleButton(
  //       onPressed: () {
  //         setState(() {
  //           _cardType = "fifa";
  //         });
  //       },
  //
  //       child: Container(
  //         width: double.infinity,
  //         padding: EdgeInsets.only(left: 32, right: 32, top: 30, bottom: 30),
  //         margin: EdgeInsets.only(),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(16),
  //           color: Colors.green,
  //           border: _cardType == "fifa" ? Border.all(color: theme.pink, width: 4) : null,
  //         ),
  //         child: Column(
  //           children: [
  //             Image.asset("assets/images/178_tots_evo_2.png", height: 120),
  //             Text("FIFA kartasi", style: TextStyle(fontSize: 16, fontFamily: mediumFamily, color: Colors.white)),
  //           ],
  //         ),
  //       ),
  //     ),
  //   ];
  // }

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
