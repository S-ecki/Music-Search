import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData theme() {
  return ThemeData(
    primaryColor: Color(0xFF21BFBD),
    accentColor: Color(0xFF7A9BEE),
    textTheme: GoogleFonts.ralewayTextTheme(),
    primaryTextTheme: GoogleFonts.ralewayTextTheme(),
    accentTextTheme: TextTheme(
      // for search result header
      bodyText1: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 19),
      // body of album
      bodyText2: GoogleFonts.raleway(fontSize: 16, color: Colors.white),
      // appbar 
      headline1: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
      // headers of album
      headline2: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
    ),

  );
}