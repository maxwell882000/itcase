// import 'dart:convert';
// import 'dart:io';

// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:device_info/device_info.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../../global_widgets/block_button_widget.dart';
// import '../../../../global_widgets/text_field_widget.dart';
// import 'package:itcase/app/modules/account/widgets/account_link_widget.dart';
// import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
// import '../../../../routes/app_pages.dart';
// import 'package:itcase/app/providers/api.dart';

// class Step1 extends StatefulWidget {
//   @override
//   _Step1State createState() => _Step1State();
// }

// class _Step1State extends State<Step1> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   final GlobalKey<FormState> signupCustomer = new GlobalKey<FormState>();

//   File image;

//   TextEditingController name = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController about = TextEditingController();
//   TextEditingController company = TextEditingController();
//   TextEditingController city = TextEditingController();
//   TextEditingController role = TextEditingController();
//   String gender = "Male", type = "Individual", birthday, img;

//   bool agree = false;

//   _imgFromCamera() async {
//     image = await ImagePicker.pickImage(
//         source: ImageSource.camera, imageQuality: 70);
//     final pic = image.readAsBytesSync();
//     img = "data:image/jpeg;base64," + base64Encode(pic);
//   }

//   _imgFromGallery() async {
//     image = await ImagePicker.pickImage(
//         source: ImageSource.gallery, imageQuality: 70);
//     final pic = image.readAsBytesSync();
//     img = "data:image/jpeg;base64," + base64Encode(pic);
//   }

