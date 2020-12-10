import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class AddressWidget extends StatelessWidget {
  final controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Row(
        children: [
          Icon(Icons.place_outlined),
          SizedBox(width: 10),
          Expanded(
            child: Obx(() {
              return Text(controller.currentAddress?.address ?? "Loading...".tr, style: Get.textTheme.bodyText1);
            }),
          ),
          SizedBox(width: 10),
          IconButton(icon: Icon(Icons.gps_fixed), onPressed: () {})
        ],
      ),
    );
  }
}
