import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/images.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DoctorProfileRate extends StatelessWidget {
  const DoctorProfileRate({
    super.key,
    required this.doctorIndex,
  });

  final int doctorIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.imagesStarFill),
        const SizedBox(
          width: 3,
        ),
        Text(
          bottomNavViewModel.doctorsList[doctorIndex].rate.toString(),
          style: AppFontsStyle.stylePoppinsRegular13.copyWith(
            fontWeight: FontWeight.w500,
            color: const Color(0xff333333),
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          "(${bottomNavViewModel.doctorsList[doctorIndex].reviews} reviews)",
          style: AppFontsStyle.stylePoppinsRegular13.copyWith(
            fontWeight: FontWeight.w500,
            color: const Color(0xff333333),
          ),
        ),
      ],
    );
  }
}
