import 'package:flutter/material.dart';

/// {@template text_style_extension}
/// TextStyle extension that provides access to [ThemeData] and [TextTheme].
/// {@endtemplate}
extension TextStyleExtension on BuildContext {
  /// Returns [ThemeData] from [Theme.of].
  ThemeData get theme => Theme.of(this);

  /// Defines current theme [Brightness].
  Brightness get brightness => theme.brightness;

  /// Whether current theme [Brightness] is light.
  bool get isLight => brightness == Brightness.light;

  /// Whether current theme [Brightness] is dark.
  bool get isDark => !isLight;

  /// Defines an adaptive [Color], depending on current theme brightness.
  Color get adaptiveColor => isDark
      ? Colors.white
      : Colors.black;

  /// Defines a reversed adaptive [Color], depending on current theme
  /// brightness.
  Color get reversedAdaptiveColor => isDark
      ? Colors.black
      : Colors.white;
}
