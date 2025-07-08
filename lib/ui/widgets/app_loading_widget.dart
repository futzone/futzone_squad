import 'package:flutter/material.dart';
import 'package:futzone_squad/core/extensions/double.dart';

import '../../core/config/app_theme.dart';

class AppLoadingScreen extends StatelessWidget {
  final EdgeInsets? padding;

  const AppLoadingScreen({this.padding = EdgeInsets.zero, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(strokeWidth: 4, color: AppColors(isDark: false).mainColor),
        ),
      ),
    );
  }
}

showAppLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AppLoadingScreen(padding: 100.all);
    },
  );
}
