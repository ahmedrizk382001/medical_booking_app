import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/images.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/home/widgets/doctor_card_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DoctorCardRateAndButton extends StatelessWidget {
  const DoctorCardRateAndButton({
    super.key,
    required this.doctorIndex,
    required this.onPressed,
    this.isSearch,
  });

  final int doctorIndex;
  final bool? isSearch;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _doctorCardRate(isSearch),
        const Spacer(),
        DoctorCardButton(
          onPressed: onPressed,
        ),
      ],
    );
  }

  Row _doctorCardRate(bool? isSearch) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(Assets.imagesStarFill),
        const SizedBox(
          width: 3,
        ),
        Text(
          (isSearch != null
                  ? bottomNavViewModel.filteredDoctors[doctorIndex]
                  : bottomNavViewModel.doctorsList[doctorIndex])
              .rate
              .toString(),
          style: AppFontsStyle.stylePoppinsRegular13.copyWith(
            fontWeight: FontWeight.w500,
            color: const Color(0xff333333),
          ),
        ),
      ],
    );
  }
}
