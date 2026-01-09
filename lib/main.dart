import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_root.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'core/localization/localizations.dart';
import 'core/localization/language_controller.dart';
import 'features/issue/issue_model.dart';
import 'features/auth/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔒 Hive başlatma (UI BLOKLANMAZ)
  await Hive.initFlutter();

  // Adapter sadece bir kez register edilir
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(IssueModelAdapter());
  }

  // ❗ await YOK → ilk frame gecikmez
  Hive.openBox<IssueModel>('issues');
  Hive.openBox('profile');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (_, themeMode, __) {
        return ValueListenableBuilder<Locale>(
          valueListenable: LanguageController.locale,
          builder: (_, locale, __) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              locale: locale,
              supportedLocales: const [Locale('tr'), Locale('en')],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: FutureBuilder(
                future: Hive.openBox('session'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final box = Hive.box('session');
                  final loggedIn = box.get('loggedIn', defaultValue: false);

                  return loggedIn ? const AppRoot() : const LoginPage();
                },
              ),
            );
          },
        );
      },
    );
  }
}
