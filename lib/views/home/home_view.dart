import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/shared/custom_safe_area.dart';
import 'package:clinic_booking_app/views/home/home_shimmer_effect_view.dart';
import 'package:clinic_booking_app/views/home/widgets/doctors_list.dart';
import 'package:clinic_booking_app/views/home/widgets/home_first_section.dart';
import 'package:clinic_booking_app/views/home/widgets/services.dart';
import 'package:clinic_booking_app/views/home/widgets/today_appointments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomSafeArea(),
      body: BlocConsumer<BottomNavCubit, BottomNavStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is! GetAllDataLoadingState) {
            return const CustomScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              slivers: [
                SliverToBoxAdapter(child: HomeFirstSection()),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 26, right: 26),
                    child: Services(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                  ),
                ),
                SliverToBoxAdapter(
                  child: TodayAppointments(),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 32,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 22),
                    child: DoctorsList(),
                  ),
                ),
              ],
            );
          } else {
            return const HomeShimmerEffectView();
          }
        },
      ),
    );
  }
}
