import 'package:clinic_booking_app/shared/shimmer_box.dart';
import 'package:flutter/material.dart';

class TimeGridViewShimmerEffect extends StatelessWidget {
  const TimeGridViewShimmerEffect({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _rowItem(context),
        const SizedBox(
          height: 20,
        ),
        _rowItem(context),
      ],
    );
  }

  Container _rowItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.07),
      height: 65,
      width: double.infinity,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Spacer(),
          ShimmerBox(
            flex: 10,
            widthFactor: 1,
          ),
          Spacer(),
          ShimmerBox(
            flex: 10,
            widthFactor: 1,
          ),
          Spacer(),
          ShimmerBox(
            flex: 10,
            widthFactor: 1,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
