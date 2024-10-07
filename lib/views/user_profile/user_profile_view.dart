import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/shared/common_widgets.dart';
import 'package:clinic_booking_app/shared/custom_app_bar.dart';
import 'package:clinic_booking_app/shared/custom_booking_button.dart';
import 'package:clinic_booking_app/shared/navigation.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/animated_login_and_onboarding_view.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/user_profile/user_profile_shimmer_effect_view.dart';
import 'package:clinic_booking_app/views/user_profile/widgets/user_profile_image.dart';
import 'package:clinic_booking_app/views/user_profile/widgets/user_profile_input_fields.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  Offset _animatedSlideOffset = const Offset(0, 0.2);

  @override
  void initState() {
    super.initState();
    _initTextControllers();
    _animationConfig();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _disposeTextControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {
        if (state is EditUserProfileSuccessState) {
          showCustomSnackBar(context, message: "Profile edited successfully");
        } else if (state is EditUserProfileErrorState) {
          showCustomSnackBar(context, message: "Error, please try again later");
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            title: "Profile Info".toUpperCase(),
            action: IconButton(
                onPressed: () {
                  bottomNavViewModel.logout();
                  pushRemove(context, const AnimatedLoginAndOnBoardingView());
                },
                icon: const Icon(EvaIcons.logOut)),
          ),
          body: Builder(
            builder: (context) {
              if (state is! GetAllDataLoadingState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScaleTransition(
                      scale: _animation,
                      child: FadeTransition(
                        opacity: _animation,
                        child: const UserProfileImage(),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    FadeTransition(
                      opacity: _animation,
                      child: AnimatedSlide(
                        offset: _animatedSlideOffset,
                        duration:
                            Duration(milliseconds: mediumAnimationDuration),
                        child: UserProfileInputFields(
                          emailController: _emailController,
                          nameController: _nameController,
                          phoneController: _phoneController,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ScaleTransition(
                      scale: _animation,
                      child: FadeTransition(
                        opacity: _animation,
                        child: CustomBookingButton(
                          isDisable: false,
                          buttonText: bottomNavViewModel.isEditable
                              ? "confirm".toUpperCase()
                              : "Edit Info".toUpperCase(),
                          margin: const EdgeInsets.symmetric(horizontal: 32),
                          onPressed: () {
                            bottomNavViewModel.changeProfileData(
                                isEditable: !bottomNavViewModel.isEditable);
                            if (!bottomNavViewModel.isEditable) {
                              bottomNavViewModel.editUserProfileDate(
                                  name: _nameController.text,
                                  phone: _phoneController.text,
                                  email: _emailController.text);
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                );
              } else {
                return const UserProfileShimmerEffectView();
              }
            },
          ),
        );
      },
    );
  }

  void _animationConfig() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mediumAnimationDuration),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animatedSlideOffset = const Offset(0, 0);
      });
    });
  }

  void _initTextControllers() {
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
  }

  void _disposeTextControllers() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
  }
}
