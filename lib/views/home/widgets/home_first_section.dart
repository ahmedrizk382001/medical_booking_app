import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/home/widgets/home_header.dart';
import 'package:clinic_booking_app/views/home/widgets/search_and_filter.dart';
import 'package:flutter/material.dart';

class HomeFirstSection extends StatefulWidget {
  const HomeFirstSection({
    super.key,
  });

  @override
  State<HomeFirstSection> createState() => _HomeFirstSectionState();
}

class _HomeFirstSectionState extends State<HomeFirstSection>
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
    return Column(
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: AnimatedSlide(
            offset: _animatedSlideOffset,
            duration: Duration(milliseconds: mediumAnimationDuration),
            curve: Curves.easeOut,
            child: const Padding(
              padding: EdgeInsets.only(
                left: 36,
                right: 22,
              ),
              child: HomeHeader(),
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        FadeTransition(
          opacity: _fadeAnimation,
          child: AnimatedSlide(
            offset: _animatedSlideOffset,
            duration: Duration(milliseconds: mediumAnimationDuration),
            curve: Curves.easeOut,
            child: const Padding(
              padding: EdgeInsets.only(left: 34, right: 13),
              child: SearchAndFilter(),
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
