import 'package:clinic_booking_app/models/cv_item_model.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/doctor_profile/widgets/doctor_cv_item.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class DoctorCvItemsList extends StatelessWidget {
  const DoctorCvItemsList({
    super.key,
    required this.doctorIndex,
    this.isSearch,
  });

  final int doctorIndex;
  final bool? isSearch;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DoctorCVItem(
          cvItemModel: CvItemModel(
            icon: EvaIcons.person,
            title: "Patients",
            value: (isSearch != null
                    ? bottomNavViewModel.filteredDoctors[doctorIndex]
                    : bottomNavViewModel.doctorsList[doctorIndex])
                .patientNumber,
          ),
        ),
        DoctorCVItem(
          cvItemModel: CvItemModel(
            icon: Icons.task_alt_rounded,
            title: "Years",
            value: (isSearch != null
                    ? bottomNavViewModel.filteredDoctors[doctorIndex]
                    : bottomNavViewModel.doctorsList[doctorIndex])
                .experienceYears,
          ),
        ),
        DoctorCVItem(
          cvItemModel: CvItemModel(
            icon: EvaIcons.star,
            title: "Ratings",
            value: (isSearch != null
                    ? bottomNavViewModel.filteredDoctors[doctorIndex]
                    : bottomNavViewModel.doctorsList[doctorIndex])
                .rate,
          ),
        ),
        DoctorCVItem(
          cvItemModel: CvItemModel(
            icon: EvaIcons.messageSquare,
            title: "Reviews",
            value: (isSearch != null
                    ? bottomNavViewModel.filteredDoctors[doctorIndex]
                    : bottomNavViewModel.doctorsList[doctorIndex])
                .reviews,
          ),
        ),
      ],
    );
  }
}
