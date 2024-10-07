import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/shared/custom_app_bar.dart';
import 'package:clinic_booking_app/views/favourites/favourite_shimmer_effect_view.dart';
import 'package:clinic_booking_app/views/favourites/widgets/favourite_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouritesView extends StatelessWidget {
  const FavouritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Favourites".toUpperCase(),
        action: const SizedBox.shrink(),
      ),
      body: BlocConsumer<BottomNavCubit, BottomNavStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is! GetAllDataLoadingState) {
            return const FavouriteCardList();
          } else {
            return const FavouriteShimmerEffectView();
          }
        },
      ),
    );
  }
}
