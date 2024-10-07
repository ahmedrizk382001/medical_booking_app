import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomUserProfileTextfield extends StatelessWidget {
  const CustomUserProfileTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.isEnabled,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(5, 10),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        enabled: isEnabled,
        cursorColor: AppColors.mainColor,
        decoration: _customUserProfileTextInputDecoration(),
      ),
    );
  }

  InputDecoration _customUserProfileTextInputDecoration() {
    return InputDecoration(
        contentPadding: const EdgeInsets.all(0),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: _outLineBorderStyle(),
        focusedBorder: _outLineBorderStyle(),
        disabledBorder: _outLineBorderStyle(),
        hintText: hintText,
        hintStyle: AppFontsStyle.stylePoppinsRegular12.copyWith(
          color: Colors.black.withOpacity(0.5),
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w300,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.secondaryColor,
          size: 25,
        ));
  }

  OutlineInputBorder _outLineBorderStyle() {
    return OutlineInputBorder(
        borderSide: const BorderSide(width: 0, color: Colors.transparent),
        borderRadius: BorderRadius.circular(20));
  }
}
