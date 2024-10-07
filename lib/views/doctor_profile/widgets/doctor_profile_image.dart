import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/doctor_profile/widgets/add_to_fav_button.dart';
import 'package:flutter/material.dart';

class DoctorProfileImage extends StatefulWidget {
  const DoctorProfileImage({
    super.key,
    required this.doctorIndex,
    this.isSearch,
  });

  final int doctorIndex;
  final bool? isSearch;

  @override
  State<DoctorProfileImage> createState() => _DoctorProfileImageState();
}

class _DoctorProfileImageState extends State<DoctorProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: (widget.isSearch != null
              ? bottomNavViewModel.filteredDoctors[widget.doctorIndex]
              : bottomNavViewModel.doctorsList[widget.doctorIndex])
          .doctorName,
      child: Container(
        width: double.infinity,
        height: 357,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        decoration: _imageContainerBoxDecoration(
          image: (widget.isSearch != null
                  ? bottomNavViewModel.filteredDoctors[widget.doctorIndex]
                  : bottomNavViewModel.doctorsList[widget.doctorIndex])
              .doctorImage,
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 24, right: 24),
          alignment: Alignment.topRight,
          child: AddToFavouriteButton(
            doctorIndex: widget.doctorIndex,
          ),
        ),
      ),
    );
  }

  BoxDecoration _imageContainerBoxDecoration({required String image}) {
    return BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(32)),
      image: DecorationImage(
        image: NetworkImage(image),
        fit: BoxFit.cover,
      ),
    );
  }
}
