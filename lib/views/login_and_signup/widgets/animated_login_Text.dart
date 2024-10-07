import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class LoginTextAnimation extends StatefulWidget {
  const LoginTextAnimation(
      {super.key,
      required this.size,
      required this.isShowSignUp,
      required this.onTap});

  final Size size;
  final bool isShowSignUp;
  final void Function()? onTap;

  @override
  State<LoginTextAnimation> createState() => _LoginTextAnimationState();
}

class _LoginTextAnimationState extends State<LoginTextAnimation> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: Duration(milliseconds: shortAnimationDuration),
        curve: Curves.easeIn,
        width: widget.size.width,
        bottom: widget.isShowSignUp
            ? widget.size.height / 2
            : widget.size.height * 0.3,
        right: widget.isShowSignUp
            ? widget.size.width * 0.44
            : widget.size.width * 0.06,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedRotation(
            duration: Duration(milliseconds: shortAnimationDuration),
            curve: Curves.easeIn,
            turns: widget.isShowSignUp ? -0.25 : 0,
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: shortAnimationDuration),
              textAlign: TextAlign.center,
              style: widget.isShowSignUp
                  ? AppFontsStyle.stylePoppinsSemiBold24.copyWith(
                      fontFamily: "Inter",
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    )
                  : AppFontsStyle.stylePoppinsSemiBold24.copyWith(
                      fontFamily: "Inter",
                      fontSize: 32,
                      color: Colors.white,
                    ),
              child: const Text("LOG IN"),
            ),
          ),
        ));
  }
}
