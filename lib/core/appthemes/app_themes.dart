import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false); // Initial state is light mode (false)

  static final ThemeData lightMode = ThemeData(
    colorScheme: ColorScheme.light(
        surface: Colors.white,
        primary: const Color(0xff196EEE),
        secondary: const Color(0xff2DD7A4),
        tertiary: const Color(0xffB47820),
        inversePrimary: Colors.grey.shade900,
        tertiaryContainer: const Color(0xffDF9652),
        primaryFixedDim: Colors.black),
  );

  static final ThemeData darkMode = ThemeData(
    colorScheme: ColorScheme.dark(
        surface: Colors.black,
        primary: Colors.white,
        secondary: Colors.white,
        tertiary: const Color.fromARGB(255, 180, 180, 180).withOpacity(0.2),
        inversePrimary: Colors.grey.shade900,
        tertiaryContainer: const Color(0xff939cc4),
        primaryFixedDim: Colors.white),
  );

  ThemeData get currentTheme => state ? darkMode : lightMode;

  void toggleTheme() {
    state = !state;
  }
}

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});
