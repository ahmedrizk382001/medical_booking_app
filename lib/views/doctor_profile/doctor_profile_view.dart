import 'package:clinic_booking_app/shared/custom_app_bar.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/doctor_profile/widgets/doctor_profile_full_data.dart';
import 'package:clinic_booking_app/views/doctor_profile/widgets/doctor_profile_image.dart';
import 'package:flutter/material.dart';

class DoctorProfileView extends StatefulWidget {
  const DoctorProfileView(
      {super.key, required this.doctorIndex, this.isSearch});

  final int doctorIndex;
  final bool? isSearch;

  @override
  State<DoctorProfileView> createState() => _DoctorProfileViewState();
}

class _DoctorProfileViewState extends State<DoctorProfileView>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: "Doctor",
        action: const SizedBox.shrink(),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.secondaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height - kToolbarHeight,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: DoctorProfileImage(
                  doctorIndex: widget.doctorIndex,
                  isSearch: widget.isSearch,
                ),
              ),
              Positioned(
                top: 281,
                right: 0,
                left: 0,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: AnimatedSlide(
                    offset: _animatedSlideOffset,
                    duration: Duration(milliseconds: mediumAnimationDuration),
                    child: DoctorProfileFullData(
                      doctorIndex: widget.doctorIndex,
                      isSearch: widget.isSearch,
                      scaffoldKey: _scaffoldKey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fadeAndOffsetAnimationConfig() async {
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // Adjust duration as needed
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
    // Start the fade animation
    _fadeAnimationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animatedSlideOffset = const Offset(0, 0);
      });
    });
  }
}
