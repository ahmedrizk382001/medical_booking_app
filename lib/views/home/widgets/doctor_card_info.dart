import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCardInfo extends StatelessWidget {
  const DoctorCardInfo({
    super.key,
    required this.doctorIndex,
    this.isSearch,
  });

  final int doctorIndex;
  final bool? isSearch;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (isSearch != null
                      ? bottomNavViewModel.filteredDoctors[doctorIndex]
                      : bottomNavViewModel.doctorsList[doctorIndex])
                  .doctorName,
              style: AppFontsStyle.stylePoppinsSemiBold15,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              (isSearch != null
                      ? bottomNavViewModel.filteredDoctors[doctorIndex]
                      : bottomNavViewModel.doctorsList[doctorIndex])
                  .jobTitle,
              style: AppFontsStyle.stylePoppinsSemiBold15.copyWith(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                  color: const Color(0Xff9C9C9C)),
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  size: 13,
                  color: Color(0xff333333),
                ),
                Text(
                  (isSearch != null
                          ? bottomNavViewModel.filteredDoctors[doctorIndex]
                          : bottomNavViewModel.doctorsList[doctorIndex])
                      .workingHours,
                  style: AppFontsStyle.stylePoppinsRegular13.copyWith(
                    color: const Color(0xff333333),
                  ),
                ),
              ],
            ),
            Text(
              "Fee: ${(isSearch != null ? bottomNavViewModel.filteredDoctors[doctorIndex] : bottomNavViewModel.doctorsList[doctorIndex]).fee}",
              style: AppFontsStyle.stylePoppinsRegular13.copyWith(
                color: const Color(0xff9C9C9C),
                fontSize: 15,
              ),
            ),
          ],
        );
      },
    );
  }
}
