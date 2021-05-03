import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/modules/account/controllers/account_controller.dart';

import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../repositories/task_repository.dart';
import '../../../../common/ui.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as Yandex;

class MapsController extends GetxController {
  final currentPosition = new Position().obs;
  final currentAddress = "".obs;

  Yandex.Placemark _mapPlacemark;
  Yandex.YandexMapController _mapController;
  var tenders = Tenders().obs;
  final tenderRepository = TaskRepository();
  final loading = false.obs;

  void setMark(Yandex.Placemark controller) {
    _mapPlacemark = controller;
    update();
  }

  Yandex.Placemark get mark => _mapPlacemark;

  YandexMapController get mapController => _mapController;

  void setController(Yandex.YandexMapController controller) {
    _mapController = controller;
    if (mark != null)
    controller.addPlacemark(mark);
    update();
  }

  // final selectedOngoingTask = Task().obs;
  // final selectedCompletedTask = Task().obs;
  // final selectedArchivedTask = Task().obs;

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      print(position.latitude);
      currentPosition.value = position;
      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getFirstAddress() async {
    double lng;
    double lat;
    if (tenders.value.geo_location != null ||
        tenders.value.geo_location.isNotEmpty) {
      List locations =
          tenders.value.geo_location.replaceAll(" ", '').split(',');
      lng = double.parse(locations[0]);
      lat = double.parse(locations[1]);
      setMark(new Yandex.Placemark(
          point: Point(
            latitude: lng,
            longitude: lat,
          ),
          rawImageData: (await rootBundle.load("assets/icon/place.png"))
              .buffer
              .asUint8List()));
      print("finished");
      currentPosition.value =
          Position(
              latitude: lng,
              longitude: lat);
      currentAddress.value =
          await tenderRepository.getAddress(lng.toString(), lat.toString());

    }
  }

  getAddressFromLatLng() async {
    double lng = currentPosition.value.latitude;
    double lat = currentPosition.value.longitude;
    print(lng + lat);
    currentAddress.value =
        await tenderRepository.getAddress(lng.toString(), lat.toString());
    update();
  }

  @override
  void onInit() async {
    Tenders _temp = Get.arguments as Tenders;
    tenders.update((val) {
      val.fromJson(_temp.toJson());
      val.categories = _temp.categories;
      val.remote = _temp.remote;
      val.work_start_at = _temp.work_start_at;
      val.work_end_at = _temp.work_end_at;
      val.deadline = _temp.deadline;
      val.opened.value = _temp.opened.value;
    });

    print(tenders.value.toJson());
    print(tenders.value.id);
    if (tenders.value.id != null)
      getFirstAddress();
    else
      _getCurrentLocation();
    super.onInit();
  }

  Future<bool> submit() async {
    loading.value = true;
    var lat = currentPosition.value.latitude;
    var lng = currentPosition.value.longitude;
    tenders.update((val) {
      val.geo_location = "${lat.toString()}, ${lng.toString()}";
    });
    print("LOCATION : ${tenders.value.geo_location}");
    try {
      Map body;
      if (tenders.value.id == null) {
        body =
            await tenderRepository.createTender(tenders.value.toJsonOnCreate());
        final controller = Get.find<AccountController>();
        if (controller.accountSee.value.numberGivenTasks.value != "" || controller.accountSee.value.numberGivenTasks.value != null)
        controller.accountSee.value.numberGivenTasks.value = (int.parse(controller.accountSee.value.numberGivenTasks.value) + 1).toString();
      } else {
        print(tenders.value.toJsonModify());
        body = await tenderRepository.updateTender(
            json: tenders.value.toJsonModify(),
            id: tenders.value.id.toString());
      }
      await Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Success".tr, title: body['success']));
      Get.back();
      Get.back(result: tenders.value);
      return true;
    } catch (e) {
      print("ERROR");
      print(e);
      Map error = jsonDecode(e);
      error['errors'].forEach((key, value) =>
          Get.showSnackbar(Ui.ErrorSnackBar(message: value[0], title: key)));
      return false;
    }
  }
}
