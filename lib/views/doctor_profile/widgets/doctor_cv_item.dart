import 'package:clinic_booking_app/models/cv_item_model.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DoctorCVItem extends StatefulWidget {
  const DoctorCVItem({
    super.key,
    required this.cvItemModel,
  });

  final CvItemModel cvItemModel;

  @override
  State<DoctorCVItem> createState() => _DoctorCVItemState();
}

class _DoctorCVItemState extends State<DoctorCVItem>
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ScaleTransition(
          scale: _scaleAnimation,
          child: FadeTransition(
            opacity: _scaleAnimation,
            child: CircleAvatar(
              backgroundColor: AppColors.mainColor.withOpacity(0.1),
              radius: 30,
              child: Icon(
                widget.cvItemModel.icon,
                color: AppColors.mainColor,
                size: 45,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "${widget.cvItemModel.value}+",
          style: AppFontsStyle.stylePoppinsSemiBold16,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(widget.cvItemModel.title,
            style: AppFontsStyle.stylePoppinsRegular12)
      ],
    );
  }

  void _scaleAnimationConfig() {
    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
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
