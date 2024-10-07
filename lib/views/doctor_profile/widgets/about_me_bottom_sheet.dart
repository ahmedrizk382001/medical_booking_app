import 'package:clinic_booking_app/views/doctor_profile/widgets/about_me.dart';
import 'package:flutter/material.dart';

class AboutMeBottomSheet extends StatelessWidget {
  const AboutMeBottomSheet(
      {super.key, required this.aboutMe, required this.scaffoldKey});

  final String aboutMe;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // Use Wrap to fit the content's height
      children: [
        Container(
          padding: const EdgeInsets.only(top: 32, bottom: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Adjust shadow color
                spreadRadius: 5,
                blurRadius: 15,
                offset: const Offset(0, 0), // Position of shadow
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: AboutMe(
            aboutMe: aboutMe,
            isBottomSheet: true,
            scaffoldKey: scaffoldKey,
          ),
        ),
      ],
    );
  }
}
