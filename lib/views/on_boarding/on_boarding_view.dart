import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/shared/common_widgets.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/on_boarding/widgets/animated_bottom_text.dart';
import 'package:clinic_booking_app/views/on_boarding/widgets/on_boarding_buttons.dart';
import 'package:clinic_booking_app/views/on_boarding/widgets/on_boarding_intro.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView(
      {super.key, required this.onPressedLogin, required this.onPressedSignUp});

  final void Function()? onPressedLogin, onPressedSignUp;

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView>
    with TickerProviderStateMixin {
  late AnimationController _bottomTextAnimationController;
  late AnimationController _nextPageAnimationController;
  late Animation<Offset> _nextPageAnimation;
  bool isBottomAnimationEnd = false;

  @override
  void initState() {
    bottomTextAnimationInit();
    _nextPageAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: shortAnimationDuration,
      ),
    );
    _nextPageAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, -1))
            .animate(_nextPageAnimationController);

    super.initState();
  }

  @override
  void dispose() {
    _bottomTextAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _nextPageAnimation,
      child: backgroundContainer(
        color: AppColors.mainColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const OnBoardingIntro(),
            OnBoardingButtons(
              loginOnPressed: widget.onPressedLogin,
              registerOnPressed: widget.onPressedSignUp,
            ),
            AnimatedBottomText(
              isBottomAnimationEnd: isBottomAnimationEnd,
            ),
          ],
        ),
      ),
    );
  }

  void bottomTextAnimationInit() {
    _bottomTextAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: mediumAnimationDuration,
      ),
    );
    _bottomTextAnimationController.forward();
    _bottomTextAnimationController.addStatusListener(
      (status) {
        if (status.isCompleted) {
          isBottomAnimationEnd = true;
          setState(() {});
        }
      },
    );
  }
}
