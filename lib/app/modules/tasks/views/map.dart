
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/modules/tasks/controllers/map_conroller.dart';

import 'package:yandex_mapkit/yandex_mapkit.dart' as Yandex;
import 'package:geolocator/geolocator.dart';

class Map extends GetView<MapsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select location".tr,
          style: TextStyle(color: Get.theme.primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.accentColor,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5)),
          ],
        ),
        child: Obx(
          () => Visibility(
            visible: !controller.loading.value,
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () async {
                      controller.loading.value = (await controller.submit());
                    },
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Get.theme.accentColor,
                    child: Text("Save".tr,
                        style: Get.textTheme.bodyText2
                            .merge(TextStyle(color: Get.theme.primaryColor))),
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: 10, horizontal: 20),
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Visibility(
              visible: controller.loading.value,
              child: CircularLoadingWidget(
                height: Get.height,
                onCompleteText: "".tr,
              ),
            ),
            Visibility(
              visible: !controller.loading.value,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                        ),
                        height: Get.height,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(Icons.location_on),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'Location'.tr,
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                      if (controller.currentPosition.value !=
                                              null &&
                                          controller.currentAddress.value !=
                                              null)
                                        Obx(
                                          () => Text(
                                              controller.currentAddress.value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Expanded(
                              child: Yandex.YandexMap(
                                onMapCreated: (controller) {
                                  controller.move(
                                      point: Yandex.Point(
                                          latitude: 41.2995,
                                          longitude: 69.2401),
                                      zoom: 10.0);

                                  this.controller.setController(controller);
                                },
                                onMapTap: (point) async {
                                  if (controller.mark != null) {
                                    controller.mapController
                                        .removePlacemark(controller.mark);
                                  }
                                  controller.setMark(
                                    new Yandex.Placemark(
                                        point: point,
                                            rawImageData: (await rootBundle.load(
                                                    "assets/icon/place.png"))
                                                .buffer
                                                .asUint8List()));

                                  controller.mapController
                                      .addPlacemark(controller.mark);

                                  this.controller.currentPosition.value =
                                      Position(
                                          latitude: point.latitude,
                                          longitude: point.longitude);

                                  controller.getAddressFromLatLng();
                                },
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
