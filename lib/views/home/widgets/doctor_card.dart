import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/shared/navigation.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/doctor_profile/doctor_profile_view.dart';
import 'package:clinic_booking_app/views/home/widgets/doctor_card_info.dart';
import 'package:clinic_booking_app/views/home/widgets/doctor_card_rate_and_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({
    super.key,
    required this.doctorIndex,
    this.isSearch,
  });

  final int doctorIndex;
  final bool? isSearch;

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard>
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
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: AnimatedSlide(
            offset: _animatedSlideOffset,
            duration: Duration(milliseconds: mediumAnimationDuration),
            child: Container(
              padding: const EdgeInsets.only(
                  left: 23, right: 12, top: 12, bottom: 12),
              decoration: _doctorCardDecoration(),
              child: SizedBox(
                height: 88,
                width: 88,
                child: Row(
                  children: [
                    _doctorCardImage(widget.isSearch),
                    const SizedBox(
                      width: 16,
                    ),
                    DoctorCardInfo(
                      doctorIndex: widget.doctorIndex,
                      isSearch: widget.isSearch,
                    ),
                    const Spacer(),
                    DoctorCardRateAndButton(
                      doctorIndex: widget.doctorIndex,
                      isSearch: widget.isSearch,
                      onPressed: () {
                        pushOnly(
                          context,
                          DoctorProfileView(
                            doctorIndex: widget.doctorIndex,
                            isSearch: widget.isSearch,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _doctorCardImage(bool? isSearch) {
    return Hero(
      tag: (isSearch != null
              ? bottomNavViewModel.filteredDoctors[widget.doctorIndex]
              : bottomNavViewModel.doctorsList[widget.doctorIndex])
          .doctorName,
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          image: DecorationImage(
            image: NetworkImage(
              (isSearch != null
                      ? bottomNavViewModel.filteredDoctors[widget.doctorIndex]
                      : bottomNavViewModel.doctorsList[widget.doctorIndex])
                  .doctorImage,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  BoxDecoration _doctorCardDecoration() {
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
