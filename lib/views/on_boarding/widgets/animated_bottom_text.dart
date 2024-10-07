import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class AnimatedBottomText extends StatefulWidget {
  const AnimatedBottomText({super.key, required this.isBottomAnimationEnd});

  final bool isBottomAnimationEnd;

  @override
  State<AnimatedBottomText> createState() => _AnimatedBottomTextState();
}

class _AnimatedBottomTextState extends State<AnimatedBottomText> {
  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: widget.isBottomAnimationEnd ? 1 : 0,
      duration: Duration(milliseconds: shortAnimationDuration),
      child: AnimatedOpacity(
        opacity: widget.isBottomAnimationEnd ? 1 : 0,
        duration: Duration(milliseconds: shortAnimationDuration),
        child: Text(
          "Not a member yet? sign up now!",
          style: AppFontsStyle.stylePoppinsSemiBold16.copyWith(
              fontFamily: "Inter",
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ),
      ),
    );
  }
}
