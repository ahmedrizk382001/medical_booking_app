import 'package:flutter/material.dart';

class AppFontsStyle {
  static const stylePoppinsSemiBold24 = TextStyle(
    fontFamily: "Poppins",
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryColor,
  );

  static const stylePoppinsSemiBold15 = TextStyle(
    fontFamily: "Poppins",
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryColor,
  );

  static const stylePoppinsSemiBold16 = TextStyle(
    fontFamily: "Poppins",
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryColor,
  );

  static const stylePoppinsLightItalic15 = TextStyle(
    fontFamily: "Poppins",
    fontSize: 15,
    fontWeight: FontWeight.w300,
    color: Colors.white,
    fontStyle: FontStyle.italic,
  );

  static const stylePoppinsRegular13 = TextStyle(
    fontFamily: "Poppins",
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: Color(0xff333333),
  );

  static const stylePoppinsRegular12 = TextStyle(
    fontFamily: "Poppins",
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Color(0xff878787),
  );
}

class AppColors {
  static const mainColor = Color(0xff3E69FE);
  static const secondaryColor = Color(0xff1E1F2E);
}
