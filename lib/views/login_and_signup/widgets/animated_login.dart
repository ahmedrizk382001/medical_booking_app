import 'package:clinic_booking_app/shared/common_widgets.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/login_and_signup/widgets/login_inputs.dart';
import 'package:flutter/material.dart';

class AnimatedLoginInputs extends StatefulWidget {
  const AnimatedLoginInputs(
      {super.key,
      required this.size,
      required this.onTap,
      required this.isShowSignUp,
      required this.emailController,
      required this.passwordController});

  final Size size;
  final bool isShowSignUp;
  final void Function()? onTap;
  final TextEditingController emailController, passwordController;

  @override
  State<AnimatedLoginInputs> createState() => _AnimatedLoginInputsState();
}

class _AnimatedLoginInputsState extends State<AnimatedLoginInputs> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: shortAnimationDuration),
      width: widget.size.width * 0.88,
      height: widget.size.height,
      left: widget.isShowSignUp ? -widget.size.width * 0.76 : 0,
      child: GestureDetector(
        onTap: widget.onTap,
        child: backgroundContainer(
          color: AppColors.mainColor,
          child: AnimatedOpacity(
              duration: Duration(milliseconds: shortAnimationDuration),
              opacity: widget.isShowSignUp ? 0 : 1,
              child: LoginInputs(
                emailController: widget.emailController,
                passwordController: widget.passwordController,
              )),
        ),
      ),
    );
  }
}