//   void showPicker(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return SafeArea(
//             child: Container(
//               child: new Wrap(
//                 children: <Widget>[
//                   new ListTile(
//                       leading: new Icon(Icons.photo_library),
//                       title: new Text('Gallery'),
//                       onTap: () {
//                         _imgFromGallery();
//                         Get.back();
//                       }),
//                   new ListTile(
//                     leading: new Icon(Icons.camera),
//                     title: new Text('Camera'),
//                     onTap: () {
//                       _imgFromCamera();
//                       Get.back();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Register".tr,
//           style: Get.textTheme.headline6
//               .merge(TextStyle(color: context.theme.primaryColor)),
//         ),
//         centerTitle: true,
//         backgroundColor: Get.theme.accentColor,
//         automaticallyImplyLeading: false,
//         leading: new IconButton(
//           icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Get.back(),
//         ),
//         elevation: 0,
//       ),
//       body: Form(
//         key: signupCustomer,
//         child: ListView(
//           primary: true,
//           children: [
//             box(Row(
//               children: [
//                 Expanded(
//                   child: Text("Customer"),
//                 ),
//                 Switch(
//                   value: agree,
//                   onChanged: (val) => setState(() {
//                     agree = val;
//                   }),
//                 ),
//               ],
//             )),
//             box(
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Avatar".tr,
//                     style: Get.textTheme.bodyText1,
//                   ),
//                   AccountLinkWidget(
//                     icon: Icon(Icons.image, color: Get.theme.accentColor),
//                     text: Text("Upload".tr),
//                     onTap: (e) {
//                       showPicker(context);
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             TextFieldWidget(
//               labelText: "Fullname".tr,
//               hintText: "Enter your fullname".tr,
//               contr: name,
//               // validator: (val) => val.length == 0 ? "Fullname error".tr : null,
//               // initialValue: name,
//               iconData: Icons.people_alt,
//               isLast: false,
//             ),
//             TextFieldWidget(
//               labelText: "Phone Number".tr,
//               hintText: "+99899 1234567".tr,
//               iconData: Icons.phone_android_outlined,
//               keyboardType: TextInputType.phone,
//               contr: phone,
//               // initialValue: phone_number,
//             ),
//             TextFieldWidget(
//               labelText: "Email Address".tr,
//               hintText: "johndoe@gmail.com".tr,
//               iconData: Icons.alternate_email,
//               // initialValue: email,
//               contr: email,
//               /*validator: (val) =>
//                   RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                           .hasMatch(val)
//                       ? null
//                       : "Email error".tr,*/
//               isFirst: false,
//               isLast: false,
//             ),
//             box(Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("You are:"),
//                 RadioListTile(
//                   title: Text("Individual"),
//                   value: "Individual",
//                   groupValue: type,
//                   onChanged: (val) => setState(() {
//                     type = val;
//                   }),
//                 ),
//                 RadioListTile(
//                   title: Text("Entity"),
//                   value: "Entity",
//                   groupValue: type,
//                   onChanged: (val) => setState(() {
//                     type = val;
//                   }),
//                 ),
//               ],
//             )),
//             type == "Individual"
//                 ? Column(
//                     children: [
//                       box(Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text("Gender:"),
//                           RadioListTile(
//                             title: Text("Male"),
//                             value: "Male",
//                             groupValue: gender,
//                             onChanged: (val) => setState(() {
//                               gender = val;
//                             }),
//                           ),
//                           RadioListTile(
//                             title: Text("Female"),
//                             value: "Female",
//                             groupValue: gender,
//                             onChanged: (val) => setState(() {
//                               gender = val;
//                             }),
//                           ),
//                         ],
//                       )),
//                       box(
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Birthday".tr,
//                               style: Get.textTheme.bodyText1,
//                             ),
//                             DateTimePicker(
//                               type: DateTimePickerType.date,
//                               initialValue:
//                                   birthday ?? DateTime.now().toString(),
//                               onChanged: (val) => setState(() {
//                                 birthday = val;
//                               }),
//                               dateMask: 'd MMM, yyyy',
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2100),
//                               icon: Icon(Icons.event_available),
//                               style: Get.textTheme.bodyText1,
//                               //locale: Locale('pt', 'BR'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   )
//                 : Column(children: [
//                     TextFieldWidget(
//                       labelText: "Company".tr,
//                       hintText: "Enter your company name".tr,
//                       iconData: Icons.map,
//                       // initialValue: company_name,
//                       isLast: false,
//                       contr: company,
//                     ),
//                     TextFieldWidget(
//                       labelText: "City".tr,
//                       hintText: "Enter your address".tr,
//                       iconData: Icons.map,
//                       // initialValue: city,
//                       isLast: false,
//                       onChange: (val) => setState(() {
//                         city = val;
//                       }),
//                     ),
//                   ]),
//             TextFieldWidget(
//               labelText:
//                   type == "Individual" ? "About myself".tr : "About company".tr,
//               hintText:
//                   type == "Individual" ? "About myself".tr : "About company".tr,
//               iconData: Icons.info,
//               isLast: false,
//               keyboardType: TextInputType.multiline,
//               // initialValue: about_myself,
//               maxLine: 5,
//               height: 10,
//               contr: about,
//               // validator: (val) => val.length > 6 ? null : "Myself error".tr,
//             ),
//             box(Row(
//               children: [
//                 Expanded(
//                   child: Text("I agree to the processing of personal data"),
//                 ),
//                 Switch(
//                   value: agree,
//                   onChanged: (val) => setState(() {
//                     agree = val;
//                   }),
//                 ),
//               ],
//             ))
//           ],
//         ),
//       ),
//       bottomNavigationBar: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Wrap(
//             crossAxisAlignment: WrapCrossAlignment.center,
//             direction: Axis.vertical,
//             children: [
//               SizedBox(
//                 width: Get.width,
//                 child: BlockButtonWidget(
//                   onPressed: () async {
//                     // Get.offAllNamed(Routes.PHONE_VERIFICATION);
//                     // controller.deviceName = await deviceInfo();
//                     // controller.signup(signupForm);
//                     // role == "contractor"
//                     //     ? signup(signupCustomer)
//                     //     : signup(signupCustomer);
//                     print(name.text);
//                   },
//                   color: Get.theme.accentColor,
//                   text: Text(
//                     "Register".tr,
//                     style: Get.textTheme.headline6
//                         .merge(TextStyle(color: Get.theme.primaryColor)),
//                   ),
//                 ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Get.offAllNamed(Routes.LOGIN);
//                 },
//                 child: Text("You already have an account?".tr),
//               ).paddingOnly(bottom: 10),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget customer(context) {
//     return Form(
//       key: signupCustomer,
//       child: ListView(
//         primary: true,
//         children: [
//           box(
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Avatar".tr,
//                   style: Get.textTheme.bodyText1,
//                 ),
//                 AccountLinkWidget(
//                   icon: Icon(Icons.image, color: Get.theme.accentColor),
//                   text: Text("Upload".tr),
//                   onTap: (e) {
//                     showPicker(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//           TextFieldWidget(
//             labelText: "Fullname".tr,
//             hintText: "Enter your fullname".tr,
//             contr: name,

