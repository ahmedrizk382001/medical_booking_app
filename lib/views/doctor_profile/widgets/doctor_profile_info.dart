import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/doctor_profile/widgets/doctor_profile_rate.dart';
import 'package:flutter/material.dart';

class DoctorProfileInfo extends StatelessWidget {
  const DoctorProfileInfo({
    super.key,
    required this.doctorIndex,
    this.isSearch,
  });

  final int doctorIndex;
  final bool? isSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                (isSearch != null
                        ? bottomNavViewModel.filteredDoctors[doctorIndex]
                        : bottomNavViewModel.doctorsList[doctorIndex])
                    .doctorName,
                overflow: TextOverflow.ellipsis,
                style: AppFontsStyle.stylePoppinsSemiBold16,
              ),
              const Spacer(),
              DoctorProfileRate(
                doctorIndex: doctorIndex,
              )
            ],
          ),
          Text(
            (isSearch != null
                    ? bottomNavViewModel.filteredDoctors[doctorIndex]
                    : bottomNavViewModel.doctorsList[doctorIndex])
                .jobTitle,
            overflow: TextOverflow.ellipsis,
            style: AppFontsStyle.stylePoppinsRegular12.copyWith(
              fontWeight: FontWeight.w500,
              color: const Color(0xff878787),
            ),
          ),
        ],
      ),
    );
  }
}
