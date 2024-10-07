import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:clinic_booking_app/cubit/bottom_nav/bottom_nav_states.dart';
import 'package:clinic_booking_app/shared/custom_app_bar.dart';
import 'package:clinic_booking_app/shared/custom_search_field.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/home/widgets/doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Search",
        action: const SizedBox.shrink(),
        leading: IconButton(
          onPressed: () {
            bottomNavViewModel.searchDoctorsByName("");
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
      body: BlocConsumer<BottomNavCubit, BottomNavStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 32, right: 32, top: 16, bottom: 32),
                  child: searchField(
                    controller: _searchController,
                    onChanged: (value) {
                      bottomNavViewModel.searchDoctorsByName(value);
                    },
                  ),
                ),
              ),
              SliverList.separated(
                itemCount: bottomNavViewModel.filteredDoctors.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: DoctorCard(
                      doctorIndex: index,
                      isSearch: true,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 32,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
