import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract final class AppTheme {
  // The defined light theme.
  static ThemeData light = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color(0xFF00296B),
      primaryContainer: Color(0xFFA0C2ED),
      primaryLightRef: Color(0xFF00296B),
      secondary: Color(0xFFD26900),
      secondaryContainer: Color(0xFFFFD270),
      secondaryLightRef: Color(0xFFD26900),
      tertiary: Color(0xFF5C5C95),
      tertiaryContainer: Color(0xFFC8DBF8),
      tertiaryLightRef: Color(0xFF5C5C95),
      appBarColor: Color(0xFFC8DCF8),
      error: Color(0x00000000),
      errorContainer: Color(0x00000000),
    ),
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      sliderTrackHeight: 5,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    // textTheme: const TextTheme(
    //   titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    //   titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //   titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    //   bodyLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    //   bodyMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    //   bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
    //   labelLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    // ),
    fontFamily: "Yekan",
  );
  // The defined dark theme.
  static ThemeData dark = FlexThemeData.dark(
    scaffoldBackground: const Color(0xFF101010),
    appBarBackground: const Color(0xFF121212),
    colors: const FlexSchemeColor(
      primary: Color(0xFFB1CFF5),
      primaryContainer: Color(0xFF3873BA),
      primaryLightRef: Color(0xFF00296B),
      secondary: Color(0xFFFFD270),
      secondaryContainer: Color(0xFFD26900),
      secondaryLightRef: Color(0xFFD26900),
      tertiary: Color(0xFFC9CBFC),
      tertiaryContainer: Color(0xFF535393),
      tertiaryLightRef: Color(0xFF5C5C95),
      appBarColor: Color(0xFF00102B),
      error: Color(0x00000000),
      errorContainer: Color(0x00000000),
    ),
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      sliderTrackHeight: 5,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    // textTheme: const TextTheme(
    //   titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
    //   titleMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    //   titleSmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
    //   bodyLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    //   bodyMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
    //   bodySmall: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
    //   labelLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    // ),
    fontFamily: "Yekan",
  );
}
