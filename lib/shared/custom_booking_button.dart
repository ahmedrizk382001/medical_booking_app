import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CustomBookingButton extends StatelessWidget {
  const CustomBookingButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.margin,
    required this.isDisable,
  });

  final void Function()? onPressed;
  final String buttonText;
  final EdgeInsetsGeometry? margin;
  final bool isDisable;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 45, vertical: 0),
      width: double.infinity,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 14)),
            backgroundColor: WidgetStatePropertyAll(
              isDisable ? Colors.grey.shade300 : AppColors.mainColor,
            ),
          ),
          child: Text(
            buttonText,
            style: AppFontsStyle.stylePoppinsSemiBold16
                .copyWith(color: isDisable ? Colors.black54 : Colors.white),
          )),
    );
  }
}
