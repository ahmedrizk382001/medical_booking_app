import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/doctor_profile/widgets/about_me_bottom_sheet.dart';
import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({
    super.key,
    required this.aboutMe,
    required this.isBottomSheet,
    required this.scaffoldKey,
  });

  final String aboutMe;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isBottomSheet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32),
      child: InkWell(
        onTap: () {
          scaffoldKey.currentState!.showBottomSheet(
            (context) {
              return AboutMeBottomSheet(
                aboutMe: aboutMe,
                scaffoldKey: scaffoldKey,
              );
            },
            backgroundColor: Colors
                .transparent, // Make the background transparent for custom shadows
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About Me",
              style: AppFontsStyle.stylePoppinsSemiBold16.copyWith(
                fontFamily: "Inter",
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              aboutMe,
              overflow: TextOverflow.ellipsis,
              maxLines: isBottomSheet ? 8 : 3,
              style: AppFontsStyle.stylePoppinsRegular12.copyWith(
                fontFamily: "Inter",
                fontWeight: FontWeight.w500,
                fontSize: isBottomSheet ? 14 : 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
