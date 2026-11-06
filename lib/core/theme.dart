import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildTheme({required bool dark, required String lang}) {
  final base = dark ? ThemeData.dark(useMaterial3: true) : ThemeData.light(useMaterial3: true);
  // خط عربي واضح: Cairo/Tajawal عبر Google Fonts
  final textTheme = GoogleFonts.cairoTextTheme(base.textTheme);
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1B6B5A), // أخضر هادئ
    brightness: dark ? Brightness.dark : Brightness.light,
  ).copyWith(secondary: const Color(0xFFC9A227));
  return base.copyWith(colorScheme: scheme, textTheme: textTheme,
    appBarTheme: base.appBarTheme.copyWith(centerTitle: true),
    navigationBarTheme: NavigationBarThemeData(labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 11))),
    cardTheme: const CardThemeData(margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6)));
}
