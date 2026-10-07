import 'package:flutter/material.dart';

/// Single source of truth for the app's look.
/// Every colour in the UI should come from `Theme.of(context).colorScheme`,
/// and every text style from `Theme.of(context).textTheme`.
class AppTheme {
  AppTheme._();

  /// Muted violet. See docs/week03/design.md for the user-based rationale.
  static const Color seed = Color(0xFF7B5EA7);

  static ThemeData light() => _build(Brightness.light);
  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: scheme.surfaceTint,
        scrolledUnderElevation: 2,
      ),
    );
  }
}