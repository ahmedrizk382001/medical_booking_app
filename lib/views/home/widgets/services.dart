import 'package:clinic_booking_app/views/home/widgets/service_header.dart';

import 'package:clinic_booking_app/views/home/widgets/service_items_list.dart';
import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  const Services({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ServiceHeader(),
        ),
        SizedBox(
          height: 26,
        ),
        ServiceItemsList(),
      ],
    );
  }
}
