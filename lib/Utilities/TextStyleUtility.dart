import 'package:coffinder/Utilities/FontSizeUtility.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TextStyleUtility {
  static TextStyle bigHeaderTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizeUtility.font30);

  static TextStyle mediumHeaderTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizeUtility.font20);
  static TextStyle mediumOpaqueHeaderTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizeUtility.font20,).copyWith(
    foreground: Paint()
      ..color = Colors.black.withOpacity(0.5),
  );

  static TextStyle smallUserCardName = TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizeUtility.font15);

  static TextStyle matchedTextStyle = GoogleFonts.pacifico().copyWith(fontSize: FontSizeUtility.font40);
}