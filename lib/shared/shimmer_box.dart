import 'package:flutter/material.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.flex = 1,
    required this.widthFactor,
    this.margin,
    this.borderRadius,
    this.alignment,
  });

  final int flex;
  final EdgeInsetsGeometry? margin;
  final double widthFactor;
  final BorderRadiusGeometry? borderRadius;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: FractionallySizedBox(
        widthFactor: widthFactor,
        child: Container(
          alignment: alignment,
          margin: margin,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.08),
            borderRadius: borderRadius ?? BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

class ShimmerCircle extends StatelessWidget {
  const ShimmerCircle({super.key, required this.radius});

  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.black.withOpacity(0.1),
    );
  }
}
