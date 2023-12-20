import 'package:flutter/material.dart';

class AppColors {
  // Primary color
  static const MaterialColor primary = MaterialColor(
    _primaryDefaultValue,
    <int, Color>{
      500: Color(_primaryDefaultValue),
      600: Color(0xFF234E8B),
    },
  );
  static const int _primaryDefaultValue = 0xFF1072BA;

  //  NeutralColor
  static const MaterialColor neutral = MaterialColor(
    _neutralDefaultValue,
    <int, Color>{
      100: Color(0xffF9F9F9),
      200: Color(0xffEAEAEA),
      300: Color(0xffB6B6B6),
      400: Color(0xff949494),
      500: Color(_neutralDefaultValue),
    },
  );
  static const int _neutralDefaultValue = 0xFF2C2B31;
}
