import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:itcase/app/modules/account/widgets/account_link_widget.dart';
import 'package:itcase/app/services/auth_service.dart';

import '../../../../common/ui.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  var _currentUser;
  @override
  void initState() {
    super.initState();
    _currentUser = Get.find<AuthService>().user;
  }

  File file;
  String img, base64, imgName;
  fromGallery() async {
    file = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 70);
    if (file != null) {
      setState(() {
        final img = file.readAsBytesSync();
        base64 = base64Encode(img);
        imgName = file.path.split('/').last;
        print(img);
      });
    }
  }

  fromCamera() async {
    file = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 70);
    if (file != null) {
      setState(() {
        final img = file.readAsBytesSync();
        base64 = base64Encode(img);
        imgName = file.path.split('/').last;
      });
    }
  }

  upload() {
    var data = {
      'user_id': _currentUser.value.id.toString(),
      'img': imgName,
      'file': base64,
    };
    // print(data);
    print(_currentUser.value.mediaThumb);
    Get.back();
/*
    var res = await API().post(data, 'reports/create');
    var body = json.decode(res.body);
    if (body['success']) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showMsg(body['message']);
    }
    */
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Upload".tr,
            style: Get.textTheme.headline6
                .merge(TextStyle(color: context.theme.primaryColor)),
          ),
          centerTitle: true,
          backgroundColor: Get.theme.accentColor,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          elevation: 0,
        ),
        body: ListView(
          primary: true,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  height: 150,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Get.theme.accentColor,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Get.theme.focusColor.withOpacity(0.2),
                          blurRadius: 10,
                          offset: Offset(0, 5)),
                    ],
                  ),
                  margin: EdgeInsets.only(bottom: 50),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          _currentUser.value.name,
                          style: Get.textTheme.headline6
                              .merge(TextStyle(color: Get.theme.primaryColor)),
                        ),
                        SizedBox(height: 5),
                        Text(_currentUser.value.email,
                            style: Get.textTheme.caption.merge(
                                TextStyle(color: Get.theme.primaryColor))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: Ui.getBoxDecoration(),
              child: Column(
                children: [
                  Container(
                    decoration: Ui.getBoxDecoration(
                      radius: 14,
                      border:
                          Border.all(width: 5, color: Get.theme.primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: file != null
                          ? Image.file(
                              file,
                              fit: BoxFit.contain,
                              height: MediaQuery.of(context).size.height * 0.3,
                            )
                          : CachedNetworkImage(
                              height: Get.height * 0.3,
                              fit: BoxFit.cover,
                              imageUrl: _currentUser.value.mediaThumb,
                              placeholder: (context, url) => Image.asset(
                                'assets/img/loading.gif',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 100,
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error_outline),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: Ui.getBoxDecoration(),
              child: Column(
                children: [
                  AccountLinkWidget(
                    icon: Icon(Icons.album, color: Get.theme.accentColor),
                    text: Text("Gallery".tr),
                    onTap: (e) {
                      fromGallery();
                    },
                  ),
                  AccountLinkWidget(
                    icon: Icon(Icons.camera, color: Get.theme.accentColor),
                    text: Text("Camera".tr),
                    onTap: (e) {
                      fromCamera();
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      upload();
                    },
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Get.theme.accentColor,
                    child: Text("Save".tr,
                        style: Get.textTheme.bodyText2
                            .merge(TextStyle(color: Get.theme.primaryColor))),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
