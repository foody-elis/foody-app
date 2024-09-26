import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff855318),
      surfaceTint: Color(0xff855318),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffffdcbe),
      onPrimaryContainer: Color(0xff2c1600),
      secondary: Color(0xff725a42),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffffdcbe),
      onSecondaryContainer: Color(0xff291806),
      tertiary: Color(0xff58633a),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdce8b4),
      onTertiaryContainer: Color(0xff161e01),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff211a14),
      onSurfaceVariant: Color(0xff51453a),
      outline: Color(0xff837468),
      outlineVariant: Color(0xffd5c3b5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff372f28),
      inversePrimary: Color(0xfffdb975),
      primaryFixed: Color(0xffffdcbe),
      onPrimaryFixed: Color(0xff2c1600),
      primaryFixedDim: Color(0xfffdb975),
      onPrimaryFixedVariant: Color(0xff693c00),
      secondaryFixed: Color(0xffffdcbe),
      onSecondaryFixed: Color(0xff291806),
      secondaryFixedDim: Color(0xffe1c1a4),
      onSecondaryFixedVariant: Color(0xff59422c),
      tertiaryFixed: Color(0xffdce8b4),
      onTertiaryFixed: Color(0xff161e01),
      tertiaryFixedDim: Color(0xffc0cc9a),
      onTertiaryFixedVariant: Color(0xff414b24),
      surfaceDim: Color(0xffe6d7cd),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfffaebe0),
      surfaceContainerHigh: Color(0xfff4e5db),
      surfaceContainerHighest: Color(0xffefe0d5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff643800),
      surfaceTint: Color(0xff855318),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9f682d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff553e29),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff8a7057),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff3d4721),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6e794e),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff211a14),
      onSurfaceVariant: Color(0xff4c4136),
      outline: Color(0xff6a5d51),
      outlineVariant: Color(0xff87786c),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff372f28),
      inversePrimary: Color(0xfffdb975),
      primaryFixed: Color(0xff9f682d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff835016),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8a7057),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff705740),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6e794e),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff566037),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe6d7cd),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfffaebe0),
      surfaceContainerHigh: Color(0xfff4e5db),
      surfaceContainerHighest: Color(0xffefe0d5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff361c00),
      surfaceTint: Color(0xff855318),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff643800),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff301e0b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff553e29),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff1d2504),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff3d4721),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff8f5),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff2c2219),
      outline: Color(0xff4c4136),
      outlineVariant: Color(0xff4c4136),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff372f28),
      inversePrimary: Color(0xffffe8d5),
      primaryFixed: Color(0xff643800),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff452500),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff553e29),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3c2915),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff3d4721),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff27300c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffe6d7cd),
      surfaceBright: Color(0xfffff8f5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffff1e7),
      surfaceContainer: Color(0xfffaebe0),
      surfaceContainerHigh: Color(0xfff4e5db),
      surfaceContainerHighest: Color(0xffefe0d5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffdb975),
      surfaceTint: Color(0xfffdb975),
      onPrimary: Color(0xff4a2800),
      primaryContainer: Color(0xff693c00),
      onPrimaryContainer: Color(0xffffdcbe),
      secondary: Color(0xffe1c1a4),
      onSecondary: Color(0xff402c18),
      secondaryContainer: Color(0xff59422c),
      onSecondaryContainer: Color(0xffffdcbe),
      tertiary: Color(0xffc0cc9a),
      onTertiary: Color(0xff2b3410),
      tertiaryContainer: Color(0xff414b24),
      onTertiaryContainer: Color(0xffdce8b4),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff19120c),
      onSurface: Color(0xffefe0d5),
      onSurfaceVariant: Color(0xffd5c3b5),
      outline: Color(0xff9d8e81),
      outlineVariant: Color(0xff51453a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffefe0d5),
      inversePrimary: Color(0xff855318),
      primaryFixed: Color(0xffffdcbe),
      onPrimaryFixed: Color(0xff2c1600),
      primaryFixedDim: Color(0xfffdb975),
      onPrimaryFixedVariant: Color(0xff693c00),
      secondaryFixed: Color(0xffffdcbe),
      onSecondaryFixed: Color(0xff291806),
      secondaryFixedDim: Color(0xffe1c1a4),
      onSecondaryFixedVariant: Color(0xff59422c),
      tertiaryFixed: Color(0xffdce8b4),
      onTertiaryFixed: Color(0xff161e01),
      tertiaryFixedDim: Color(0xffc0cc9a),
      onTertiaryFixedVariant: Color(0xff414b24),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff403830),
      surfaceContainerLowest: Color(0xff130d07),
      surfaceContainerLow: Color(0xff211a14),
      surfaceContainer: Color(0xff261e18),
      surfaceContainerHigh: Color(0xff302822),
      surfaceContainerHighest: Color(0xff3c332c),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffffbe7d),
      surfaceTint: Color(0xfffdb975),
      onPrimary: Color(0xff251200),
      primaryContainer: Color(0xffc08446),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe6c5a8),
      onSecondary: Color(0xff231303),
      secondaryContainer: Color(0xffa88b71),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffc4d09e),
      onTertiary: Color(0xff111900),
      tertiaryContainer: Color(0xff8a9668),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff19120c),
      onSurface: Color(0xfffffaf8),
      onSurfaceVariant: Color(0xffd9c8b9),
      outline: Color(0xffb0a093),
      outlineVariant: Color(0xff8f8074),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffefe0d5),
      inversePrimary: Color(0xff6b3d01),
      primaryFixed: Color(0xffffdcbe),
      onPrimaryFixed: Color(0xff1e0d00),
      primaryFixedDim: Color(0xfffdb975),
      onPrimaryFixedVariant: Color(0xff522d00),
      secondaryFixed: Color(0xffffdcbe),
      onSecondaryFixed: Color(0xff1d0e01),
      secondaryFixedDim: Color(0xffe1c1a4),
      onSecondaryFixedVariant: Color(0xff47321d),
      tertiaryFixed: Color(0xffdce8b4),
      onTertiaryFixed: Color(0xff0d1300),
      tertiaryFixedDim: Color(0xffc0cc9a),
      onTertiaryFixedVariant: Color(0xff303a15),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff403830),
      surfaceContainerLowest: Color(0xff130d07),
      surfaceContainerLow: Color(0xff211a14),
      surfaceContainer: Color(0xff261e18),
      surfaceContainerHigh: Color(0xff302822),
      surfaceContainerHighest: Color(0xff3c332c),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffffaf8),
      surfaceTint: Color(0xfffdb975),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffffbe7d),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfffffaf8),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe6c5a8),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfff7ffd6),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc4d09e),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff19120c),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfffffaf8),
      outline: Color(0xffd9c8b9),
      outlineVariant: Color(0xffd9c8b9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffefe0d5),
      inversePrimary: Color(0xff412300),
      primaryFixed: Color(0xffffe2c9),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffffbe7d),
      onPrimaryFixedVariant: Color(0xff251200),
      secondaryFixed: Color(0xffffe2c9),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe6c5a8),
      onSecondaryFixedVariant: Color(0xff231303),
      tertiaryFixed: Color(0xffe0edb8),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc4d09e),
      onTertiaryFixedVariant: Color(0xff111900),
      surfaceDim: Color(0xff19120c),
      surfaceBright: Color(0xff403830),
      surfaceContainerLowest: Color(0xff130d07),
      surfaceContainerLow: Color(0xff211a14),
      surfaceContainer: Color(0xff261e18),
      surfaceContainerHigh: Color(0xff302822),
      surfaceContainerHighest: Color(0xff3c332c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
