import 'package:flutter/material.dart';

class CustomSafeArea extends StatelessWidget implements PreferredSizeWidget {
  const CustomSafeArea({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: null,
      backgroundColor: Colors.white, // Set background color to white
      elevation: 0,
      scrolledUnderElevation: 0, // Ensure no shadow appears when scrolling
      shadowColor: Colors.transparent, // No shadow color
      surfaceTintColor: Colors.transparent, // Avoid any surface tint color
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(16); // Standard app bar height
}
