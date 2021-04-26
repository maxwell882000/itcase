import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:itcase/app/models/category_model.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/category/controllers/categories_controller.dart';
import 'package:itcase/app/repositories/category_repository.dart';
import 'package:itcase/app/routes/app_pages.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import '../../../models/e_service_model.dart';
import '../../../models/task_model.dart';
import 'package:http/http.dart' as http;
import '../../../repositories/task_repository.dart';
import '../../../../common/ui.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as Yandex;
class MapsController extends GetxController {

  final currentPosition = new Position().obs;
  final currentAddress = "".obs;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Yandex.Placemark _mapPlacemark;
  Yandex.YandexMapController _mapController;
  var tenders = Tenders().obs;
  final tenderRepository = TaskRepository();
  final loading = false.obs;
  void setMark(Yandex.Placemark controller){
    _mapPlacemark = controller;
    update();
  }

  Yandex.Placemark get mark => _mapPlacemark;
  YandexMapController get mapController =>_mapController;

  void setController(Yandex.YandexMapController controller){
    _mapController = controller;
    update();
  }

  // final selectedOngoingTask = Task().obs;
  // final selectedCompletedTask = Task().obs;
  // final selectedArchivedTask = Task().obs;

  _getCurrentLocation() {
    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      print(position.latitude);
       currentPosition.value = position;
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
  getAddressFromLatLng() async {
    double lng = currentPosition.value.latitude;
    double lat = currentPosition.value.longitude;
    try {
      if (tenders.value.geo_location != null || tenders.value.geo_location.isNotEmpty){
        List locations = tenders.value.geo_location.replaceAll(" ", '').split(',');
        lng = locations[0];
        lat = locations[1];
        setMark(new Yandex.Placemark(
            point: Point(
              latitude: lng,
              longitude: lat,
            ),
            rawImageData: (await rootBundle
                .load("assets/icon/place.png"))
                .buffer
                .asUint8List()));
        currentPosition.value =  Position(
          latitude: lng,
          longitude: lat,
        );
      }
      else {
         lng = currentPosition.value.latitude;
         lat = currentPosition.value.longitude;
      }

      currentAddress.value = await tenderRepository.getAddress(lng.toString(),lat.toString());
      update();
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    tenders.value = Get.arguments as Tenders;
    _getCurrentLocation();
    super.onInit();
  }

  Future<bool> submit() async {
    loading.value = true;
    var lat = currentPosition.value.latitude;
    var lng = currentPosition.value.longitude;
    tenders.value.geo_location = "${lat}, ${lng}";
    try{
      Map body;
      if(tenders.value.id == null) {
        body =
        await tenderRepository.createTender(tenders.value.toJsonOnCreate());
      }
      else {
        body = await tenderRepository.createTender({});
      }
       await Get.showSnackbar(Ui.SuccessSnackBar(message:"Success".tr, title: body['success']));
      Get.back();
      return true;
    }
    catch (e){
      print("ERROR");
      print(e);
      Map error = jsonDecode(e);
      error['errors'].forEach((key, value) =>
          Get.showSnackbar(Ui.ErrorSnackBar(message: value[0], title: key)));
      return false;
    }
  }

}
