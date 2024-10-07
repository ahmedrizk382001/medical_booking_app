import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

Widget backgroundContainer(
        {required Widget child,
        required Color color,
        EdgeInsetsGeometry? padding,
        double? width}) =>
    Container(
      padding: padding,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color.withOpacity(0.8),
              color,
              color.withOpacity(0.8),
              color,
              color.withOpacity(0.8),
            ]),
      ),
      child: child,
    );

Widget customTextFormField({
  required String hintText,
  required TextEditingController? controller,
  String? Function(String?)? validator,
  void Function(String)? onFieldSubmitted,
  bool obscureText = false,
  Color? hintTextColor,
  Color? inputColor,
}) =>
    TextFormField(
      style: AppFontsStyle.stylePoppinsSemiBold15.copyWith(
        color: inputColor ?? Colors.white,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: AppColors.mainColor,
      decoration: InputDecoration(
        fillColor: Colors.white.withOpacity(0.3),
        filled: true,
        focusColor: Colors.white.withOpacity(0.3),
        hintText: hintText,
        hintStyle: AppFontsStyle.stylePoppinsSemiBold15.copyWith(
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            color: hintTextColor ?? AppColors.secondaryColor),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.all(16),
      ),
    );

void showCustomSnackBar(
  BuildContext context, {
  required String message,
}) {
  final snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: AppColors.secondaryColor,
    duration: const Duration(seconds: 2), // Optional duration
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
