import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/cubit/user_booked_appointments.dart/user_booked_appointments_cubit.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/view_models/bottom_nav_view_model.dart';
import 'package:clinic_booking_app/view_models/user_booked_appointments_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

late BottomNavViewModel bottomNavViewModel;
late UserBookedAppointmentsViewModel userBookedAppointmentsViewModel;

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  bool _isDataFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure that getUserData() is only called once
    if (!_isDataFetched) {
      bottomNavViewModel =
          BottomNavViewModel(bottomNavCubit: BottomNavCubit.get(context))
            ..getAllData();

      var cubit = UserBookedAppointmentsCubit.get(context);
      userBookedAppointmentsViewModel =
          UserBookedAppointmentsViewModel(userBookedAppointmentsCubit: cubit)
            ..getBookedAppointments();
      _isDataFetched = true;

      _isDataFetched = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomNavCubit, BottomNavStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          bottomNavigationBar: _bottomNavBar(context),
          body: bottomNavViewModel.screens[bottomNavViewModel.selectedIndex],
        );
      },
    );
  }

  BottomNavigationBar _bottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      items: bottomNavViewModel.getBottomNavItems(),
      currentIndex: bottomNavViewModel.selectedIndex,
      selectedItemColor: AppColors.mainColor,
      selectedLabelStyle: const TextStyle(
          overflow: TextOverflow.ellipsis,
          fontFamily: "Inter",
          fontWeight: FontWeight.w600),
      onTap: (index) {
        bottomNavViewModel.changeBottomNavIndex(
            index: index, bottomNavCubit: BottomNavCubit.get(context));
      },
    );
  }
}
