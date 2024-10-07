import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/user_profile/widgets/custom_user_profile_textfield.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileInputFields extends StatelessWidget {
  const UserProfileInputFields(
      {super.key,
      required this.nameController,
      required this.phoneController,
      required this.emailController});

  final TextEditingController nameController, phoneController, emailController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 0),
      child: BlocConsumer<BottomNavCubit, BottomNavStates>(
        listener: (context, state) {},
        builder: (context, state) {
          nameController.text = bottomNavViewModel.userModel.name;
          phoneController.text = bottomNavViewModel.userModel.phone;
          emailController.text = bottomNavViewModel.userModel.email;
          return Column(
            children: [
              CustomUserProfileTextfield(
                controller: nameController,
                hintText: "Name",
                icon: EvaIcons.personOutline,
                isEnabled: bottomNavViewModel.isEditable,
              ),
              const SizedBox(
                height: 32,
              ),
              CustomUserProfileTextfield(
                controller: phoneController,
                hintText: "Phone",
                icon: EvaIcons.phoneOutline,
                isEnabled: bottomNavViewModel.isEditable,
              ),
              const SizedBox(
                height: 32,
              ),
              CustomUserProfileTextfield(
                controller: emailController,
                hintText: "Email",
                icon: EvaIcons.emailOutline,
                isEnabled: bottomNavViewModel.isEditable,
              ),
            ],
          );
        },
      ),
    );
  }
}
