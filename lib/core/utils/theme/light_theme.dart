import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

ThemeData light = ThemeData(

  appBarTheme: const AppBarTheme(
      color: AppColors.indigo,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.indigo,
      )),
  scaffoldBackgroundColor: Colors.white70.withOpacity(.9),
  textTheme: TextTheme(
    bodyText1: GoogleFonts.roboto(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        )),
    bodyText2: GoogleFonts.roboto(
        textStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        )),
  ),
);
