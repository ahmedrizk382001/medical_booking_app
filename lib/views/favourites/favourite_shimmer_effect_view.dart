import 'package:clinic_booking_app/shared/shimmer_box.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class FavouriteShimmerEffectView extends StatefulWidget {
  const FavouriteShimmerEffectView({super.key});

  @override
  State<FavouriteShimmerEffectView> createState() =>
      _FavouriteShimmerEffectViewState();
}

class _FavouriteShimmerEffectViewState extends State<FavouriteShimmerEffectView>
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
          _shimmerAppointmentCard(context),
          const SizedBox(
            height: 32,
          ),
          _shimmerAppointmentCard(context),
        ],
      ),
    );
  }
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
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
              const ShimmerCircle(radius: 18),
            ],
          ),
        ],
      ),
    ),
  );
}
