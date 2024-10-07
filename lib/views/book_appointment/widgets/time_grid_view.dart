import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_cubit.dart';
import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_states.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/booking_section.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/time_grid_view_shimmer_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeGridView extends StatefulWidget {
  const TimeGridView({super.key});

  @override
  State<TimeGridView> createState() => _TimeGridViewState();
}

class _TimeGridViewState extends State<TimeGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookAppointmentCubit, BookAppointmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Builder(
          builder: (context) {
            if (state is! GetDoctorAppointmentsLoadingState) {
              return _gridViewBuilder(context);
            } else {
              return const TimeGridViewShimmerEffect();
            }
          },
        );
      },
    );
  }

  Widget _gridViewBuilder(BuildContext context) {
    var doctorAppointments = bookAppointmentViewModel.doctorFetchedAppointments;
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.07),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        mainAxisSpacing: 8,
      ),
      itemCount: appointmentsTime.length,
      itemBuilder: (context, itemBuilderIndex) {
        bool appointmentsCondition =
            doctorAppointments[(itemBuilderIndex).toString()] == null ||
                doctorAppointments[(itemBuilderIndex).toString()] == "free";
        return InkWell(
          splashColor: Colors.transparent,
          onTap: appointmentsCondition
              ? () {
                  bookAppointmentViewModel.changeCurrentIndex(
                      index: itemBuilderIndex);

                  bookAppointmentViewModel.changeBookingVariables(
                      selectedTimeIndex: itemBuilderIndex,
                      isTimeSelected: true);
                }
              : null,
          child: _timeItem(itemBuilderIndex, appointmentsCondition),
        );
      },
    );
  }

  Widget _timeItem(int itemBuilderIndex, bool appointmentsCondition) {
    var selectedIndex = bookAppointmentViewModel.currentIndex;
    return Container(
      margin: const EdgeInsets.all(5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(
            color: selectedIndex == itemBuilderIndex
                ? const Color(0xffEDAE73)
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(16),
          color: selectedIndex == itemBuilderIndex
              ? const Color(0xffEDAE73)
              : null,
          boxShadow: selectedIndex == itemBuilderIndex
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(0, 5),
                    blurRadius: 4,
                  ),
                ]
              : []),
      child: Text(
        appointmentsTime[itemBuilderIndex],
        style: AppFontsStyle.stylePoppinsSemiBold15.copyWith(
          color: appointmentsCondition
              ? selectedIndex == itemBuilderIndex
                  ? Colors.white
                  : AppColors.secondaryColor
              : Colors.grey,
        ),
      ),
    );
  }
}
