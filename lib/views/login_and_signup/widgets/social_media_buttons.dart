import 'package:clinic_booking_app/utils/images.dart';
import 'package:flutter/material.dart';

class SocialMediaButtons extends StatelessWidget {
  const SocialMediaButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Image.asset(
              Assets.imageFacebook,
              width: 32,
            )),
        IconButton(
            onPressed: () {},
            icon: Image.asset(
              Assets.imageTwitter,
              width: 32,
            )),
        IconButton(
            onPressed: () {},
            icon: Image.asset(
              Assets.imageLinkedIn,
              width: 32,
            )),
      ],
    );
  }
}
