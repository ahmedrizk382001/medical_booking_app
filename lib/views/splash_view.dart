import 'package:clinic_booking_app/shared/common_widgets.dart';
import 'package:clinic_booking_app/shared/navigation.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/animated_login_and_onboarding_view.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.isLoggedIn});

  final bool isLoggedIn;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _appNameAnimationController;
  late Animation<double> _appNameAnimation;

  late AnimationController _subtitleAnimationController;
  late Animation<double> _subtitleAnimation;
  late Offset _animatedSlideOffset = const Offset(0, 0.5);

  @override
  void initState() {
    super.initState();
    _appSubtitleAnimationConfig();
    _appNameAnimationConfig();
  }

  @override
  void dispose() {
    _appNameAnimationController.dispose();
    _subtitleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: backgroundContainer(
          color: AppColors.mainColor,
          padding: const EdgeInsets.all(64),
          child: _splashViewBody(context)),
    );
  }

  Container _splashViewBody(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _appNameAnimated(),
            _appSubtitleAnimated(),
          ],
        ),
      ),
    );
  }

  FadeTransition _appSubtitleAnimated() {
    return FadeTransition(
      opacity: _subtitleAnimation,
      child: AnimatedSlide(
        offset: _animatedSlideOffset,
        duration: Duration(milliseconds: mediumAnimationDuration),
        child: const Text(
          "Your health, one click away.",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  FadeTransition _appNameAnimated() {
    return FadeTransition(
      opacity: _appNameAnimation,
      child: ScaleTransition(
        scale: _appNameAnimation,
        child: const Text(
          "MediBook",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 48,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _appNameAnimationConfig() {
    _appNameAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mediumAnimationDuration),
    );

    _appNameAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _appNameAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _appNameAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _subtitleAnimationController.forward();
          setState(() {});
        }
      },
    );

    _appNameAnimationController.forward();
  }

  void _appSubtitleAnimationConfig() async {
    _subtitleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mediumAnimationDuration),
    );

    _subtitleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _subtitleAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _subtitleAnimationController.addListener(
      () {
        if (_subtitleAnimationController.value > 0) {
          _animatedSlideOffset = const Offset(0, 0);
          setState(() {});
        }
      },
    );

    _subtitleAnimation.addStatusListener(
      (status) async {
        if (status == AnimationStatus.completed) {
          await Future.delayed(const Duration(milliseconds: 500));
          pushRemoveUntil(
              context,
              widget.isLoggedIn
                  ? const BottomNavView()
                  : const AnimatedLoginAndOnBoardingView());
        }
      },
    );
  }
}
