import 'package:flutter/material.dart';

class ExColor {
  Color get graduationStart => const Color(0xFFFFC500);
  Color get graduationEnd => const Color(0xFFF500FF);

  Color get textGraduationStart => const Color(0xFFFA7D7D);
  Color get textGraduationEnd => const Color(0xFFFF1BD6);

  Color get backGroundColor => const Color(0xFFF2F2F2);
  Color get cardColor => const Color.fromARGB(255, 255, 255, 255);
}

class ExThemeConfig {
  // static FontSize get fontSize => FontSize();
  static ExColor get color => ExColor();
}
