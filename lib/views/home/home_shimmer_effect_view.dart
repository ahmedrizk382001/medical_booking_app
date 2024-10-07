import 'package:clinic_booking_app/shared/shimmer_box.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeShimmerEffectView extends StatefulWidget {
  const HomeShimmerEffectView({super.key});

  @override
  State<HomeShimmerEffectView> createState() => _HomeShimmerEffectViewState();
}

class _HomeShimmerEffectViewState extends State<HomeShimmerEffectView>
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 36, right: 22),
            child: Row(
              children: [
                ShimmerCircle(radius: 24),
                Spacer(),
                ShimmerCircle(radius: 18),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ShimmerBox(
            widthFactor: 0.5,
            margin: EdgeInsets.only(left: 36),
          ),
          SizedBox(
            height: 13,
          ),
          ShimmerBox(
            widthFactor: 1,
            margin: EdgeInsets.only(left: 34, right: 13),
          ),
          SizedBox(
            height: 40,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShimmerBox(
                  flex: 2,
                  widthFactor: 1,
                  margin: EdgeInsets.only(left: 36),
                ),
                Spacer(
                  flex: 2,
                ),
                ShimmerBox(
                  flex: 1,
                  widthFactor: 1,
                  margin: EdgeInsets.only(right: 25),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 26,
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Spacer(),
                ShimmerBox(
                  flex: 5,
                  widthFactor: 1,
                ),
                Spacer(),
                ShimmerBox(
                  flex: 5,
                  widthFactor: 1,
                ),
                Spacer(),
                ShimmerBox(
                  flex: 5,
                  widthFactor: 1,
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(
            height: 32,
          ),
          ShimmerBox(
            widthFactor: 0.7,
            margin: EdgeInsets.only(left: 36),
          ),
          SizedBox(
            height: 26,
          ),
          ShimmerBox(
            widthFactor: 1,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 64),
          ),
          SizedBox(
            height: 32,
          ),
          ShimmerBox(
            widthFactor: 0.5,
            margin: EdgeInsets.only(left: 36),
          ),
          SizedBox(
            height: 26,
          ),
          ShimmerBox(
            flex: 3,
            widthFactor: 1,
            margin: EdgeInsets.symmetric(horizontal: 22),
          ),
          SizedBox(
            height: 29,
          ),
          ShimmerBox(
            flex: 1,
            widthFactor: 1,
            margin: EdgeInsets.symmetric(horizontal: 22),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
        ],
      ),
    );
  }
}
