import 'package:clinic_booking_app/models/service_item_model.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem({
    super.key,
    required this.serviceModel,
  });

  final ServiceItemModel serviceModel;

  @override
  State<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem>
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _scaleAnimation,
        child: ElevatedButton(
          onPressed: () {},
          style: _serviceItemButtonStyle(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(widget.serviceModel.serviceIcon),
              const SizedBox(
                height: 8,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.serviceModel.serviceName,
                  style: AppFontsStyle.stylePoppinsSemiBold15.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ButtonStyle _serviceItemButtonStyle() {
    return const ButtonStyle(
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)))),
        backgroundColor: WidgetStatePropertyAll(AppColors.mainColor),
        padding: WidgetStatePropertyAll(
            EdgeInsets.only(left: 9, right: 9, top: 9, bottom: 5)));
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
