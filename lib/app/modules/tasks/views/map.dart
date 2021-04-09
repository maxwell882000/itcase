import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/tasks/views/finish.dart';
import 'package:itcase/app/modules/tasks/views/page.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' as Yandex;
import 'package:geolocator/geolocator.dart';

class SearchMap extends StatefulWidget {
  @override
  _SearchMapState createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;
  Yandex.YandexMapController _mapController;
  Yandex.Placemark _mapPlacemark;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      var lat = _currentPosition.latitude;
      var lng = _currentPosition.longitude;
      var res = await http.get('https://geocode-maps.yandex.ru/1.x/?apikey=d968824f-7680-4384-b158-736f430ee7c5&geocode=${lng},${lat}&lang=ru_RU&format=json');
      _currentAddress = jsonDecode(res.body)['response']['GeoObjectCollection']['featureMember'][0]['GeoObject']['metaDataProperty']['GeocoderMetaData']['text'];
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a task".tr,
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
        child: Row(
          children: [
            Expanded(
              child: FlatButton(
                onPressed: () async {
                  Get.to(TaskFinish());
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
            SizedBox(width: 10),
            FlatButton(
              onPressed: () {},
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Get.theme.hintColor.withOpacity(0.1),
              child: Text("Reset".tr, style: Get.textTheme.bodyText2),
            ),
          ],
        ).paddingSymmetric(vertical: 10, horizontal: 20),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Location',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              if (_currentPosition != null &&
                                  _currentAddress != null)
                                Text(_currentAddress,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 400.0,
                      ),
                      child: Yandex.YandexMap(
                        onMapCreated: (controller) {
                          controller.move(point: Yandex.Point(latitude: 40.51237537472959, longitude: 65.78737356974068),
                            zoom: 5.0);
                          _mapController = controller;
                        },
                        onMapTap: (point) {
                          if (_mapPlacemark != null) {
                            _mapController.removePlacemark(_mapPlacemark);
                          }
                          _mapPlacemark = new Yandex.Placemark(point: point);
                          _mapController.addPlacemark(_mapPlacemark);
                          setState(() {
                            _currentPosition = Position(latitude: point.latitude, longitude: point.longitude);
                            _getAddressFromLatLng();
                          });
                        },
                      )
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
