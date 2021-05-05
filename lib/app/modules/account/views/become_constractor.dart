import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itcase/app/global_widgets/block_button_widget.dart';
import 'package:itcase/app/global_widgets/circular_loading_widget.dart';
import 'package:itcase/app/global_widgets/text_field_widget.dart';
import 'package:itcase/app/modules/account/controllers/become_contractor_controller.dart';
import 'package:itcase/app/modules/auth/views/register/fill_account.dart';
import 'package:itcase/app/modules/tasks/views/task_create.dart';
import 'package:itcase/common/ui.dart';

class BecomeConstructor extends GetView<BecomeContractorController> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _textPriceFrom = new TextEditingController();
  TextEditingController _textPriceTo = new TextEditingController();
  TextEditingController _textPricePer = new TextEditingController();

  storeCategories(String text) {
    controller.preLastSub.value = 0;
    controller.categoriesDropDown.id.clear();
    controller.categoriesDropDown.subCategoriesList.clear();
    controller.categoriesDropDown.categories.value = text;
    controller.categoriesDropDown.categoriesList
        .where((element) => element[0][0] == text)
        .forEach((e) {
      e[1].forEach((e) {
        controller.categoriesDropDown.id.add(e[1]);
        controller.categoriesDropDown.subCategoriesList.add(e[0]);
      });
    });
    controller.categoriesDropDown.subCategories.value = "";
  }

  void storeCategory() {
    if (controller.preLastCat.value != 0) {
      controller.category
          .where((element) => element[0] == controller.preLastCat)
          .forEach((element) {
        element[1] = controller.submit;
      });
      controller.preLastCat.value = 0;
    }
  }

  void storeElements({index = 0}) {
    print(controller.submit);
    if (controller.current.length > 4) {
      return error(message: "You cannot choose more than four category".tr);
    }
    if (controller.preLastSub.value != 0 && checkValidateForm()) {
      controller.current.add(controller.preLastSub.value);
      Map body = controller.submit
          .firstWhere((element) => element['id'] == controller.preLastSub.value,
              orElse: () {
        controller.submit.add({'id': controller.preLastSub.value});
        return controller.submit.last;
      });
      body['price_to'] = _textPriceTo.text;
      body['price_from'] = _textPriceFrom.text;
      body['price_per_hour'] = _textPricePer.text;
      controller.isChosen.value = true;
      success();
    } else {
      error();
    }
  }

  success() {
    Get.showSnackbar(Ui.SuccessSnackBar(message: "You added category".tr));
  }

  remove() {
    Get.showSnackbar(Ui.SuccessSnackBar(message: "You removed category".tr));
  }

  void clean() {
    _textPricePer.text = "";
    _textPriceFrom.text = "";
    _textPriceTo.text = "";
  }

  List checkCategory(String text) {
    return controller.category
        .where((element) => element[0] == text)
        .map((e) => controller.category.indexOf(e))
        .toList();
  }

  error({String message = ""}) {
    if (message.isEmpty) {
      message = "Please fill correctly all fields or remove your choice".tr;
    }
    Get.showSnackbar(Ui.ErrorSnackBar(message: message));
  }

  void fillData(Map body) {
    _textPricePer.text = body['price_per_hour'];
    _textPriceFrom.text = body['price_from'];
    _textPriceTo.text = body['price_to'];
  }

  clickedSubCategories(String text) {
    int index = getChosen(text);
    if (checkChosen(text)) {
      Map chosen =
          controller.submit.firstWhere((element) => element['id'] == index);
      fillData(chosen);
      controller.isChosen.value = true;
    } else {
      controller.isChosen.value = false;
      clean();
    }
    controller.preLastSub.value = index;
    controller.categoriesDropDown.subCategories.value = text;
  }

  void removeElements() {
    controller.current.remove(controller.preLastSub.value);
    controller.submit
        .removeWhere((element) => element['id'] == controller.preLastSub.value);
    clean();
    controller.preLastSub.value = 0;
    remove();
  }

  bool regExpressionNumber(String text) {
    return text.isNotEmpty && new RegExp(r'^\d*$').hasMatch(text);
  }

  bool regTextPricePer(String text) {
    return regExpressionNumber(text) && text.length < 9;
  }

  bool checkValidateForm() {
    return regTextPricePer(_textPricePer.text) &&
        regExpressionNumber(_textPriceTo.text) &&
        regExpressionNumber(_textPriceFrom.text);
  }

  int getChosen(String text) {
    int index = controller.categoriesDropDown.subCategoriesList.indexOf(text);
    if (index == -1) {
      return index;
    }
    return controller.categoriesDropDown.id[index];
  }

  bool checkChosen(String text) {
    return controller.current.indexOf(getChosen(text)) == -1 ? false : true;
  }

  Widget getCategories(
      String text, List<String> input, Function onChanged, final controller) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            text,
          ),
          DropdownButton<String>(
            style: Get.textTheme.bodyText2,
            icon: Icon(Icons.arrow_drop_down),
            isExpanded: true,
            hint: Text(controller.value,
                style: Get.textTheme.bodyText1),
            onChanged: (v) {
              // controller.te.value = v;
              onChanged(v);
            },
            items: input.map((String value) {
              bool choosen = checkChosen(value);
              return new DropdownMenuItem<String>(
                value: value,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text(
                      value,
                    style: Get.textTheme.bodyText1)),
                    Visibility(
                      visible: choosen,
                      child: Icon(
                        Icons.check_circle_outline,
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
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
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: Text(
                  "Choose categories".tr,
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
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Visibility(
                  visible: !controller.loading.value,
                  child: Form(
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Column(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                getCategories(
                                    "Categories".tr,
                                    controller.categoriesDropDown.categoriesList
                                        .map<String>((e) => e[0][0])
                                        .toList(),
                                    storeCategories,
                                    controller.categoriesDropDown.categories),
                                SizedBox(
                                  width: 50,
                                ),
                                getCategories(
                                    "SubCategories".tr,
                                    controller.categoriesDropDown.subCategoriesList,
                                    clickedSubCategories,
                                    controller.categoriesDropDown.subCategories)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: Get.height*0.04),
                            child: Visibility(
                              visible: controller.preLastSub.value != 0,
                              child: Column(
                                children: [
                                  Text("Cost of work".tr),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFieldWidget(
                                            controller: _textPriceFrom,
                                            labelText: "Price from".tr,
                                            hintText: "50 000".tr,
                                            keyboardType: TextInputType.number,
                                            suffixText: "UZS",
                                            // onSaved: (val) => controller.priceFrom.value = val,
                                            validator: (val) => val.isNotEmpty
                                                ? null
                                                : "Fill the field".tr,
                                            // initialValue: controller.user.value.phone_number,
                                            // onSaved: (val) => controller.user.value.phone_number = val,
                                          ),
                                        ),
                                        Expanded(
                                          child: TextFieldWidget(
                                            controller: _textPriceTo,
                                            labelText: "Price to".tr,
                                            hintText: "100 000".tr,
                                            suffixText: "UZS",
                                            keyboardType: TextInputType.number,
                                            // onSaved: (val) => controller.priceTo.value = val,
                                            validator: (val) => val.isNotEmpty
                                                ? null
                                                : "Fill the field".tr,
                                            // initialValue: controller.user.value.email,
                                            // iconData: Icons.alternate_email,
                                            // onSaved: (val) => controller.user.value.email = val,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextFieldWidget(
                                    controller: _textPricePer,
                                    labelText: "Price per hour".tr,
                                    hintText: "50 000".tr,
                                    suffixText: "UZS",
                                    keyboardType: TextInputType.number,
                                    // onSaved: (val) => controller.priceFrom.value = val,
                                    validator: (val) =>
                                        val.isNotEmpty ? null : "Fill the field".tr,
                                    // initialValue: controller.user.value.phone_number,
                                    // onSaved: (val) => controller.user.value.phone_number = val,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Stack(
                                      children: [
                                        Visibility(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BlockButtonWidget(
                                                onPressed: () async {
                                                  FocusScope.of(context).unfocus();
                                                  storeElements();
                                                },
                                                color: Get.theme.accentColor,
                                                text: Text(
                                                  "Change".tr,
                                                  style: Get.textTheme.headline6.merge(
                                                      TextStyle(
                                                          color:
                                                              Get.theme.primaryColor)),
                                                ),
                                              ).paddingOnly(
                                                  top: 15,
                                                  bottom: 5,
                                                  right: 20,
                                                  left: 20),
                                              BlockButtonWidget(
                                                onPressed: () async {
                                                  FocusScope.of(context).unfocus();
                                                  removeElements();
                                                },
                                                color: Get.theme.accentColor,
                                                text: Text(
                                                  "Remove".tr,
                                                  style: Get.textTheme.headline6.merge(
                                                      TextStyle(
                                                          color:
                                                              Get.theme.primaryColor)),
                                                ),
                                              ).paddingOnly(
                                                  top: 15,
                                                  bottom: 5,
                                                  right: 20,
                                                  left: 20),
                                            ],
                                          ),
                                          visible: controller.isChosen.value,
                                        ),
                                        Visibility(
                                          visible: !controller.isChosen.value,
                                          child: BlockButtonWidget(
                                            onPressed: () async {
                                              FocusScope.of(context).unfocus();
                                              storeElements();
                                            },
                                            color: Get.theme.accentColor,
                                            text: Text(
                                              "Add".tr,
                                              style: Get.textTheme.headline6.merge(
                                                  TextStyle(
                                                      color: Get.theme.primaryColor)),
                                            ),
                                          ).paddingOnly(
                                              top: 15, bottom: 5, right: 20, left: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.vertical,
                    children: [
                      SizedBox(
                        width: Get.width,
                        child: BlockButtonWidget(
                          onPressed: () async {
                            // controller.fill_data_account(controller.tempUser.value.user_role);
                            controller.submitProfessional();
                          },
                          color: Get.theme.accentColor,
                          text: Text(
                            "Save".tr,
                            style: Get.textTheme.headline6.merge(
                                TextStyle(color: Get.theme.primaryColor)),
                          ),
                        ).paddingOnly(top: 15, bottom: 20, right: 20, left: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