//             // initialValue: name,
//             // validator: (val) => val.length == 0 ? "Fullname error".tr : null,
//             iconData: Icons.people_alt,
//             isLast: false,
//           ),
//           TextFieldWidget(
//             labelText: "Phone Number".tr,
//             hintText: "+99899 1234567".tr,
//             iconData: Icons.phone_android_outlined,
//             keyboardType: TextInputType.phone,
//             contr: phone,
//             // initialValue: phone,
//             validator: (val) =>
//                 val.length == 0 ? "Enter the phone number" : null,
//           ),
//           TextFieldWidget(
//             labelText: "Email Address".tr,
//             hintText: "johndoe@gmail.com".tr,
//             iconData: Icons.alternate_email,
//             contr: email,
//             onChange: (val) => setState(() {
//               email = val;
//             }),
//             validator: (val) =>
//                 RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                         .hasMatch(val)
//                     ? null
//                     : "Email error".tr,
//             isFirst: false,
//             isLast: false,
//           ),
//           box(Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text("You are:"),
//               RadioListTile(
//                   title: Text("Individual"),
//                   value: "Individual",
//                   groupValue: type,
//                   onChanged: (val) => setState(() {
//                         type = val;
//                       })),
//               RadioListTile(
//                 title: Text("Entity"),
//                 value: "Entity",
//                 groupValue: type,
//                 onChanged: (val) => setState(() {
//                   type = val;
//                 }),
//               ),
//             ],
//           )),
//           type == "Individual"
//               ? SizedBox(
//                   height: 5,
//                 )
//               : Column(children: [
//                   TextFieldWidget(
//                     labelText: "Company".tr,
//                     hintText: "Enter your company name".tr,
//                     iconData: Icons.home_repair_service,
//                     contr: company,
//                     isLast: false,
//                     validator: (val) =>
//                         val.length == 0 ? "Enter the company name" : null,
//                   ),
//                   TextFieldWidget(
//                     labelText: "City".tr,
//                     hintText: "Enter your city".tr,
//                     iconData: Icons.map,
//                     contr: city,
//                     isLast: false,
//                     validator: (val) =>
//                         val.length == 0 ? "Enter the City" : null,
//                   ),
//                 ]),
//           TextFieldWidget(
//             labelText:
//                 type == "Individual" ? "About myself".tr : "About company".tr,
//             hintText:
//                 type == "Individual" ? "About myself".tr : "About company".tr,
//             iconData: Icons.info,
//             isLast: false,
//             keyboardType: TextInputType.multiline,
//             maxLine: 5,
//             height: 10,
//             contr: about,
//             validator: (val) => val.length == 0 ? "Enter the info" : null,
//           ),
//           box(Row(
//             children: [
//               Expanded(
//                 child: Text("I agree to the processing of personal data"),
//               ),
//               Switch(
//                 value: agree,
//                 onChanged: (val) => setState(() {
//                   agree = val;
//                 }),
//               ),
//             ],
//           ))
//         ],
//       ),
//     );
//   }

//   deviceInfo() async {
//     DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//     return androidInfo.device;
//   }

//   box(child) {
//     return Container(
//       padding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
//       margin: EdgeInsets.only(top: 20, left: 20, right: 20),
//       decoration: BoxDecoration(
//           color: Get.theme.primaryColor,
//           borderRadius: BorderRadius.all(Radius.circular(5)),
//           boxShadow: [
//             BoxShadow(
//                 color: Get.theme.focusColor.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: Offset(0, 5)),
//           ],
//           border: Border.all(color: Get.theme.focusColor.withOpacity(0.1))),
//       child: child,
//     );
//   }
// /*
//   signup(GlobalKey<FormState> signupForm) async {
//     final Map<String, dynamic> data = Map<String, dynamic>();

//     if (signupForm.currentState.validate()) {
//       signupForm.currentState.save();
//       data['user_role'] = user_role;
//       data[user_role + '_name'] = name;
//       data[user_role + '_phone_number'] = phone_number;
//       data[user_role + '_email'] = email;
//       if (gender != null) data[user_role + '_gender'] = gender;
//       data[user_role + '_about_myself'] = about_myself;
//       data[user_role + '_type'] = type;
//       if (birthday != null) data[user_role + '_birtday_date'] = birthday;
//       if (company_name != null) data[user_role + 'company_name'] = company_name;
//       data['image'] = image;
//       data['agree_personal_data_processing'] = agree_personal_data.toString();

//       var response;

//       if (user_role == "customer") {
//         print(data);
//         // response = await API().post(customer.value.toJson(), 'account/create');
//         // print(response.statusCode);
//       }

//       /*
//       if (response.statusCode == 200) {
//         print(response.body);
//         // var body
//       } else {
//         Get.showSnackbar(
//             Ui.ErrorSnackBar(message: jsonEncode(jsonDecode(response.body))));
//       }
//       */
//     }
//   }*/
// }
