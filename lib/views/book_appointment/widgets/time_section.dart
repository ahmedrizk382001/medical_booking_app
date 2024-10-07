import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_cubit.dart';
import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_states.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/booking_section.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/time_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeSection extends StatefulWidget {
  const TimeSection({super.key});

  @override
  State<TimeSection> createState() => _TimeSectionState();
}

class _TimeSectionState extends State<TimeSection> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookAppointmentCubit, BookAppointmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 34,
            ),
            const Padding(
              padding: EdgeInsets.only(
                left: 47,
              ),
              child: Text(
                "Available Time",
                style: AppFontsStyle.stylePoppinsSemiBold16,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Builder(
              builder: (context) {
                if (bookAppointmentViewModel.isWeekend) {
                  return _timeNotAvailable(context);
                } else {
                  return const TimeGridView();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Container _timeNotAvailable(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.07, vertical: 0),
      child: Text(
        "Weekend is not available, please select another date",
        textAlign: TextAlign.center,
        style: AppFontsStyle.stylePoppinsSemiBold15
            .copyWith(color: Colors.grey, fontWeight: FontWeight.w400),
      ),
    );
  }
}
