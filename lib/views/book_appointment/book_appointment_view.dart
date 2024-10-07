import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/booking_section.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/empty_container.dart';
import 'package:clinic_booking_app/views/book_appointment/widgets/doctor_info_card.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:flutter/material.dart';

class BookAppointmentView extends StatefulWidget {
  const BookAppointmentView(
      {super.key, required this.doctorIndex, this.isSearch});

  final int doctorIndex;
  final bool? isSearch;

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  Offset _animatedSlideOffset = const Offset(0, 0.2);
  double _scaleAnimation = 0;

  @override
  void initState() {
    super.initState();
    _animationConfig();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  _profileImageExpanded(),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: _popIconButton(context),
                  ),
                  Positioned(
                    top: 326,
                    right: 0,
                    left: 0,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: AnimatedSlide(
                        offset: _animatedSlideOffset,
                        duration:
                            Duration(milliseconds: mediumAnimationDuration),
                        child: const EmptyContainer(),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 260,
                    left: MediaQuery.sizeOf(context).width * 0.12,
                    right: MediaQuery.sizeOf(context).width * 0.12,
                    child: ScaleTransition(
                      scale: _fadeAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: DoctorInfoCard(
                            doctorIndex: widget.doctorIndex,
                            isSearch: widget.isSearch),
                      ),
                    ),
                  )
                ],
              ),
              ScaleTransition(
                scale: _fadeAnimation,
                child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: BookingSection(
                      doctorIndex: widget.doctorIndex,
                      isSearch: widget.isSearch,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popIconButton(BuildContext context) {
    return AnimatedScale(
      scale: _scaleAnimation,
      duration: Duration(milliseconds: mediumAnimationDuration),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Widget _profileImageExpanded() {
    return Image.network(
      (widget.isSearch != null
              ? bottomNavViewModel.filteredDoctors[widget.doctorIndex]
              : bottomNavViewModel.doctorsList[widget.doctorIndex])
          .doctorImage,
      width: double.infinity,
      height: 390,
      fit: BoxFit.cover,
    );
  }

  void _animationConfig() async {
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

    await Future.delayed(
      Duration(milliseconds: shortAnimationDuration),
    );

    _fadeAnimationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animatedSlideOffset = const Offset(0, 0);
        _scaleAnimation = 1;
      });
    });
  }
}
