import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/shared/common_widgets.dart';
import 'package:flutter/material.dart';

class SignUpInputs extends StatelessWidget {
  const SignUpInputs({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController nameController,
      emailController,
      passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          customTextFormField(
            hintText: "Name",
            controller: nameController,
            validator: (name) {
              if (name!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          customTextFormField(
            hintText: "Email",
            controller: emailController,
            validator: (email) {
              if (email!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          customTextFormField(
            hintText: "Password",
            controller: passwordController,
            obscureText: true,
            validator: (password) {
              if (password!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Forget password?",
              style: AppFontsStyle.stylePoppinsSemiBold16.copyWith(
                  fontFamily: "Inter",
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
