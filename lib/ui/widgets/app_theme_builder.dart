import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futzone_squad/core/config/app_theme.dart';

final appThemeProvider = FutureProvider((ref) async {
  return AppColors();
});

class AppThemeBuilder extends ConsumerWidget {
  final Widget Function(AppColors theme) builder;

  const AppThemeBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context, ref) {
    final providerListener = ref.watch(appThemeProvider);
    return providerListener.when(
      data: (data) => builder(data),
      error: (_, __) => builder(AppColors()),
      loading: () => builder(AppColors()),
    );
  }
}
