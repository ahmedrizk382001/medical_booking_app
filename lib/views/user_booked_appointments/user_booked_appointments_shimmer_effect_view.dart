import 'package:clinic_booking_app/shared/shimmer_box.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class UserBookedAppointmentsShimmerEffectView extends StatefulWidget {
  const UserBookedAppointmentsShimmerEffectView({super.key});

  @override
  State<UserBookedAppointmentsShimmerEffectView> createState() =>
      _UserBookedAppointmentsShimmerEffectViewState();
}

class _UserBookedAppointmentsShimmerEffectViewState
    extends State<UserBookedAppointmentsShimmerEffectView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.4,
      upperBound: 1,
      duration: Duration(milliseconds: shortAnimationDuration),
      reverseDuration: Duration(milliseconds: shortAnimationDuration),
    );
    _animationController.repeat(
      reverse: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerBox(
            flex: 1,
            widthFactor: 0.5,
            margin: EdgeInsets.only(left: 22),
          ),
          const SizedBox(
            height: 16,
          ),
          _shimmerAppointmentCard(context),
          const SizedBox(
            height: 32,
          ),
          _shimmerAppointmentCard(context),
          const SizedBox(
            height: 32,
          ),
          _shimmerAppointmentCard(context),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  Widget _shimmerAppointmentCard(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 22),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Leading (ShimmerCircle)
                  const ShimmerCircle(radius: 24),
                  const SizedBox(
                      width:
                          16), // Spacing between the leading and the title/subtitle

                  // Column for title and subtitle
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Title Container
                        Container(
                          height: 15,
                          width: MediaQuery.sizeOf(context).width *
                              0.4, // Adjust the width as needed
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        const SizedBox(
                            height: 8), // Space between title and subtitle
                        // Subtitle Container
                        Container(
                          height: 10,
                          width: MediaQuery.sizeOf(context).width *
                              0.35, // Adjust the width as needed
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Expanded(
              flex: 2,
              child: Row(
                children: [
                  ShimmerBox(widthFactor: 0.35),
                  ShimmerBox(widthFactor: 0.35),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Expanded(
              flex: 1,
              child: Row(
                children: [
                  ShimmerBox(widthFactor: 0.45),
                  ShimmerBox(widthFactor: 0.45),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
