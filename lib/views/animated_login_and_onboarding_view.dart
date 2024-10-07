import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/login_and_signup/login_register_view.dart';
import 'package:clinic_booking_app/views/on_boarding/on_boarding_view.dart';
import 'package:flutter/material.dart';

class AnimatedLoginAndOnBoardingView extends StatefulWidget {
  const AnimatedLoginAndOnBoardingView({super.key});

  @override
  State<AnimatedLoginAndOnBoardingView> createState() =>
      _AnimatedLoginAndOnBoardingViewState();
}

class _AnimatedLoginAndOnBoardingViewState
    extends State<AnimatedLoginAndOnBoardingView> {
  bool isShowSignUp = false;
  bool isShowLogIn = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: Duration(milliseconds: mediumAnimationDuration),
              curve: Curves.easeIn,
              width: size.width,
              height: size.height,
              top: isShowLogIn || isShowSignUp ? -size.height : 0,
              child: OnBoardingView(
                onPressedLogin: () {
                  isShowLogIn = true;
                  setState(() {});
                },
                onPressedSignUp: () {
                  isShowSignUp = true;
                  setState(() {});
                },
              )),
          AnimatedPositioned(
              duration: Duration(milliseconds: mediumAnimationDuration),
              curve: Curves.easeIn,
              width: size.width,
              height: size.height,
              top: isShowLogIn || isShowSignUp ? 0 : size.height,
              child: LoginAndRegisterView(
                isSignUp: isShowSignUp,
              ))
        ],
      ),
    );
  }
}
