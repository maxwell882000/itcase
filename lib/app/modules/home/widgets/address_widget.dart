import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/tasks/controllers/tender_view_controller.dart';

import '../controllers/home_controller.dart';

class AddressWidget extends StatelessWidget {
  final String locationString;
  AddressWidget({this.locationString});
  Widget location({String location}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Row(
        children: [
          Icon(Icons.place_outlined),
          SizedBox(width: 10),
          Expanded(
            child: Text(location, style: Get.textTheme.bodyText1),
          ),
          SizedBox(width: 10),
          IconButton(icon: Icon(Icons.gps_fixed), onPressed: () {})
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return location(location :locationString?? "Loading...".tr);
  }
}
