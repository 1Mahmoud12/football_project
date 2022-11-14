import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData dark=ThemeData(

  appBarTheme:const AppBarTheme(
      color: Colors.black ,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.black,

      )
  ),

  scaffoldBackgroundColor: Colors.black87,
  textTheme: TextTheme(
      bodyText1:GoogleFonts.roboto(textStyle:const TextStyle(color: Colors.white54,fontSize: 20,fontWeight: FontWeight.w400,overflow: TextOverflow.ellipsis,)),
      bodyText2:GoogleFonts.roboto(textStyle:const TextStyle(color: Colors.white54,fontSize: 20,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,))
  ),
);