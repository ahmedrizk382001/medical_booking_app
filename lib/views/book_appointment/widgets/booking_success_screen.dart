import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_cubit.dart';
import 'package:clinic_booking_app/cubit/book_appointment/book_appointment_states.dart';
import 'package:clinic_booking_app/shared/custom_booking_button.dart';
import 'package:clinic_booking_app/shared/navigation.dart';
import 'package:clinic_booking_app/shared/shimmer_box.dart';
import 'package:clinic_booking_app/utils/app_styles.dart';
import 'package:clinic_booking_app/utils/constants.dart';
import 'package:clinic_booking_app/views/bottom_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class BookingSuccessScreen extends StatefulWidget {
  const BookingSuccessScreen({super.key});

  @override
  State<BookingSuccessScreen> createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookAppointmentCubit, BookAppointmentStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Builder(
              builder: (context) {
                if (state is! BookAppointmentLoadingState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(
                        flex: 2,
                      ),
                      Lottie.asset(
                        "assets/animations/done.json",
                        controller: _animationController,
                      ),
                      const Spacer(),
                      const Text(
                        "Booking is Done",
                        style: AppFontsStyle.stylePoppinsSemiBold24,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          "Find all your booked services in the appointments screen",
                          textAlign: TextAlign.center,
                          style: AppFontsStyle.stylePoppinsSemiBold15
                              .copyWith(fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Spacer(
                        flex: 3,
                      ),
                      CustomBookingButton(
                          onPressed: () {
                            pushRemove(context, const BottomNavView());
                          },
                          buttonText: "Back to Home",
                          isDisable: false),
                      const SizedBox(
                        height: 34,
                      ),
                    ],
                  );
                } else {
                  return const BookSuccessShimmerEffect();
                }
              },
            ));
      },
    );
  }
}

class BookSuccessShimmerEffect extends StatefulWidget {
  const BookSuccessShimmerEffect({super.key});

  @override
  State<BookSuccessShimmerEffect> createState() =>
      _BookSuccessShimmerEffectState();
}

class _BookSuccessShimmerEffectState extends State<BookSuccessShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 0.4,
      upperBound: 1,
      duration: Duration(milliseconds: shortAnimationDuration),
      reverseDuration: Duration(milliseconds: shortAnimationDuration),
    );
    _animationController.repeat(
      reverse: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(
            flex: 3,
          ),
          ShimmerCircle(radius: 85),
          Spacer(
            flex: 2,
          ),
          ShimmerBox(widthFactor: 0.6),
          SizedBox(
            height: 8,
          ),
          ShimmerBox(widthFactor: 0.75),
          Spacer(
            flex: 5,
          ),
          ShimmerBox(
            widthFactor: 1,
            margin: EdgeInsets.symmetric(horizontal: 45, vertical: 0),
          ),
          SizedBox(
            height: 34,
          ),
        ],
      ),
    );
  }
}
