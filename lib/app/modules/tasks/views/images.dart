import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';

// void main() => runApp(new Img());

class Img extends StatefulWidget {
  @override
  _ImgState createState() => new _ImgState();
}

class _ImgState extends State<Img> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected'.tr;
  List<List<int>> base = [];
  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];

        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<dynamic> xet(img1) async {
    return await img1.getByteData();
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected'.tr;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          // actionBarColor: Get..,
          actionBarTitle: "Choose photos".tr,
          allViewTitle: "All Photos".tr,
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a task".tr,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: Get.theme.primaryColor),
            onPressed: () async {
              base.clear();
              for (var i = 0; i < images.length; i++) {
                Asset as = images[i];
                ByteData byteData = await as.requestOriginal();
                List<int> v = byteData.buffer.asUint8List();
                base.add(v);
              }
              Get.back(result: base);
            },
          )
        ],
        centerTitle: true,
        backgroundColor: Get.theme.accentColor,
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Pick images".tr,
            style: TextStyle(
              color: Colors.white,
            ),
            ),
            onPressed: loadAssets,
          ),
          Expanded(
            child: buildGridView(),
          ),
        ],
      ),
    );
  }
}
