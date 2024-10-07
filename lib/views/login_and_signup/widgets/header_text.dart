import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  const HeaderText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Discover".toUpperCase(),
          textAlign: TextAlign.center,
          style: AppFontsStyle.stylePoppinsSemiBold24.copyWith(
            fontFamily: "Inter",
            fontSize: 32,
            color: Colors.white,
          ),
        ),
        Text(
          "Care!".toUpperCase(),
          textAlign: TextAlign.center,
          style: AppFontsStyle.stylePoppinsSemiBold24.copyWith(
            fontFamily: "Inter",
            fontSize: 32,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
