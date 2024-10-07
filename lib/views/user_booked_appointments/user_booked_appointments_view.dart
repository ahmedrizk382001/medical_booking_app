import 'package:clinic_booking_app/cubit/user_booked_appointments.dart/user_booked_appointments_cubit.dart';
import 'package:clinic_booking_app/cubit/user_booked_appointments.dart/user_booked_appointments_states.dart';
import 'package:clinic_booking_app/shared/custom_app_bar.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/user_booked_appointments/user_booked_appointments_shimmer_effect_view.dart';
import 'package:clinic_booking_app/views/user_booked_appointments/widgets/booked_appointments_list.dart';
import 'package:clinic_booking_app/views/user_booked_appointments/widgets/completed_appointment_list.dart';
import 'package:clinic_booking_app/views/user_booked_appointments/widgets/upcomming_and_completed_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBookedAppointmentsView extends StatefulWidget {
  const UserBookedAppointmentsView({super.key});

  @override
  State<UserBookedAppointmentsView> createState() =>
      _UserBookedAppointmentsViewState();
}

class _UserBookedAppointmentsViewState
    extends State<UserBookedAppointmentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Bookings".toUpperCase(),
        action: const SizedBox.shrink(),
      ),
      body: BlocConsumer<UserBookedAppointmentsCubit,
          UserBookedAppointmentsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var isCompleted =
              userBookedAppointmentsViewModel.isCompletedAppointments;

          if (state is! GetUserAppointmentsLoadingState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UpcommingAndCompletedButtons(),
                  const SizedBox(
                    height: 16,
                  ),
                  Builder(
                    builder: (context) {
                      if (!isCompleted) {
                        return const BookedAppointmentsList();
                      } else {
                        return const CompletedAppointmentList();
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return const UserBookedAppointmentsShimmerEffectView();
          }
        },
      ),
    );
  }
}
