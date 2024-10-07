import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class FavouriteCardListTile extends StatefulWidget {
  const FavouriteCardListTile({
    super.key,
    required this.doctorIndex,
  });

  final int doctorIndex;

  @override
  State<FavouriteCardListTile> createState() => _FavouriteCardListTileState();
}

class _FavouriteCardListTileState extends State<FavouriteCardListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleAnimationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _scaleAnimationConfig();
    super.initState();
  }

  @override
  void dispose() {
    _scaleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var doctorData = bottomNavViewModel.doctorsList[widget.doctorIndex];
    var isFavourite =
        bottomNavViewModel.isDoctorFavourite(doctorUID: doctorData.doctorUID);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Leading (Profile Image)
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(doctorData.doctorImage),
          ),

          const SizedBox(width: 16), // Space between image and text

          // Title and Subtitle (Doctor's name and field)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorData.doctorName,
                  overflow: TextOverflow.ellipsis,
                  style: AppFontsStyle.stylePoppinsSemiBold16,
                ),
                const SizedBox(height: 4), // Space between title and subtitle
                Text(
                  doctorData.jobTitle,
                  overflow: TextOverflow.ellipsis,
                  style: AppFontsStyle.stylePoppinsRegular13,
                ),
              ],
            ),
          ),

          // Trailing (Favourite Icon)
          ScaleTransition(
            scale: _scaleAnimation,
            child: CircleAvatar(
              radius: 20,
              child: IconButton(
                onPressed: () {
                  bottomNavViewModel.changeIsFavourite(
                      doctorUID: doctorData.doctorUID,
                      isFavourite: !isFavourite);
                },
                icon: Icon(
                  isFavourite ? EvaIcons.heart : EvaIcons.heartOutline,
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scaleAnimationConfig() {
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: mediumAnimationDuration),
    );
    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _scaleAnimationController,
        curve: Curves.easeIn,
      ),
    );
    _scaleAnimationController.forward();
  }
}
