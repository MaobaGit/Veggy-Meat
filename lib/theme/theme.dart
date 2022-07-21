import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:veggy/theme/colors.dart';

// Se establece el tema de toda la aplicación
ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.grey[50],
    backgroundColor: ColorsApp.backgroundColor,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    primaryColor: ColorsApp.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline1: GoogleFonts.roboto(
        fontSize: 296, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.roboto(
        fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.roboto(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.roboto(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.roboto(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.roboto(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.roboto(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.roboto(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
    ),
  );
}
