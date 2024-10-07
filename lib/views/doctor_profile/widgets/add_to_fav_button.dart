import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToFavouriteButton extends StatefulWidget {
  const AddToFavouriteButton({
    super.key,
    required this.doctorIndex,
  });

  final int doctorIndex;

  @override
  State<AddToFavouriteButton> createState() => _AddToFavouriteButtonState();
}

class _AddToFavouriteButtonState extends State<AddToFavouriteButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleAnimationController;
  late Animation<double> _scaleAnimation;
  late AnimationController _bounceAnimationController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _scaleAnimationConfig();
    _bounceAnimationConfig(); // Initialize the bounce animation controller
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    _bounceAnimationController.dispose(); // Dispose of the bounce controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var doctorUID =
            bottomNavViewModel.doctorsList[widget.doctorIndex].doctorUID;
        var isFavourite =
            bottomNavViewModel.isDoctorFavourite(doctorUID: doctorUID);

        if (state is! GetAllDataLoadingState &&
            state is! GetAllDataErrorState) {
          return ScaleTransition(
            scale: _scaleAnimation, // Initial scale animation
            child: FadeTransition(
              opacity: _scaleAnimation,
              child: ScaleTransition(
                scale:
                    _bounceAnimation, // Bounce animation when condition is true
                child: _buildFavouriteButton(
                  isFavourite: isFavourite,
                  doctorUID: doctorUID,
                  enabled: true, // Enable the button
                ),
              ),
            ),
          );
        } else {
          _playBounceAnimation(); // Ensure the bounce animation plays continuously
          return _circleIndicator();
        }
      },
    );
  }

  Widget _buildFavouriteButton({
    required bool isFavourite,
    required String doctorUID,
    required bool enabled,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 24,
        child: IconButton(
          onPressed: enabled
              ? () {
                  bottomNavViewModel.changeIsFavourite(
                    doctorUID: doctorUID,
                    isFavourite: !isFavourite,
                  );
                  _playBounceAnimation(); // Play bounce animation when clicked
                }
              : null, // Disable button if not enabled
          icon: Icon(
            isFavourite ? EvaIcons.heart : EvaIcons.heartOutline,
            color: AppColors.mainColor,
            size: 32,
          ),
        ),
      ),
    );
  }

  CircleAvatar _circleIndicator() {
    return const CircleAvatar(
      backgroundColor: Colors.white,
      radius: 24,
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: AppColors.mainColor,
        ),
      ),
    );
  }

  void _scaleAnimationConfig() {
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mediumAnimationDuration),
    );

    // Initial fade and scale animation (from 0 to 1 on load)
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.easeIn,
      ),
    );

    // Start the initial animation when widget loads
    _scaleAnimationController.forward();
  }

  void _bounceAnimationConfig() {
    _bounceAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // 0.5 seconds
    );

    // Bounce effect sequence: scale up, then down, then back to normal
    _bounceAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.3, end: 0.8), weight: 30),
      TweenSequenceItem(tween: Tween<double>(begin: 0.8, end: 1.0), weight: 20),
    ]).animate(
      CurvedAnimation(
        parent: _bounceAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _playBounceAnimation() {
    // Reset and play the bounce animation
    _bounceAnimationController
      ..reset()
      ..forward();
  }
}
