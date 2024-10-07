import 'package:clinic_booking_app/shared/navigation.dart';
import 'package:clinic_booking_app/shared/custom_search_field.dart';
import 'package:clinic_booking_app/utils/images.dart';
import 'package:clinic_booking_app/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              pushOnly(context, const SearchView());
            },
            child: searchField(
              enabled: false,
            ),
          ),
        ),
        const SizedBox(
          width: 36,
        ),
        SvgPicture.asset(
          Assets.imagesFilter,
          width: 30,
        ),
      ],
    );
  }
}
