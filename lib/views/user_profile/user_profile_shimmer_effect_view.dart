import 'package:clinic_booking_app/shared/shimmer_box.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class UserProfileShimmerEffectView extends StatefulWidget {
  const UserProfileShimmerEffectView({super.key});

  @override
  State<UserProfileShimmerEffectView> createState() =>
      _UserProfileShimmerEffectViewState();
}

class _UserProfileShimmerEffectViewState
    extends State<UserProfileShimmerEffectView>
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
          Container(
            margin: const EdgeInsets.only(top: 16),
            alignment: Alignment.center,
            child: const ShimmerCircle(radius: 75),
          ),
          const SizedBox(
            height: 32,
          ),
          const ShimmerBox(
            widthFactor: 1,
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 0),
          ),
          const SizedBox(
            height: 32,
          ),
          const ShimmerBox(
            widthFactor: 1,
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 0),
          ),
          const SizedBox(
            height: 32,
          ),
          const ShimmerBox(
            widthFactor: 1,
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 0),
          ),
          const Spacer(
            flex: 3,
          ),
          const ShimmerBox(
            widthFactor: 1,
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 0),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
