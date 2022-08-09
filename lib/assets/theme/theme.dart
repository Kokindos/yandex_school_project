import 'package:flutter/material.dart';

abstract class AppTheme {
  static const _primaryTextColor = Color(0xFF000000);
  static const _primaryColor = Color(0xFF007AFF);
  static const red = Color(0xFFFF3B30);
  static const green = Color(0xFF34C759);

  static ThemeData get lightTheme => ThemeData(
        disabledColor: const Color(0x26000000),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintStyle: TextStyle(
            fontSize: 16,
            height: 20 / 16,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(.3),
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Color(0xFFF7F6F2),
          elevation: 0,
          iconTheme: IconThemeData(color: _primaryTextColor),
        ),
        primaryColor: _primaryColor,
        dividerColor: Colors.black.withOpacity(.2),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(
            Colors.white,
          ),
        ),
        hintColor: const Color(0x4D000000),
        scaffoldBackgroundColor: const Color(0xFFF7F6F2),
        backgroundColor: const Color(0xFFFFFFFF),
        textTheme: TextTheme(
          headline1: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w500,
            height: 38 / 32,
            color: _primaryTextColor,
          ),
          headline2: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 32 / 20,
            color: _primaryTextColor,
          ),
          bodyText2: const TextStyle(
            fontSize: 16,
            height: 20 / 16,
            fontWeight: FontWeight.w400,
            color: _primaryTextColor,
          ),
          button: const TextStyle(
            fontSize: 14,
            height: 24 / 14,
            fontWeight: FontWeight.w500,
            color: _primaryTextColor,
          ),
          subtitle2: const TextStyle(
            fontSize: 14,
            height: 20 / 14,
            fontWeight: FontWeight.w400,
            color: _primaryTextColor,
          ),
          overline: TextStyle(
            fontSize: 16,
            height: 20 / 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.10,
            color: Colors.black.withOpacity(.3),
          ),
        ),
      );
}
