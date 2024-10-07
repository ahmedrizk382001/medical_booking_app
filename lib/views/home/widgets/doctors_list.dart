import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/home/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 13),
                child: Text(
                  "Top Doctors",
                  style: AppFontsStyle.stylePoppinsSemiBold24,
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, doctorIndex) {
                  return DoctorCard(
                    doctorIndex: doctorIndex,
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 30,
                ),
                itemCount: bottomNavViewModel.doctorsList.length,
              ),
            ],
          ),
        );
      },
    );
  }
}
