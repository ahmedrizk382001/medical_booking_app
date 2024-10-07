import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/user_booked_appointments/widgets/booked_appointment_card.dart';
import 'package:flutter/material.dart';

class TodayAppointments extends StatefulWidget {
  const TodayAppointments({super.key});

  @override
  State<TodayAppointments> createState() => _TodayAppointmentsState();
}

class _TodayAppointmentsState extends State<TodayAppointments>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeAnimationController;

  late Animation<double> _fadeAnimation;

  Offset _animatedSlideOffset = const Offset(0, 0.4);

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
    var todayAppointments = userBookedAppointmentsViewModel.todayAppointments;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 37),
          child: Text(
            "Today's Bookings",
            style: AppFontsStyle.stylePoppinsSemiBold24,
          ),
        ),
        const SizedBox(
          height: 26,
        ),
        if (todayAppointments.isNotEmpty)
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: todayAppointments.length,
            itemBuilder: (context, index) {
              int selectedIndex = index ~/ 2;
              return BookedAppointmentCard(
                bookedAppointmentModel: todayAppointments[selectedIndex],
                deleteOnPressed: (BuildContext context) {},
                doctorOnPressed: (BuildContext context) {},
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 32,
            ),
          ),
        if (todayAppointments.isEmpty)
          FadeTransition(
            opacity: _fadeAnimation,
            child: AnimatedSlide(
              offset: _animatedSlideOffset,
              duration: Duration(milliseconds: mediumAnimationDuration),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  "No booked appointments for today",
                  style: AppFontsStyle.stylePoppinsSemiBold15.copyWith(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                ),
              ),
            ),
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
