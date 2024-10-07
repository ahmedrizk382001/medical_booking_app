import 'package:clinic_booking_app/shared/navigation.dart';
import 'package:clinic_booking_app/views/book_appointment/book_appointment_view.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/doctor_profile/widgets/about_me.dart';
import 'package:clinic_booking_app/shared/custom_booking_button.dart';
import 'package:clinic_booking_app/views/doctor_profile/widgets/doctor_cv_item_list.dart';
import 'package:clinic_booking_app/views/doctor_profile/widgets/doctor_profile_info.dart';
import 'package:flutter/material.dart';

class DoctorProfileFullData extends StatelessWidget {
  const DoctorProfileFullData({
    super.key,
    required this.doctorIndex,
    required this.scaffoldKey,
    this.isSearch,
  });

  final int doctorIndex;
  final bool? isSearch;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          DoctorProfileInfo(
            doctorIndex: doctorIndex,
            isSearch: isSearch,
          ),
          const SizedBox(
            height: 43,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child:
                DoctorCvItemsList(doctorIndex: doctorIndex, isSearch: isSearch),
          ),
          const SizedBox(
            height: 34,
          ),
          AboutMe(
            aboutMe: (isSearch != null
                    ? bottomNavViewModel.filteredDoctors[doctorIndex]
                    : bottomNavViewModel.doctorsList[doctorIndex])
                .aboutMe,
            isBottomSheet: false,
            scaffoldKey: scaffoldKey,
          ),
          const SizedBox(
            height: 34,
          ),
          CustomBookingButton(
            isDisable: false,
            onPressed: () {
              pushOnly(
                context,
                BookAppointmentView(
                    doctorIndex: doctorIndex, isSearch: isSearch),
              );
            },
            buttonText: 'Book Appointment',
          ),
          const SizedBox(
            height: 34,
          ),
        ],
      ),
    );
  }
}
