import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme();

  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      inputDecorationTheme: _inputDecorationTheme,
      filledButtonTheme: _filledButtonTheme,
    );
  }


  static TextTheme get _textTheme {
    // Define your custom font families and styles here
    const TextStyle bodyTextStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
    );

    const TextStyle headingTextStyle = TextStyle(
      fontFamily: 'Roboto',
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    // Return a TextTheme object with your custom font styles
    return TextTheme(
      displayLarge: headingTextStyle.copyWith(fontSize: 36.0),
      displayMedium: headingTextStyle.copyWith(fontSize: 24.0),
      displaySmall: headingTextStyle.copyWith(fontSize: 18.0),
      headlineLarge: headingTextStyle.copyWith(fontSize: 32.0),
      headlineMedium: headingTextStyle.copyWith(fontSize: 20.0),
      headlineSmall: headingTextStyle.copyWith(fontSize: 16.0),
      bodyLarge: bodyTextStyle.copyWith(fontSize: 18.0),
      bodyMedium: bodyTextStyle.copyWith(fontSize: 16.0),
      bodySmall: bodyTextStyle.copyWith(fontSize: 14.0),
    );
  }


  static ColorScheme get _colorScheme {
    return const ColorScheme(
      brightness: Brightness.light,
      primary:Colors.red,
      onPrimary: Color(0xffFFFFFF),
      primaryContainer: Color(0xfff2f3fb),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xff9c254d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffdfa3b7),
      tertiary: Color(0xffb6c2ff),
      tertiaryContainer: Color(0xffffffff),
      errorContainer: Color(0xfffcd8df),
      onErrorContainer: Color(0xff000000),
      surfaceVariant: Color(0xffeeeeee),
      outline: Color(0xff737373),
      outlineVariant: Color(0xffbfbfbf),
      inverseSurface: Color(0xff121212),
      surfaceTint: Color(0xff909cdf),
      error: Color(0xFF5e162e),
      onError: Color(0xFFf5e9ed),
      background: Color(0xFFFFFFFF),
      onBackground: Color(0xff000000),
      surface: Color(0xFFf4f5fc),
      onSurface: Color(0xFF0e1016),
    );
  }


  static InputDecorationTheme get _inputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: _colorScheme.background,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      enabledBorder: _enabledBorder,
      focusedBorder: _focusedBorder,
      disabledBorder: _disabledBorder,
    );
  }

  static FilledButtonThemeData get _filledButtonTheme {
    return FilledButtonThemeData(
      style: FilledButton.styleFrom(
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }

  static InputBorder get _enabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.transparent),
      );

  static InputBorder get _focusedBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none,
      );

  static InputBorder get _disabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
      );
}
