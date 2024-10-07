import 'package:clinic_booking_app/models/booked_appointment_model.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class BookedAppointmentCardBody extends StatefulWidget {
  const BookedAppointmentCardBody({
    super.key,
    required this.bookedAppointmentModel,
  });

  final BookedAppointmentModel bookedAppointmentModel;

  @override
  State<BookedAppointmentCardBody> createState() =>
      _BookedAppointmentCardBodyState();
}

class _BookedAppointmentCardBodyState extends State<BookedAppointmentCardBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleAnimationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _scaleAnimationConfig();
    super.initState();
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _bookedAppointmentListTile(),
        Row(
          children: [
            Expanded(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: _bookedAppointmentDate(
                  icon: EvaIcons.calendarOutline,
                  text: userBookedAppointmentsViewModel.formatDate(
                      widget.bookedAppointmentModel.appointmentDate),
                ),
              ),
            ),
            Expanded(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: _bookedAppointmentDate(
                  icon: EvaIcons.clockOutline,
                  text:
                      userBookedAppointmentsViewModel.convertTimeTo12HourFormat(
                          widget.bookedAppointmentModel.appointmentTime),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }

  ListTile _bookedAppointmentListTile() {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      leading: CircleAvatar(
        radius: 25,
        backgroundImage:
            NetworkImage(widget.bookedAppointmentModel.doctorImage),
      ),
      title: Text(
        widget.bookedAppointmentModel.doctorName,
        overflow: TextOverflow.ellipsis,
        style: AppFontsStyle.stylePoppinsSemiBold16,
      ),
      subtitle: Text(
        widget.bookedAppointmentModel.jobTitle,
        overflow: TextOverflow.ellipsis,
        style: AppFontsStyle.stylePoppinsRegular13,
      ),
    );
  }

  Column _bookedAppointmentDate(
      {required IconData icon, required String text}) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.secondaryColor,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          text,
          style: AppFontsStyle.stylePoppinsSemiBold16.copyWith(
            color: AppColors.mainColor,
          ),
        ),
      ],
    );
  }

  void _scaleAnimationConfig() {
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mediumAnimationDuration),
    );
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.easeIn,
      ),
    );
    _scaleAnimationController.forward();
  }
}
