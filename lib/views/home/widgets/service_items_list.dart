import 'package:clinic_booking_app/models/service_item_model.dart';
import 'package:clinic_booking_app/utils/images.dart';
import 'package:clinic_booking_app/views/home/widgets/service_item.dart';
import 'package:flutter/material.dart';

class ServiceItemsList extends StatelessWidget {
  const ServiceItemsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        serviceItems.length * 2 - 1,
        (index) {
          if (index.isEven) {
            var serviceItem = index ~/ 2;
            return Expanded(
              child: ServiceItem(
                serviceModel: serviceItems[serviceItem],
              ),
            );
          } else {
            return const SizedBox(
              width: 16,
            );
          }
        },
      ),
    );
  }
}

List<ServiceItemModel> serviceItems = [
  ServiceItemModel(serviceIcon: Assets.imagesTooth, serviceName: "Odontology"),
  ServiceItemModel(serviceIcon: Assets.imagesBrain, serviceName: "Neurology"),
  ServiceItemModel(serviceIcon: Assets.imagesHeart, serviceName: "Cardiology"),
];
