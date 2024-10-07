import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_cubit.dart';
import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_states.dart';
import 'package:clinic_booking_app/shared/custom_booking_button.dart';
import 'package:clinic_booking_app/shared/navigation.dart';
import 'package:clinic_booking_app/view_models/book_appointment_view_model.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/booking_success_screen.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/date_section.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/time_section.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

late BookAppointmentViewModel bookAppointmentViewModel;
CalendarFormat calendarFormat = CalendarFormat.month;

class BookingSection extends StatefulWidget {
  const BookingSection({super.key, required this.doctorIndex, this.isSearch});

  final int doctorIndex;
  final bool? isSearch;

  @override
  State<BookingSection> createState() => _BookingSectionState();
}

class _BookingSectionState extends State<BookingSection> {
  bool isDataFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _initViewModelAndFetchData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookAppointmentCubit, BookAppointmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var doctorData = widget.isSearch != null
            ? bottomNavViewModel.filteredDoctors[widget.doctorIndex]
            : bottomNavViewModel.doctorsList[widget.doctorIndex];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateSection(
              doctorIndex: widget.doctorIndex,
              isSearch: widget.isSearch,
            ),
            const TimeSection(),
            const SizedBox(
              height: 34,
            ),
            CustomBookingButton(
                isDisable: !(bookAppointmentViewModel.isTimeSelected &&
                    bookAppointmentViewModel.isTimeSelected),
                onPressed: () {
                  bookAppointmentViewModel.bookAppointment(
                      doctorModel: doctorData);
                  pushRemove(context, const BookingSuccessScreen());
                },
                buttonText: "Confirm"),
            const SizedBox(
              height: 34,
            ),
          ],
        );
      },
    );
  }

  void _initViewModelAndFetchData() {
    if (!isDataFetched) {
      var cubit = BookAppointmentCubit.get(context);
      bookAppointmentViewModel =
          BookAppointmentViewModel(bookAppointmentCubit: cubit);

      bookAppointmentViewModel.initialDateCheck();

      bookAppointmentViewModel.getDoctorAppointments(
          doctorUID:
              bottomNavViewModel.doctorsList[widget.doctorIndex].doctorUID,
          day: bookAppointmentViewModel
              .formatDate(bookAppointmentViewModel.foucsDay));
      isDataFetched = true;
    }
  }
}
