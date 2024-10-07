import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required Animation<Offset> textAnimation,
    required AnimationController textAnimationController,
  })  : _textAnimation = textAnimation,
        _textAnimationController = textAnimationController;

  final Animation<Offset> _textAnimation;
  final AnimationController _textAnimationController;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _textAnimation,
      child: FadeTransition(
        opacity: _textAnimationController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "your easy way to",
              style: AppFontsStyle.stylePoppinsSemiBold24.copyWith(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                fontSize: 32,
              ),
            ),
            Text(
              "manage your health",
              style: AppFontsStyle.stylePoppinsSemiBold24.copyWith(
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
                fontSize: 32,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
