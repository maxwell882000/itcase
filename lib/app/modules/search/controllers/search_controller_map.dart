import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/category/controllers/categories_controller.dart';
import 'package:itcase/app/providers/api.dart';
import 'package:itcase/app/repositories/category_repository.dart';
import 'package:itcase/app/routes/app_pages.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../models/e_service_model.dart';
import '../../../models/task_model.dart';
import 'package:http/http.dart' as http;
import '../../../repositories/task_repository.dart';
import '../../../../common/ui.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as Yandex;

class SearchMapController extends GetxController {
  final currentPosition = new Position().obs;
  final currentAddress = "".obs;


  Yandex.Placemark _mapPlacemark;
  Yandex.YandexMapController _mapController;
  final tenderRepository = TaskRepository();
  final placemarks = List<dynamic>().obs;
  final categories = [].obs;
  final tenders = List<Tenders>().obs;
  var imageBundle;

  void setMark(Yandex.Placemark controller) {
    _mapPlacemark = controller;
    update();
  }

  final radius = 5.obs;

  Yandex.Placemark get mark => _mapPlacemark;

  YandexMapController get mapController => _mapController;

  void setController(Yandex.YandexMapController controller) {
    _mapController = controller;
    update();
  }

  // final selectedOngoingTask = Task().obs;
  // final selectedCompletedTask = Task().obs;
  // final selectedArchivedTask = Task().obs;
  void addPlaceMark(Tenders tenders) async {
    List position = tenders.geo_location.replaceAll(" ", "").split(",");
    double latitude = double.parse(position[0]);
    double longitude = double.parse(position[1]);
    final point = Yandex.Point(latitude: latitude, longitude: longitude);
    String image = tenders.icon;

    placemarks.add(new Yandex.Placemark(
      point: point,
      onTap: (point) {
        Get.toNamed(Routes.TENDER_VIEW, arguments: tenders);
      },
        rawImageData: imageBundle,

    ));
    mapController.addPlacemark(placemarks.last);
  }

  void searchMap() async {
    Map data = {
      "center_lng":currentPosition.value.longitude,
      "center_lat":  currentPosition.value.latitude,
      "radius": radius.value,
      "categories": categories.value,
    };
    try {
      placemarks.forEach((element) {mapController.removePlacemark(element);});
      tenders.value = await tenderRepository.searchMap(jsonEncode(data));
      tenders.value.forEach((element) {
        addPlaceMark(element);
      });
    } catch (e) {
      print(e);
      Get.showSnackbar(Ui.ErrorSnackBar(message: e, title: ""));
    }
  }

  getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      print(position.latitude);
      currentPosition.value = position;
      await getAddressFromLatLng();
      final point = Yandex.Point(
          // not forget to change to current value
          latitude: 41.2995,
          longitude: 69.2401);

      mapController.move(point: point, zoom: 10.0);
      // mapController.addPlacemark(new Yandex.Placemark(
      //     point: point,
      //     rawImageData:imageBundle
      //     ));
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      double lat = currentPosition.value.latitude;
      double lng = currentPosition.value.longitude;
      currentAddress.value =
          await tenderRepository.getAddress(lat.toString(), lng.toString());
      print(currentAddress.value);
      update();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    categories.value = Get.arguments as List;
    ByteData image = await rootBundle.load("assets/icon/place.png");
    this.imageBundle = image.buffer.asUint8List();
    super.onInit();
  }
}
