import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/modules/auth/views/register/fill_account.dart';
import 'package:itcase/app/modules/auth/widgets/fill_data.dart';
import 'package:itcase/common/ui.dart';
import '../../../global_widgets/text_field_widget.dart';

import '../controllers/change_password_controller.dart';

class ProfileView extends FillAccount{
  final bool hideAppBar;
  final GlobalKey<FormState> _passwordForm = new GlobalKey<FormState>();


  ProfileView({this.hideAppBar = false}) {
    // controller.profileForm = new GlobalKey<FormState>();
  }
  @override
  Widget build(BuildContext context) {
    final List social = [
      [ 'Telegram',(save) => controller.tempUser.value.telegram = save,controller.tempUser.value.telegram],
      [ 'Instagram',(save) => controller.tempUser.value.instagram = save ,controller.tempUser.value.instagram],
      [ 'Facebook',(save) => controller.tempUser.value.facebook = save, controller.tempUser.value.facebook],
      [ 'Vk', (save) => controller.tempUser.value.vk = save ,controller.tempUser.value.vk],
      [ 'WhatsApp',(save) => controller.tempUser.value.whatsapp = save, controller.tempUser.value.whatsapp],
      [ 'Twitter', (save) => controller.tempUser.value.twitter = save, controller.tempUser.value.twitter],
    ];
    return Obx(
      ()=> Stack(
        children: [
          Visibility(
            visible: controller.loading.value,
            child: Scaffold(
              body: CircularLoadingWidget(
                height: Get.height,
                onCompleteText: "".tr,
              ),
            ),
          ),
          Visibility(
            visible: !controller.loading.value,
            child: Scaffold(
                appBar: hideAppBar
                    ? null
                    : AppBar(
                  title: Text(
                    "Profile".tr,
                    style: context.textTheme.headline6,
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,

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
                          onPressed: () {
                            controller.modify_account(_passwordForm);
                            // controller.saveProfileForm(_profileForm);
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
                        onPressed: () {
                          Get.back();
                        },
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Get.theme.hintColor.withOpacity(0.1),
                        child: Text("Back".tr, style: Get.textTheme.bodyText2),
                      ),
                    ],
                  ).paddingSymmetric(vertical: 10, horizontal: 20),
                ),
                body: Form(
                  key: _passwordForm,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FillData(),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      child: CachedNetworkImage(
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                        imageUrl: "https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/512x512/plain/user.png",
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
                                  SizedBox(
                                    width: 20,
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      upload_image();
                                      // controller.saveProfileForm(_profileForm);
                                    },
                                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    color: Get.theme.accentColor,
                                    child: Text("Upload resume".tr,
                                        style: Get.textTheme.bodyText2
                                            .merge(TextStyle(color: Get.theme.primaryColor))),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text("Social Media".tr, style: Get.textTheme.headline3)
                            .paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
                        SizedBox(
                          width: Get.width,
                          height: Get.height/2,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                               itemCount: social.length,
                              itemBuilder: (context, index) => textField(social[index][0], social[index][1], social[index][2])
                          ),
                        ),


                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
  Widget textField(String text, Function save, String initial){
    return  TextFieldWidget(
      labelText: text,
      hintText: "Please fill empty field".tr,
      iconData: Icons.phone_android_outlined,
      onSaved: (val) => save(val),
      initialValue: initial,
      isLast: false,
      isFirst: false,
    );
  }
  upload_image()async{
    FilePickerResult result = await FilePicker.platform.pickFiles();

    if(result != null) {
      PlatformFile file = result.files.first;
      if (file.extension != 'pdf'){
        print(file.path);
        return  Get.showSnackbar(
            Ui.ErrorSnackBar(message: "Please upload only pdf file".tr));
      }
      else {
        controller.tempUser.value.resume = file.path;
      }
      print(file.name);
      print(file.bytes);
      print(file.size);


    }
  }
}