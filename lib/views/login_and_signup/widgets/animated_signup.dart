import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/login_and_signup/widgets/sign_up_inputs.dart';
import 'package:flutter/material.dart';

class AnimatedSignUp extends StatefulWidget {
  const AnimatedSignUp(
      {super.key,
      required this.size,
      required this.isShowSignUp,
      required this.onTap,
      required this.nameController,
      required this.emailController,
      required this.passwordController});

  final Size size;
  final bool isShowSignUp;
  final void Function()? onTap;

  final TextEditingController nameController,
      emailController,
      passwordController;

  @override
  State<AnimatedSignUp> createState() => _AnimatedSignUpState();
}

class _AnimatedSignUpState extends State<AnimatedSignUp> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: shortAnimationDuration),
      width: widget.size.width * 0.88,
      height: widget.size.height,
      left: widget.isShowSignUp
          ? widget.size.width * 0.12
          : widget.size.width * 0.88,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          color: AppColors.secondaryColor,
          child: AnimatedOpacity(
              duration: Duration(milliseconds: shortAnimationDuration),
              opacity: widget.isShowSignUp ? 1 : 0,
              child: SignUpInputs(
                  nameController: widget.nameController,
                  emailController: widget.emailController,
                  passwordController: widget.passwordController)),
        ),
      ),
    );
  }
}
