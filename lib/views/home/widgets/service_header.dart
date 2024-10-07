import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/home/widgets/see_all_button.dart';
import 'package:flutter/material.dart';

class ServiceHeader extends StatelessWidget {
  const ServiceHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Services",
          style: AppFontsStyle.stylePoppinsSemiBold24,
        ),
        Spacer(),
        SeeAllButton()
      ],
    );
  }
}
