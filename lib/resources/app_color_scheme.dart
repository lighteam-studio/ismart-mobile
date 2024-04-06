import 'package:flutter/material.dart';

class AppColorScheme extends ColorScheme {
  final Color red;
  final Color green;
  final Color blue;
  final Color purple;
  final Color yellow;
  final Color brown;

  const AppColorScheme({
    required super.background,
    required super.brightness,
    required super.error,
    required super.onBackground,
    required super.onError,
    required super.onPrimary,
    required super.onSecondary,
    required super.onSurface,
    required super.primary,
    required super.secondary,
    required super.surface,
    required this.red,
    required this.green,
    required this.blue,
    required this.purple,
    required this.brown,
    required this.yellow,
    super.errorContainer,
    super.inversePrimary,
    super.inverseSurface,
    super.onErrorContainer,
    super.onInverseSurface,
    super.onPrimaryContainer,
    super.onSecondaryContainer,
    super.onSurfaceVariant,
    super.onTertiary,
    super.onTertiaryContainer,
    super.outline,
    super.outlineVariant,
    super.primaryContainer,
    super.scrim,
    super.secondaryContainer,
    super.shadow,
    super.surfaceTint,
    super.surfaceVariant,
    super.tertiary,
    super.tertiaryContainer,
  });
}
