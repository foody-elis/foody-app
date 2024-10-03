import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00322f),
      surfaceTint: Color(0xff336763),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1f5552),
      onPrimaryContainer: Color(0xffbff5f0),
      secondary: Color(0xff4f6260),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd3e8e5),
      onSecondaryContainer: Color(0xff394c4b),
      tertiary: Color(0xff302447),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff52466b),
      onTertiaryContainer: Color(0xfff0e5ff),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfff9faf8),
      onSurface: Color(0xff191c1c),
      onSurfaceVariant: Color(0xff404847),
      outline: Color(0xff707978),
      outlineVariant: Color(0xffbfc8c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3130),
      inversePrimary: Color(0xff9cd0cc),
      primaryFixed: Color(0xffb7ede8),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff9cd0cc),
      onPrimaryFixedVariant: Color(0xff184f4b),
      secondaryFixed: Color(0xffd2e7e4),
      onSecondaryFixed: Color(0xff0c1f1d),
      secondaryFixedDim: Color(0xffb6cbc8),
      onSecondaryFixedVariant: Color(0xff374a49),
      tertiaryFixed: Color(0xffeaddff),
      onTertiaryFixed: Color(0xff201537),
      tertiaryFixedDim: Color(0xffcfbfeb),
      onTertiaryFixedVariant: Color(0xff4d4165),
      surfaceDim: Color(0xffd9dad9),
      surfaceBright: Color(0xfff9faf8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f4f3),
      surfaceContainer: Color(0xffedeeed),
      surfaceContainerHigh: Color(0xffe7e8e7),
      surfaceContainerHighest: Color(0xffe1e3e2),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00322f),
      surfaceTint: Color(0xff336763),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1f5552),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff344645),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff657876),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff302447),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff52466b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9faf8),
      onSurface: Color(0xff191c1c),
      onSurfaceVariant: Color(0xff3c4443),
      outline: Color(0xff586160),
      outlineVariant: Color(0xff747c7b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3130),
      inversePrimary: Color(0xff9cd0cc),
      primaryFixed: Color(0xff4a7d7a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff306461),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff657876),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4c605e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff7c6e96),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff63567c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9dad9),
      surfaceBright: Color(0xfff9faf8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f4f3),
      surfaceContainer: Color(0xffedeeed),
      surfaceContainerHigh: Color(0xffe7e8e7),
      surfaceContainerHighest: Color(0xffe1e3e2),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002725),
      surfaceTint: Color(0xff336763),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff124b47),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff132524),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff344645),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff271c3e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff493d61),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff9faf8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1d2525),
      outline: Color(0xff3c4443),
      outlineVariant: Color(0xff3c4443),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e3130),
      inversePrimary: Color(0xffc0f6f1),
      primaryFixed: Color(0xff124b47),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003331),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff344645),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1d302e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff493d61),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff322649),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd9dad9),
      surfaceBright: Color(0xfff9faf8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f4f3),
      surfaceContainer: Color(0xffedeeed),
      surfaceContainerHigh: Color(0xffe7e8e7),
      surfaceContainerHighest: Color(0xffe1e3e2),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9cd0cc),
      surfaceTint: Color(0xff9cd0cc),
      onPrimary: Color(0xff003734),
      primaryContainer: Color(0xff003b38),
      onPrimaryContainer: Color(0xff98cdc8),
      secondary: Color(0xffb6cbc8),
      onSecondary: Color(0xff213432),
      secondaryContainer: Color(0xff2e403f),
      onSecondaryContainer: Color(0xffc0d5d2),
      tertiary: Color(0xffcfbfeb),
      onTertiary: Color(0xff362a4d),
      tertiaryContainer: Color(0xff3a2e51),
      onTertiaryContainer: Color(0xffccbce8),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111414),
      onSurface: Color(0xffe1e3e2),
      onSurfaceVariant: Color(0xffbfc8c7),
      outline: Color(0xff8a9291),
      outlineVariant: Color(0xff404847),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e3e2),
      inversePrimary: Color(0xff336763),
      primaryFixed: Color(0xffb7ede8),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff9cd0cc),
      onPrimaryFixedVariant: Color(0xff184f4b),
      secondaryFixed: Color(0xffd2e7e4),
      onSecondaryFixed: Color(0xff0c1f1d),
      secondaryFixedDim: Color(0xffb6cbc8),
      onSecondaryFixedVariant: Color(0xff374a49),
      tertiaryFixed: Color(0xffeaddff),
      onTertiaryFixed: Color(0xff201537),
      tertiaryFixedDim: Color(0xffcfbfeb),
      onTertiaryFixedVariant: Color(0xff4d4165),
      surfaceDim: Color(0xff111414),
      surfaceBright: Color(0xff373a39),
      surfaceContainerLowest: Color(0xff0c0f0e),
      surfaceContainerLow: Color(0xff191c1c),
      surfaceContainer: Color(0xff1d2020),
      surfaceContainerHigh: Color(0xff282a2a),
      surfaceContainerHighest: Color(0xff333535),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa0d5d0),
      surfaceTint: Color(0xff9cd0cc),
      onPrimary: Color(0xff001a19),
      primaryContainer: Color(0xff669a96),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffbacfcc),
      onSecondary: Color(0xff061918),
      secondaryContainer: Color(0xff819592),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffd4c3f0),
      onTertiary: Color(0xff1b0f31),
      tertiaryContainer: Color(0xff988ab3),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111414),
      onSurface: Color(0xfffafbfa),
      onSurfaceVariant: Color(0xffc4cdcb),
      outline: Color(0xff9ca5a3),
      outlineVariant: Color(0xff7c8584),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e3e2),
      inversePrimary: Color(0xff19504d),
      primaryFixed: Color(0xffb7ede8),
      onPrimaryFixed: Color(0xff001413),
      primaryFixedDim: Color(0xff9cd0cc),
      onPrimaryFixedVariant: Color(0xff003d3b),
      secondaryFixed: Color(0xffd2e7e4),
      onSecondaryFixed: Color(0xff021413),
      secondaryFixedDim: Color(0xffb6cbc8),
      onSecondaryFixedVariant: Color(0xff273a38),
      tertiaryFixed: Color(0xffeaddff),
      onTertiaryFixed: Color(0xff160a2c),
      tertiaryFixedDim: Color(0xffcfbfeb),
      onTertiaryFixedVariant: Color(0xff3c3053),
      surfaceDim: Color(0xff111414),
      surfaceBright: Color(0xff373a39),
      surfaceContainerLowest: Color(0xff0c0f0e),
      surfaceContainerLow: Color(0xff191c1c),
      surfaceContainer: Color(0xff1d2020),
      surfaceContainerHigh: Color(0xff282a2a),
      surfaceContainerHighest: Color(0xff333535),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeafffc),
      surfaceTint: Color(0xff9cd0cc),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa0d5d0),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffeafffc),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffbacfcc),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffff9ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffd4c3f0),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111414),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff4fdfb),
      outline: Color(0xffc4cdcb),
      outlineVariant: Color(0xffc4cdcb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e3e2),
      inversePrimary: Color(0xff00302e),
      primaryFixed: Color(0xffbbf1ec),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa0d5d0),
      onPrimaryFixedVariant: Color(0xff001a19),
      secondaryFixed: Color(0xffd6ebe8),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffbacfcc),
      onSecondaryFixedVariant: Color(0xff061918),
      tertiaryFixed: Color(0xffeee2ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffd4c3f0),
      onTertiaryFixedVariant: Color(0xff1b0f31),
      surfaceDim: Color(0xff111414),
      surfaceBright: Color(0xff373a39),
      surfaceContainerLowest: Color(0xff0c0f0e),
      surfaceContainerLow: Color(0xff191c1c),
      surfaceContainer: Color(0xff1d2020),
      surfaceContainerHigh: Color(0xff282a2a),
      surfaceContainerHighest: Color(0xff333535),
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
     scaffoldBackgroundColor: colorScheme.background,
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
