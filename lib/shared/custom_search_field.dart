import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

Container searchField({
  TextEditingController? controller,
  bool? enabled,
  void Function(String)? onChanged,
}) {
  return Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.17),
          blurRadius: 20,
          offset: const Offset(5, 10),
          spreadRadius: 1,
        ),
      ],
    ),
    child: TextFormField(
      controller: controller,
      style: AppFontsStyle.stylePoppinsSemiBold15.copyWith(
        color: AppColors.secondaryColor,
        fontWeight: FontWeight.w500,
      ),
      enabled: enabled ?? true,
      onChanged: onChanged,
      cursorColor: AppColors.mainColor,
      decoration: _searchInputDecoration(),
    ),
  );
}

InputDecoration _searchInputDecoration() {
  return InputDecoration(
      contentPadding: const EdgeInsets.all(0),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: _outLineBorderStyle(),
      disabledBorder: _outLineBorderStyle(),
      focusedBorder: _outLineBorderStyle(),
      hintText: "Search",
      hintStyle: AppFontsStyle.stylePoppinsRegular12.copyWith(
        color: Colors.black.withOpacity(0.5),
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w300,
      ),
      prefixIcon: const Icon(
        EvaIcons.searchOutline,
        color: AppColors.secondaryColor,
        size: 25,
      ));
}

OutlineInputBorder _outLineBorderStyle() {
  return OutlineInputBorder(
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
      borderRadius: BorderRadius.circular(20));
}
