
// import 'package:get_storage/'
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import 'package:google_fonts/google_fonts.dart';

class ThemeSer{
  final _box = GetStorage();
  final _key = 'darkMode';
 _saveTheme(bool darkMode)=>_box.write(_key, darkMode);
  bool _loadThemeFromBox()=> _box.read(_key)??false;

  ThemeMode get theme=> _loadThemeFromBox()?ThemeMode.dark:ThemeMode.light;
  void switchTheme(){
    Get.changeThemeMode(_loadThemeFromBox()?ThemeMode.light:ThemeMode.dark);
    _saveTheme(!_loadThemeFromBox());
  }
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
      )

  );
}
  TextStyle get titleStyle{
    return GoogleFonts.lato (
        textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
        )

    );

}
TextStyle get subtitleStyle{
  return GoogleFonts.lato (
      textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,

      )

  );

}
TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      )

  );
}
TextStyle get greetStyle {
  return GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold,

      )

  );
}