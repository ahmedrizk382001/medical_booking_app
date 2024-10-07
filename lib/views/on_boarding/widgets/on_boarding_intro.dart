import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/utils/images.dart';
import 'package:clinic_booking_app/views/on_boarding/widgets/sliding_text.dart';
import 'package:flutter/material.dart';

class OnBoardingIntro extends StatefulWidget {
  const OnBoardingIntro({
    super.key,
  });

  @override
  State<OnBoardingIntro> createState() => _OnBoardingIntroState();
}

class _OnBoardingIntroState extends State<OnBoardingIntro>
    with TickerProviderStateMixin {
  late AnimationController _containerAnimationController;
  late Animation<double> _containerAnimation;
  late AnimationController _textAnimationController;
  late Animation<Offset> _textAnimation;

  bool isContainerAnimationEnded = false;

  @override
  void initState() {
    // TODO: implement initState
    containterAnimationInit();
    textAnimationInit();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _containerAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _containerAnimation,
      child: Container(
        padding: const EdgeInsets.all(32),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(64), topRight: Radius.circular(64)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 24,
            ),
            AnimatedScale(
              scale: isContainerAnimationEnded ? 1 : 0,
              duration: Duration(milliseconds: shortAnimationDuration),
              child: Image.asset(
                Assets.imageDoctorIntro,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SlidingText(
                textAnimation: _textAnimation,
                textAnimationController: _textAnimationController),
          ],
        ),
      ),
    );
  }

  void textAnimationInit() {
    _textAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: shortAnimationDuration,
      ),
    );
    _textAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
            .animate(_textAnimationController);
  }

  void containterAnimationInit() {
    _containerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _containerAnimation =
        Tween<double>(begin: 0, end: 1).animate(_containerAnimationController);

    _containerAnimationController.forward();
    _containerAnimationController.addStatusListener(
      (status) {
        if (status.isCompleted) {
          isContainerAnimationEnded = true;
          _textAnimationController.forward();
          setState(() {});
        }
      },
    );
  }
}
