import 'package:flutter/material.dart';

class NewTheme {
  Color _lightBlue = Color.fromARGB(255, 213, 235, 220);
  Color _lightGrey = Color.fromARGB(255, 164, 164, 164);
  Color _darkerBlue = Color.fromARGB(255, 119, 124, 135);

  ThemeData buildTheme() {
    return ThemeData(
      //fontFamily: 'Inter',
      canvasColor: _lightBlue,
      primaryColor: _lightBlue,
      accentColor: _lightGrey,
      secondaryHeaderColor: _darkerBlue,
      hintColor: _lightGrey,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: _lightGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(
            color: _lightBlue,
          ),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: _darkerBlue,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        minWidth: 200,
        height: 40.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
