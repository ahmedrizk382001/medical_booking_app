import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class OnBoardingButtons extends StatefulWidget {
  const OnBoardingButtons(
      {super.key,
      required this.loginOnPressed,
      required this.registerOnPressed});

  final void Function()? loginOnPressed, registerOnPressed;

  @override
  State<OnBoardingButtons> createState() => _OnBoardingButtonsState();
}

class _OnBoardingButtonsState extends State<OnBoardingButtons>
    with SingleTickerProviderStateMixin {
  late AnimationController _buttonsAnimationController;
  late Animation<double> _buttonsAnimation;

  bool isBottonAnimationEnd = false;

  @override
  void initState() {
    buttonsAnimationInit();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _buttonsAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: FadeTransition(
        opacity: _buttonsAnimation,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: widget.loginOnPressed,
                style: bottonStyle(color: Colors.white.withOpacity(0.3)),
                child: AnimatedScale(
                  scale: isBottonAnimationEnd ? 1 : 0,
                  duration: Duration(milliseconds: shortAnimationDuration),
                  child: AnimatedOpacity(
                    opacity: isBottonAnimationEnd ? 1 : 0,
                    duration: Duration(milliseconds: shortAnimationDuration),
                    child: Text(
                      "Log In",
                      style: AppFontsStyle.stylePoppinsSemiBold16.copyWith(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: widget.registerOnPressed,
                style: bottonStyle(color: Colors.white),
                child: AnimatedScale(
                  scale: isBottonAnimationEnd ? 1 : 0,
                  duration: Duration(milliseconds: shortAnimationDuration),
                  child: AnimatedOpacity(
                    opacity: isBottonAnimationEnd ? 1 : 0,
                    duration: Duration(milliseconds: shortAnimationDuration),
                    child: Text(
                      "Sign Up",
                      style: AppFontsStyle.stylePoppinsSemiBold16.copyWith(
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w700,
                          color: AppColors.mainColor),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  ButtonStyle bottonStyle({required Color? color}) => ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
        elevation: const WidgetStatePropertyAll(0),
        backgroundColor: WidgetStatePropertyAll(color),
      );

  void buttonsAnimationInit() {
    _buttonsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1300,
      ),
    );
    _buttonsAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_buttonsAnimationController);
    _buttonsAnimationController.forward();
    _buttonsAnimationController.addStatusListener(
      (status) {
        if (status.isCompleted) {
          isBottonAnimationEnd = true;
          setState(() {});
        }
      },
    );
  }
}
