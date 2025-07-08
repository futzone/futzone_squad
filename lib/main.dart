import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futzone_squad/ui/pages/main_page.dart';
import 'package:futzone_squad/ui/widgets/app_theme_builder.dart';
import 'package:toastification/toastification.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return AppThemeBuilder(
      builder: (theme) {
        return ToastificationWrapper(
          child: MaterialApp(
            title: 'Futzone Squad Maker',
            debugShowCheckedModeBanner: false,
            theme: theme.themeData,
            home: MainPage(),
          ),
        );
      },
    );
  }
}
