import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      this.centerTitle,
      this.leading,
      required this.action});

  final String title;
  final bool? centerTitle;
  final Widget? leading;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title.toUpperCase(),
        style: AppFontsStyle.stylePoppinsSemiBold16,
      ),
      titleTextStyle: const TextStyle(
        color: AppColors.secondaryColor,
      ),
      centerTitle: centerTitle,
      leading: leading,
      actions: [action],
      backgroundColor: Colors.white, // Set background color to white
      elevation: 0,
      scrolledUnderElevation: 0, // Ensure no shadow appears when scrolling
      shadowColor: Colors.transparent, // No shadow color
      surfaceTintColor: Colors.transparent, // Avoid any surface tint color
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Standard app bar height
}
