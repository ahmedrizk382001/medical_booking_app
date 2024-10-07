import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/images.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(bottomNavViewModel.userModel.image),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(32),
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.transparent,
                    child: SvgPicture.asset(
                      Assets.imagesNotifications,
                      //width: 25,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text("Hello",
                    style: AppFontsStyle.stylePoppinsSemiBold24.copyWith(
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  width: 8,
                ),
                Text("${bottomNavViewModel.userModel.name.split(' ').first}!",
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: AppFontsStyle.stylePoppinsSemiBold24.copyWith(
                      fontWeight: FontWeight.w300,
                    ))
              ],
            ),
          ],
        );
      },
    );
  }
}
