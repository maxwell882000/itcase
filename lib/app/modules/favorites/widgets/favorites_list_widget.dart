// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../global_widgets/circular_loading_widget.dart';
// import 'favorites_list_item_widget.dart';

// import '../../../models/e_service_model.dart';

// class FavoritesListWidget extends StatelessWidget {
//   final List<EService> services;

//   FavoritesListWidget({Key key, List<EService> this.services}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (this.services.isEmpty) {
//         return CircularLoadingWidget(height: 300);
//       } else {
//         return ListView.builder(
//           padding: EdgeInsets.only(bottom: 10, top: 10),
//           primary: false,
//           shrinkWrap: true,
//           itemCount: services.length,
//           itemBuilder: ((_, index) {
//             var _service = services.elementAt(index);
//             return FavoritesListItemWidget(service: _service);
//           }),
//         );
//       }
//     });
//   }
// }
