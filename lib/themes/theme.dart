import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final mainTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  listTileTheme: ListTileThemeData(iconColor: Colors.black),
  dividerColor: Colors.black38,
  appBarTheme: AppBarTheme(color: Colors.black, elevation: 0),
  textTheme: TextTheme(
      bodySmall: TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.normal,
        fontSize: 13,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: TextStyle(color: Colors.black, fontSize: 17),
      headlineSmall:
          GoogleFonts.robotoSerif(fontSize: 14, color: Colors.black87),
      headlineMedium: GoogleFonts.robotoSerif(
          fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500),
      headlineLarge: GoogleFonts.robotoSerif(
          textStyle: TextStyle(fontSize: 25, color: Colors.black54))),
);
