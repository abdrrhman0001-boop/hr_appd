import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart'; import 'core/l10n.dart'; import 'core/store.dart';
import 'screens/login.dart'; import 'screens/shell.dart';

void main() { runApp(ChangeNotifierProvider(create: (_) => AppStore(), child: const HrApp())); }

class HrApp extends StatelessWidget {
  const HrApp({super.key});
  @override
  Widget build(BuildContext context) {
    final s = context.watch<AppStore>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HR',
      locale: Locale(s.lang),
      supportedLocales: const [Locale('ar'), Locale('fr'), Locale('en')],
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      theme: buildTheme(dark: false, lang: s.lang),
      darkTheme: buildTheme(dark: true, lang: s.lang),
      themeMode: s.dark ? ThemeMode.dark : ThemeMode.light,
      builder: (c, w) => Directionality(
        textDirection: s.lang == 'ar' ? TextDirection.rtl : TextDirection.ltr, child: w!),
      home: const LoginScreen(),
    );
  }
}
