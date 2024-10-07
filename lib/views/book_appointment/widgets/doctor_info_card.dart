import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorInfoCard extends StatelessWidget {
  const DoctorInfoCard({
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
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: _containerBoxDecotrationConfig(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                (isSearch != null
                        ? bottomNavViewModel.filteredDoctors[doctorIndex]
                        : bottomNavViewModel.doctorsList[doctorIndex])
                    .doctorName,
                style: AppFontsStyle.stylePoppinsSemiBold24
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                (isSearch != null
                        ? bottomNavViewModel.filteredDoctors[doctorIndex]
                        : bottomNavViewModel.doctorsList[doctorIndex])
                    .jobTitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppFontsStyle.stylePoppinsSemiBold15.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                (isSearch != null
                        ? bottomNavViewModel.filteredDoctors[doctorIndex]
                        : bottomNavViewModel.doctorsList[doctorIndex])
                    .education,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppFontsStyle.stylePoppinsSemiBold15.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  BoxDecoration _containerBoxDecotrationConfig() {
    return BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(0, 4),
            blurRadius: 5,
          )
        ]);
  }
}
