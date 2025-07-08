import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futzone_squad/controller/players_controller.dart';
import 'package:futzone_squad/core/config/app_fonts.dart';
import 'package:futzone_squad/core/constants/clubs.dart';
import 'package:futzone_squad/core/database/images_database.dart';
import 'package:futzone_squad/core/extensions/double.dart';
import 'package:futzone_squad/ui/widgets/app_simple_button.dart';
import 'package:futzone_squad/ui/widgets/app_theme_builder.dart';
import 'package:futzone_squad/ui/widgets/app_toast_widgets.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../core/constants/flags.dart';
import '../../core/constants/positions.dart';
import '../../core/models/player.dart';
import '../widgets/app_text_field.dart';

class AddPlayerScreen extends StatefulWidget {
  final WidgetRef ref;
  final Player? player;

  const AddPlayerScreen({super.key, required this.ref, this.player});

  @override
  State<AddPlayerScreen> createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _pacController = TextEditingController();
  final TextEditingController _shoController = TextEditingController();
  final TextEditingController _pasController = TextEditingController();
  final TextEditingController _driController = TextEditingController();
  final TextEditingController _defController = TextEditingController();
  final TextEditingController _phyController = TextEditingController();
  String _position = "";
  String _club = "";
  String _county = "";
  Uint8List? _imageBytes;

  void _onCreatePlayer(BuildContext context) async {
    if (_nameController.text.trim().length < 3) {
      return ShowToast.error(context, "Futbolchi nomini kamida 3 harf bilan kiriting");
    }

    if (_imageBytes == null) {
      return ShowToast.error(context, "Futbolchi uchun rasm tanlang");
    }

    if (_position.isEmpty) {
      return ShowToast.error(context, "Futbolchi pozitsiyasini tanlang");
    }

    if (_club.isEmpty) {
      return ShowToast.error(context, "Futbolchi klubini tanlang");
    }

    if (_county.isEmpty) {
      return ShowToast.error(context, "Futbolchi mamlakatini tanlang");
    }

    if (_numberController.text.isEmpty) {
      return ShowToast.error(context, "Futbolchi raqamini kiriting");
    }

    if (_pacController.text.isEmpty) {
      return ShowToast.error(context, "PAC qiymatini kiriting");
    }

    if (_shoController.text.isEmpty) {
      return ShowToast.error(context, "SHO qiymatini kiriting");
    }

    if (_pasController.text.isEmpty) {
      return ShowToast.error(context, "PAS qiymatini kiriting");
    }

    if (_driController.text.isEmpty) {
      return ShowToast.error(context, "DRI qiymatini kiriting");
    }

    if (_defController.text.isEmpty) {
      return ShowToast.error(context, "DEF qiymatini kiriting");
    }

    if (_phyController.text.isEmpty) {
      return ShowToast.error(context, "PHY qiymatini kiriting");
    }

    PlayersController playersController = PlayersController(ref: widget.ref, context: context);
    if (widget.player != null) {
      playersController.updatePlayer(
        name: _nameController.text.trim(),
        image: _imageBytes!,
        club: _club,
        country: _county,
        position: _position,
        number: _numberController.text,
        pac: _pacController.text,
        sho: _shoController.text,
        pas: _pasController.text,
        dri: _driController.text,
        def: _defController.text,
        phy: _phyController.text,
        id: widget.player?.id ?? '',
      );
      return;
    }

    playersController.createPlayer(
      name: _nameController.text.trim(),
      image: _imageBytes!,
      club: _club,
      country: _county,
      position: _position,
      number: _numberController.text,
      pac: _pacController.text,
      sho: _shoController.text,
      pas: _pasController.text,
      dri: _driController.text,
      def: _defController.text,
      phy: _phyController.text,
    );
  }

