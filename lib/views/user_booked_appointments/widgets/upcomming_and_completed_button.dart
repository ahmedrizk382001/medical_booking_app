import 'package:clinic_booking_app/cubit/user_booked_appointments.dart/user_booked_appointments_cubit.dart';
import 'package:clinic_booking_app/cubit/user_booked_appointments.dart/user_booked_appointments_states.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcommingAndCompletedButtons extends StatelessWidget {
  const UpcommingAndCompletedButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBookedAppointmentsCubit,
        UserBookedAppointmentsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var isCompleted =
            userBookedAppointmentsViewModel.isCompletedAppointments;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              Expanded(
                child: _buildTextButton(
                    isActive: !isCompleted,
                    onPressed: () {
                      if (isCompleted) {
                        userBookedAppointmentsViewModel
                            .changeIsCompletedAppointments(
                                isCompletedAppointments: false);
                      }
                    },
                    text: "Upcomming"),
              ),
              Expanded(
                child: _buildTextButton(
                    isActive: isCompleted,
                    onPressed: () {
                      if (!isCompleted) {
                        userBookedAppointmentsViewModel
                            .changeIsCompletedAppointments(
                                isCompletedAppointments: true);
                      }
                    },
                    text: "Compeleted"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextButton({
    required bool isActive,
    required VoidCallback onPressed,
    required String text,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          isActive ? AppColors.mainColor : Colors.transparent,
        ),
      ),
      child: Text(
        text,
        style: AppFontsStyle.stylePoppinsSemiBold16.copyWith(
          color: isActive ? Colors.white : null,
        ),
      ),
    );
  }
}
