import 'dart:math';

import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SeeAllButton extends StatelessWidget {
  const SeeAllButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.mainColor),
        elevation: const WidgetStatePropertyAll(5),
        padding: WidgetStateProperty.all(
            const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 6)),
        // Set minimum size to prevent default height
        minimumSize: WidgetStateProperty.all(const Size(0, 0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Use min size to fit content
        children: [
          Text(
            "See All",
            style: AppFontsStyle.stylePoppinsRegular13.copyWith(
              fontFamily: "Inter",
              color: Colors.white,
            ),
          ),
          Transform.rotate(
            angle: -pi,
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
