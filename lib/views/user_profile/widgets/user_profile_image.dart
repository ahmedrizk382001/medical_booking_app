import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/shared/common_widgets.dart';
import 'package:clinic_booking_app/shared/shimmer_box.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileImage extends StatelessWidget {
  const UserProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {
        if (state is EditImageErrorState ||
            state is UploadImageErrorState ||
            state is ImagePickErrorState) {
          showCustomSnackBar(context, message: "Error, please try again later");
        }
      },
      builder: (context, state) {
        if (state is! EditImageLoadingState &&
            state is! UploadImageLoadingState) {
          return Container(
            margin: const EdgeInsets.only(top: 16),
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage:
                      NetworkImage(bottomNavViewModel.userModel.image),
                ),
                CircleAvatar(
                  backgroundColor: AppColors.mainColor.withOpacity(0.5),
                  child: IconButton(
                      onPressed: () {
                        bottomNavViewModel.getImageFromMobile();
                      },
                      icon: const Icon(
                        EvaIcons.edit,
                        color: Colors.white,
                        size: 24,
                      )),
                ),
              ],
            ),
          );
        } else {
          return const ProfileImageShimmerEffect();
        }
      },
    );
  }
}

class ProfileImageShimmerEffect extends StatefulWidget {
  const ProfileImageShimmerEffect({
    super.key,
  });

  @override
  State<ProfileImageShimmerEffect> createState() =>
      _ProfileImageShimmerEffectState();
}

class _ProfileImageShimmerEffectState extends State<ProfileImageShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mediumAnimationDuration),
      reverseDuration: Duration(milliseconds: mediumAnimationDuration),
      lowerBound: 0.4,
      upperBound: 1,
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
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        alignment: Alignment.center,
        child: const ShimmerCircle(radius: 75),
      ),
    );
  }
}
