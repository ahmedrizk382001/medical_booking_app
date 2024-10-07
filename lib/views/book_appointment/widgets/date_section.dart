import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_cubit.dart';
import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_states.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/booking_section.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/calendar_container.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSection extends StatefulWidget {
  const DateSection({super.key, required this.doctorIndex, this.isSearch});

  final int doctorIndex;
  final bool? isSearch;

  @override
  State<DateSection> createState() => _DateSectionState();
}

class _DateSectionState extends State<DateSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 47),
          child: Text(
            "Appointment",
            style: AppFontsStyle.stylePoppinsSemiBold16,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        CalendarContainer(child: _tableCalendar()),
      ],
    );
  }

  Widget _tableCalendar() {
    DateTime date = DateTime.now();
    DateTime firstDay = DateTime(date.year, date.month, date.day + 1);
    DateTime lastDay =
        DateTime(firstDay.year, firstDay.month + 3, firstDay.day);
    return BlocConsumer<BookAppointmentCubit, BookAppointmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var doctorUID = (widget.isSearch != null
                ? bottomNavViewModel.filteredDoctors[widget.doctorIndex]
                : bottomNavViewModel.doctorsList[widget.doctorIndex])
            .doctorUID;
        return TableCalendar(
          focusedDay: bookAppointmentViewModel.foucsDay,
          firstDay: firstDay,
          lastDay: lastDay,
          calendarFormat: calendarFormat,
          currentDay: bookAppointmentViewModel.currentDay,
          rowHeight: 48,
          calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
            color: Color(0xff73D0ED),
            shape: BoxShape.circle,
          )),
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          onFormatChanged: (format) {
            setState(() {
              calendarFormat = format;
            });
          },
          onDaySelected: (selectedDay, focusedDay) {
            bookAppointmentViewModel.changeBookingVariables(
                isDateSelected: true,
                currentDay: selectedDay,
                foucusDay: focusedDay);
            bookAppointmentViewModel.changeCurrentIndex(index: null);
            if (selectedDay.weekday == 5) {
              bookAppointmentViewModel.changeBookingVariables(
                  isTimeSelected: false, isWeekend: true);
            } else {
              bookAppointmentViewModel.changeBookingVariables(isWeekend: false);
              bookAppointmentViewModel.getDoctorAppointments(
                  doctorUID: doctorUID,
                  day: bookAppointmentViewModel
                      .formatDate(bookAppointmentViewModel.foucsDay));
            }
          },
        );
      },
    );
  }
}
