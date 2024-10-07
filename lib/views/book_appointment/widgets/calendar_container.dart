import 'package:flutter/material.dart';

class CalendarContainer extends StatelessWidget {
  const CalendarContainer({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 13,
        bottom: 17,
        left: 13,
        right: 13,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.sizeOf(context).width * 0.07,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 8),
            blurRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }
}
