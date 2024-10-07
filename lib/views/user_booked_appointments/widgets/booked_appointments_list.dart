import 'package:clinic_booking_app/cubit/user_booked_appointments.dart/user_booked_appointments_cubit.dart';
import 'package:clinic_booking_app/cubit/user_booked_appointments.dart/user_booked_appointments_states.dart';
import 'package:clinic_booking_app/shared/common_widgets.dart';
import 'package:clinic_booking_app/shared/navigation.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/doctor_profile/doctor_profile_view.dart';
import 'package:clinic_booking_app/views/user_booked_appointments/widgets/booked_appointment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookedAppointmentsList extends StatefulWidget {
  const BookedAppointmentsList({super.key});

  @override
  State<BookedAppointmentsList> createState() => _BookedAppointmentsListState();
}

class _BookedAppointmentsListState extends State<BookedAppointmentsList>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  Offset _animatedSlideOffset = const Offset(0, 0.3);

  @override
  void initState() {
    super.initState();

    _fadeAndOffsetAnimationConfig();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBookedAppointmentsCubit,
        UserBookedAppointmentsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var appointmentsList = userBookedAppointmentsViewModel.appointmentsList;
        if (appointmentsList.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              children: List.generate(
                appointmentsList.length * 2 - 1,
                (index) {
                  if (index.isEven) {
                    int selectedIndex = index ~/ 2;
                    int appointmentTimeIndex = appointmentsTime.indexOf(
                        userBookedAppointmentsViewModel
                            .convertTimeTo12HourFormat(
                                appointmentsList[selectedIndex]
                                    .appointmentTime));
                    return BookedAppointmentCard(
                      bookedAppointmentModel: appointmentsList[selectedIndex],
                      deleteOnPressed: (BuildContext context) {
                        userBookedAppointmentsViewModel.deleteAppointment(
                            index: appointmentTimeIndex,
                            bookedAppointmentModel:
                                appointmentsList[selectedIndex]);
                        showCustomSnackBar(context,
                            message: "Appointment deleted successfully");
                      },
                      doctorOnPressed: (BuildContext context) {
                        var doctorIndex =
                            bottomNavViewModel.findCorrespondingIndex(
                                appointmentsList,
                                bottomNavViewModel.doctorsList,
                                selectedIndex,
                                (appointment, doctor) =>
                                    appointment.doctorUID == doctor.doctorUID);
                        pushOnly(context,
                            DoctorProfileView(doctorIndex: doctorIndex));
                      },
                    );
                  } else {
                    return const SizedBox(
                      height: 32,
                    );
                  }
                },
              ),
            ),
          );
        } else {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height / 1.35,
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: AnimatedSlide(
                  offset: _animatedSlideOffset,
                  duration: Duration(milliseconds: mediumAnimationDuration),
                  child: Text(
                    'No upcomming appointments to show',
                    textAlign: TextAlign.center,
                    style: AppFontsStyle.stylePoppinsSemiBold16.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void _fadeAndOffsetAnimationConfig() {
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mediumAnimationDuration),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _fadeAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _fadeAnimationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animatedSlideOffset = const Offset(0, 0);
      });
    });
  }
}
