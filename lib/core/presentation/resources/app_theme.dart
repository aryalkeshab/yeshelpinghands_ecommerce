import 'package:yeshelpinghand/core/presentation/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemes {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        primaryColor: colorScheme.primary,
        primaryColorLight: primaryColorLight,
        colorScheme: colorScheme,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          color: colorScheme.primary,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor,
        buttonTheme: ButtonThemeData(
          buttonColor: colorScheme.onSurface,
        ),
        textTheme: textTheme,
        fontFamily: 'Roboto',
        dividerColor: dividerColor,
        disabledColor: disabledColor,
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: colorScheme.primary,
        ));
  }

  static const textTheme = TextTheme(
    headline6: TextStyle(fontSize: 15.0, color: Colors.black, height: 1.3),
    headline5: TextStyle(fontSize: 16.0, color: Colors.black, height: 1.3),
    headline4: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        height: 1.3),
    headline3: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        height: 1.3),
    headline2: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Colors.black,
        height: 1.4),
    headline1: TextStyle(
        fontSize: 19.0,
        fontWeight: FontWeight.w300,
        color: Colors.black,
        height: 1.4),
    subtitle1: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        height: 1.3),
    bodyText2: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        height: 1.2),
    bodyText1: TextStyle(
        fontSize: 14.0,
        // fontWeight: FontWeight.w400,
        color: Colors.black,
        height: 1.3),
    caption: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w300,
        color: Colors.black,
        height: 1.2),
  );

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primaryColor,
    secondary: secondaryColor,
    background: scaffoldBackgroundColor,
    surface: Colors.white,
    onBackground: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: primaryColor,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: primaryColor,
    secondary: secondaryColor,
    background: backgroundDark,
    surface: Color(0xff1E2746),
    onBackground: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}
