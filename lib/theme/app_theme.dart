import 'package:flutter/material.dart';

class AppTheme {
  static const Color _seed = Color(0xFF7E57C2); // ganti dengan warna pilihanmu

  static ThemeData light() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _seed),
      );

  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 55, 132, 177),
          brightness: Brightness.dark,
        ),
      );
}