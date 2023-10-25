import 'dart:developer';

import 'package:flutter/material.dart';

class Styles {
  static ThemeData darkMode(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark, primarySwatch: Colors.blue),
      // highlightColor: const Color(0xff372901),
      hoverColor: const Color(0xff3A3A3B),
      focusColor: const Color(0xff0B2512),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
      ),
      disabledColor: Colors.grey,
      cardColor: Colors.black,
      cardTheme: const CardTheme(color: Color(0xff3A3A3B)),
      canvasColor: Colors.black,
      brightness: Brightness.dark,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xff3A3A3B)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )))),
      // appBarTheme: AppBarTheme(
      //   elevation: 0.0,
      // ),
      textTheme: const TextTheme(
        headline1: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4),
        headline2: TextStyle(fontWeight: FontWeight.bold),
        headline3: TextStyle(fontWeight: FontWeight.bold),
        headline4: TextStyle(),
        headline5: TextStyle(),
        headline6: TextStyle(),
        subtitle1: TextStyle(),
        subtitle2: TextStyle(),
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
        button: TextStyle(),
      ),
      textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.white),
    );
  }

  static ThemeData lightMode(BuildContext context) {
    var materialStateColor = MaterialStateColor.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.error)) {
        return Colors.red;
      }
      if (states.contains(MaterialState.focused)) {
        return Theme.of(context).primaryColor;
      }
      return Colors.grey;
    });
    var materialStateTextStyle = MaterialStateTextStyle.resolveWith((states) {
      if (states.contains(MaterialState.error)) {
        return const TextStyle(color: Colors.red);
      }
      if (states.contains(MaterialState.focused)) {
        return TextStyle(color: Theme.of(context).primaryColor);
      }
      return const TextStyle(color: Colors.grey);
    });
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xff2196F3), primary: const Color(0xff2196F3)),
      inputDecorationTheme: InputDecorationTheme(
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).disabledColor)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).disabledColor)),
          prefixIconColor: materialStateColor,
          labelStyle: materialStateTextStyle,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )))),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
              textStyle: MaterialStateProperty.all(
                  Theme.of(context).textTheme.titleMedium!.copyWith(letterSpacing: 1.2)),
              side: MaterialStateProperty.all(BorderSide(color: Theme.of(context).primaryColor)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )))),
    );
  }
}
