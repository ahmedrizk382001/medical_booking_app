import 'package:clinic_booking_app/models/booked_appointment_model.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/user_booked_appointments/widgets/completed_appointment_card_body.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CompletedAppointmentCard extends StatefulWidget {
  const CompletedAppointmentCard({
    super.key,
    required this.completedAppointmentModel,
    required this.doctorOnPressed,
  });

  final BookedAppointmentModel completedAppointmentModel;
  final void Function(BuildContext context)? doctorOnPressed;

  @override
  State<CompletedAppointmentCard> createState() =>
      _CompletedAppointmentCardState();
}

class _CompletedAppointmentCardState extends State<CompletedAppointmentCard>
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
            decoration: _completedAppointmentCardDecoration(),
            child: CompletedAppointmentCardBody(
              completedAppointmentModel: widget.completedAppointmentModel,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _completedAppointmentCardDecoration() {
    return BoxDecoration(
      color: Colors.grey.shade400,
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
