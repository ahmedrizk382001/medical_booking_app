import 'package:flutter/material.dart';

Future<dynamic> pushRemove(BuildContext context, Widget newRoute) =>
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => newRoute,
        ),
        (Route<dynamic> route) => false);

Future<dynamic> pushOnly(BuildContext context, Widget newRoute) async {
  return await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => newRoute,
    ),
  );
}

Future<dynamic> pushRemoveUntil(BuildContext context, Widget newRoute,
        {int? duration}) =>
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => newRoute,
        transitionDuration:
            Duration(milliseconds: duration ?? 1000), // Custom duration
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Example: Fade Transition
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      (Route<dynamic> route) => false,
    );
