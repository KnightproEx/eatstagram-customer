import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData defaultTheme = ThemeData(
  //color theme
  primaryColor: HexColor('#fdfdfd'),
  accentColor: HexColor('#2f2f2f'),
  backgroundColor: HexColor('#fdfdfd'),
  scaffoldBackgroundColor: HexColor('#fdfdfd'),

  appBarTheme: AppBarTheme(
    color: HexColor('#fdfdfd'),
    elevation: 0.0,
  ),

  //button theme
  buttonTheme: ButtonThemeData(
    buttonColor: HexColor('#2f2f2f'),
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
    ),
  ),

  //snackbar theme
  snackBarTheme: SnackBarThemeData(
      // TODO: Snackbar theme
      ),

  //default font family
  fontFamily: 'Poppins',

  //text theme
  textTheme: TextTheme(
    headline1: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: HexColor('#2f2f2f'),
    ),
    bodyText1: TextStyle(
      fontSize: 16.0,
    ),
    bodyText2: TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
    ),
    button: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: HexColor("#fdfdfd"),
    ),
  ),
);