  void _imageBytesInitialize() async {
    if (widget.player == null || widget.player?.image == null) return;
    final bytes = await ImageDatabase().getImage(widget.player?.image ?? '');
    if (bytes != null) _imageBytes = bytes;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    if (widget.player != null) {
      _nameController.text = widget.player!.fullname;
      _numberController.text = widget.player!.number.toString();
      _pacController.text = widget.player!.pac.toString();
      _shoController.text = widget.player!.sho.toString();
      _pasController.text = widget.player!.pas.toString();
      _driController.text = widget.player!.dri.toString();
      _defController.text = widget.player!.def.toString();
      _phyController.text = widget.player!.phy.toString();

      _position = widget.player!.position;
      _club = widget.player!.club ?? "";
      _county = widget.player!.country ?? "";
      setState(() {});
      _imageBytesInitialize();
      // _imageBytes = widget.player!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppThemeBuilder(
      builder: (theme) {
        return Scaffold(
          appBar: AppBar(title: Text(widget.player == null ? "Yangi futbolchi qo'shish" : "Tahrirlash")),
          body: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 800),
              child: SingleChildScrollView(
                padding: 16.all,
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: SimpleButton(
                        onPressed: () async {
                          await FilePicker.platform.pickFiles(allowMultiple: false).then((img) async {
                            if (img != null && img.files.firstOrNull != null) {
                              final platformFile = await img.files.first.xFile.readAsBytes();
                              setState(() {
                                _imageBytes = platformFile;
                              });
                            }
                          });
                        },
                        child: Container(
                          height: 160,
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(320),
                            border: Border.all(color: theme.textColor),
                            image:
                                _imageBytes == null
                                    ? null
                                    : DecorationImage(image: MemoryImage(_imageBytes!), fit: BoxFit.cover),
                          ),

                          child:
                              _imageBytes != null
                                  ? null
                                  : Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.cloud_upload_outlined, size: 48, color: theme.mainColor),
                                      8.h,
                                      Text("Futbolchi rasmi"),
                                    ],
                                  ),
                        ),
                      ),
                    ),
                    0.h,
                    AppTextField(theme: theme, controller: _nameController, title: 'Futbolchi nomi'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Expanded(
                          child: PopupMenuButton(
                            child: IgnorePointer(
                              ignoring: true,
                              child: AppTextField(
                                theme: theme,
                                controller: TextEditingController(text: _position),
                                title: 'Pozitsiya',
                                onlyRead: true,
                              ),
                            ),

                            itemBuilder:
                                (context) => [
                                  for (final item in positions.keys)
                                    PopupMenuItem(
                                      child: Row(
                                        spacing: 4,
                                        children: [
                                          Text(
                                            item,
                                            style: TextStyle(
                                              fontFamily: boldFamily,
                                              fontSize: 12,
                                              color: theme.mainColor,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              " - ${positions[item]}",
                                              style: TextStyle(
                                                fontFamily: regularFamily,
                                                fontSize: 12,
                                                color: theme.textColor,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),

                                      onTap: () {
                                        setState(() {
                                          _position = item;
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
                                theme: theme,
                                controller: _numberController,
                                title: 'Raqami',
                                onlyRead: true,
                              ),
                            ),

                            itemBuilder:
                                (context) => [
                                  for (int i = 1; i <= 100; i++)
                                    PopupMenuItem(
                                      child: Text(
                                        "$i",
                                        style: TextStyle(fontFamily: boldFamily, fontSize: 12, color: theme.mainColor),
                                      ),

                                      onTap: () {
                                        setState(() {
                                          _numberController.text = i.toString();
                                        });
                                      },
                                    ),
                                ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Expanded(
                          child: PopupMenuButton(
                            child: IgnorePointer(
                              ignoring: true,
                              child: AppTextField(
                                theme: theme,
                                controller: TextEditingController(
                                  text: _county.isNotEmpty ? FlagsDatabase().getName(_county) : '',
                                ),
                                prefixIcon: _county.isEmpty ? null : Flag(_county, size: 20),

                                title: 'Mamlakat',
                                onlyRead: true,
                                maxLines: 1,
                              ),
                            ),

                            itemBuilder:
                                (context) => [
                                  for (final item in FlagsDatabase().all)
                                    PopupMenuItem(
                                      child: Row(
                                        spacing: 4,
                                        children: [
                                          Flag(item.keys.firstOrNull ?? ''),
                                          Expanded(
                                            child: Text(
                                              " ${item.values.firstOrNull ?? ''}",
                                              style: TextStyle(
                                                fontFamily: regularFamily,
                                                fontSize: 12,
                                                color: theme.textColor,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),

                                      onTap: () {
                                        setState(() {
                                          _county = item.keys.firstOrNull ?? '';
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
                                theme: theme,
                                controller: TextEditingController(
                                  text: _club.isNotEmpty ? ClubsDatabase().getName(_club) : '',
                                ),
                                prefixIcon: _club.isEmpty ? null : Brand(_club, size: 20),

                                title: 'Jamoa',
                                onlyRead: true,
                                maxLines: 1,
                              ),
                            ),

                            itemBuilder:
                                (context) => [
                                  for (final item in ClubsDatabase().all)
                                    PopupMenuItem(
                                      child: Row(
                                        spacing: 4,
                                        children: [
                                          Brand(item.keys.firstOrNull ?? ''),
                                          Expanded(
                                            child: Text(
                                              " ${item.values.firstOrNull ?? ''}",
                                              style: TextStyle(
                                                fontFamily: regularFamily,
                                                fontSize: 12,
                                                color: theme.textColor,
                                              ),
                                              maxLines: 1,
                                            ),
                                          ),
                                        ],
                                      ),

                                      onTap: () {
                                        setState(() {
                                          _club = item.keys.firstOrNull ?? '';
                                        });
                                      },
                                    ),
                                ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Expanded(
                          child: PopupMenuButton(
                            child: IgnorePointer(
                              ignoring: true,
                              child: AppTextField(
                                theme: theme,
                                controller: _pacController,
                                title: 'Tezlik',
                                onlyRead: true,
                                prefixIcon: Icon(Iconsax.flash_1_outline),
                              ),
                            ),

                            itemBuilder:
                                (context) => [
                                  for (int i = 20; i <= 120; i++)
                                    PopupMenuItem(
                                      child: Text(
                                        "$i",
                                        style: TextStyle(fontFamily: boldFamily, fontSize: 12, color: theme.textColor),
                                      ),

                                      onTap: () {
                                        setState(() {
                                          _pacController.text = i.toString();
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
                                theme: theme,
                                controller: _shoController,
                                title: 'Zarba',
                                onlyRead: true,
                                prefixIcon: Icon(Icons.sports_soccer),
                              ),
                            ),

                            itemBuilder:
                                (context) => [
                                  for (int i = 20; i <= 120; i++)
                                    PopupMenuItem(
                                      child: Text(
                                        "$i",
                                        style: TextStyle(fontFamily: boldFamily, fontSize: 12, color: theme.textColor),
                                      ),

                                      onTap: () {
                                        setState(() {
                                          _shoController.text = i.toString();
                                        });
                                      },
                                    ),
                                ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Expanded(
                          child: PopupMenuButton(
                            child: IgnorePointer(
                              ignoring: true,
                              child: AppTextField(
                                theme: theme,
                                controller: _pasController,
                                title: 'Passlar',
                                onlyRead: true,
                                prefixIcon: Icon(MingCute.shoe_line),
                              ),
                            ),

                            itemBuilder:
                                (context) => [
                                  for (int i = 20; i <= 120; i++)
                                    PopupMenuItem(
                                      child: Text(
                                        "$i",
                                        style: TextStyle(fontFamily: boldFamily, fontSize: 12, color: theme.textColor),
                                      ),

                                      onTap: () {
                                        setState(() {
                                          _pasController.text = i.toString();
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
                                theme: theme,
                                controller: _driController,
                                title: 'Dribling',
                                onlyRead: true,
                                prefixIcon: Icon(Iconsax.magic_star_outline),
                              ),
                            ),

                            itemBuilder:
                                (context) => [
                                  for (int i = 20; i <= 120; i++)
                                    PopupMenuItem(
                                      child: Text(
                                        "$i",
                                        style: TextStyle(fontFamily: boldFamily, fontSize: 12, color: theme.textColor),
                                      ),

                                      onTap: () {
                                        setState(() {
                                          _driController.text = i.toString();
                                        });
                                      },
                                    ),
                                ],
                          ),
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: 16,
                      children: [
                        Expanded(
                          child: PopupMenuButton(
                            child: IgnorePointer(
                              ignoring: true,
                              child: AppTextField(
                                theme: theme,
                                controller: _defController,
                                title: 'Himoya',
                                onlyRead: true,
                                prefixIcon: Icon(MingCute.shield_line),
                              ),
                            ),

                            itemBuilder:
                                (context) => [
                                  for (int i = 20; i <= 120; i++)
                                    PopupMenuItem(
                                      child: Text(
                                        "$i",
                                        style: TextStyle(fontFamily: boldFamily, fontSize: 12, color: theme.textColor),
                                      ),

                                      onTap: () {
                                        setState(() {
                                          _defController.text = i.toString();
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
                                theme: theme,
                                controller: _phyController,
                                title: 'Jismoniy kuch',
                                onlyRead: true,
                                prefixIcon: Icon(Icons.fitness_center),
                              ),
                            ),

                            itemBuilder:
                                (context) => [
                                  for (int i = 20; i <= 120; i++)
                                    PopupMenuItem(
                                      child: Text(
                                        "$i",
                                        style: TextStyle(fontFamily: boldFamily, fontSize: 12, color: theme.textColor),
                                      ),

                                      onTap: () {
                                        setState(() {
                                          _phyController.text = i.toString();
                                        });
                                      },
                                    ),
                                ],
                          ),
                        ),
                      ],
                    ),
                    0.h,
                    Center(
                      child: MaterialButton(
                        onPressed: () => _onCreatePlayer(context),
                        padding: EdgeInsets.only(left: 48, right: 48, top: 16, bottom: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        color: theme.mainColor,
                        child: Row(
                          spacing: 12,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.white),
                            Text(
                              widget.player == null ? "Qo'shish" : "Saqlash",
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
                    ),
                    0.h,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
