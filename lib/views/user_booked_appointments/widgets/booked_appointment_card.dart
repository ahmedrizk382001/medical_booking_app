import 'package:clinic_booking_app/models/booked_appointment_model.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/user_booked_appointments/widgets/booked_appointment_card_body.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BookedAppointmentCard extends StatefulWidget {
  const BookedAppointmentCard({
    super.key,
    required this.bookedAppointmentModel,
    required this.deleteOnPressed,
    required this.doctorOnPressed,
  });

  final BookedAppointmentModel bookedAppointmentModel;
  final void Function(BuildContext context)? deleteOnPressed, doctorOnPressed;

  @override
  State<BookedAppointmentCard> createState() => _BookedAppointmentCardState();
}

class _BookedAppointmentCardState extends State<BookedAppointmentCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  Offset _animatedSlideOffset = const Offset(0, 0.2);

  @override
  void initState() {
    super.initState();

    _fadeAndOffsetAnimationConfig();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AnimatedSlide(
        offset: _animatedSlideOffset,
        duration: Duration(milliseconds: mediumAnimationDuration),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: widget.deleteOnPressed,
                label: "Cancel",
                icon: EvaIcons.close,
                backgroundColor: AppColors.secondaryColor,
              ),
              SlidableAction(
                onPressed: widget.doctorOnPressed,
                label: "Doctor",
                icon: EvaIcons.arrowForward,
                backgroundColor: AppColors.mainColor,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
            width: double.infinity,
            decoration: _bookedAppointmentCardDecoration(),
            child: BookedAppointmentCardBody(
              bookedAppointmentModel: widget.bookedAppointmentModel,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _bookedAppointmentCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.17),
          blurRadius: 20,
          offset: const Offset(5, 10),
          spreadRadius: 1,
        ),
      ],
    );
  }

  void _fadeAndOffsetAnimationConfig() {
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mediumAnimationDuration),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _fadeAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _fadeAnimationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animatedSlideOffset = const Offset(0, 0);
      });
    });
  }
}
