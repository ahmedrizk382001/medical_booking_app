import 'package:clinic_booking_app/shared/navigation.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:clinic_booking_app/views/doctor_profile/doctor_profile_view.dart';
import 'package:clinic_booking_app/views/favourites/widgets/favourite_card.dart';
import 'package:flutter/material.dart';

class FavouriteCardList extends StatefulWidget {
  const FavouriteCardList({super.key});

  @override
  State<FavouriteCardList> createState() => _FavouriteCardListState();
}

class _FavouriteCardListState extends State<FavouriteCardList>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;

  Offset _animatedSlideOffset = const Offset(0, 0.3);

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
    // Filter the list to get only favourite doctors
    List<int> favouriteDoctorsIndices = [];

    for (int i = 0; i < bottomNavViewModel.doctorsList.length; i++) {
      var doctorUID = bottomNavViewModel.doctorsList[i].doctorUID;
      if (bottomNavViewModel.isDoctorFavourite(doctorUID: doctorUID)) {
        favouriteDoctorsIndices.add(i);
      }
    }

    // If no favourite doctors found, display the centered text
    if (favouriteDoctorsIndices.isEmpty) {
      return SizedBox(
        height: MediaQuery.sizeOf(context).height / 1.35,
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: AnimatedSlide(
              offset: _animatedSlideOffset,
              duration: Duration(milliseconds: mediumAnimationDuration),
              child: Text(
                'No favourite doctors found',
                textAlign: TextAlign.center,
                style: AppFontsStyle.stylePoppinsSemiBold16.copyWith(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Otherwise, generate the favourite doctor list
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: List.generate(
          favouriteDoctorsIndices.length * 2 - 1,
          (index) => _generatedFavouritesList(index, favouriteDoctorsIndices),
        ),
      ),
    );
  }

  Widget _generatedFavouritesList(
      int index, List<int> favouriteDoctorsIndices) {
    int doctorIndex = favouriteDoctorsIndices[index ~/ 2];
    var doctorUID = bottomNavViewModel.doctorsList[doctorIndex].doctorUID;
    var isFavourite =
        bottomNavViewModel.isDoctorFavourite(doctorUID: doctorUID);

    if (index.isEven) {
      return isFavourite
          ? FavouriteCard(
              onPressed: (context) {
                pushOnly(
                  context,
                  DoctorProfileView(doctorIndex: doctorIndex),
                );
              },
              doctorIndex: doctorIndex,
            )
          : const SizedBox.shrink();
    } else {
      return isFavourite ? const SizedBox(height: 32) : const SizedBox.shrink();
    }
  }

  void _fadeAndOffsetAnimationConfig() {
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mediumAnimationDuration),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _fadeAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _fadeAnimationController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animatedSlideOffset = const Offset(0, 0);
      });
    });
  }
}
