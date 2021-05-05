/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/ui.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    this.onSaved,
    this.validator,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.iconData,
    this.labelText,
    this.obscureText,
    this.maxLine,
    this.suffixIcon,
    this.isFirst,
    this.isLast,
    this.style,
    this.textAlign,
    this.height,
    this.controller,
    this.suffixText
  }) : super(key: key);

  final FormFieldSetter<String> onSaved;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final String initialValue;
  final String hintText;
  final int maxLine;
  final double height;
  final TextAlign textAlign;
  final String labelText;
  final TextStyle style;
  final IconData iconData;
  final bool obscureText;
  final bool isFirst;
  final bool isLast;
  final String suffixText;
  final Widget suffixIcon;

  widget(){
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      onSaved: onSaved,
      validator: validator,
      maxLines: maxLine ?? 1,
      initialValue: initialValue,
      style: style ?? Get.textTheme.bodyText2,
      obscureText: obscureText ?? false,
      textAlign: textAlign ?? TextAlign.start,
      decoration: Ui.getInputDecoration(
        hintText: hintText ?? '',
        iconData: iconData,
        suffixIcon: suffixIcon,

      ),
    );
  }
  container(Widget widget,{double height,double topMargin = 0,double bottomMargin = 0,String labelText,BorderRadiusGeometry buildBorderRadius}){
    return  Container(
      padding: EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
      margin: EdgeInsets.only(
          left: 20, right: 20, top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
            color: Get.theme.primaryColor,
          borderRadius: buildBorderRadius,
          boxShadow: [
            BoxShadow(
                color: Get.theme.focusColor.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              labelText ?? "",
              style: Get.textTheme.bodyText1,
              textAlign: textAlign ?? TextAlign.start,
            ).marginOnly(bottom: height ?? 0),
          ),
          SizedBox(height: height ?? 0),
          suffixText == null ? widget:
          Row(
            children: [
              Expanded(child: widget),
              Align(
                alignment: Alignment.centerRight,
                child: Text(suffixText,
                  style: Get.textTheme.bodyText1,),
              ),
            ],
          )
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return container(widget(),
    height: height,
    topMargin: topMargin,
    bottomMargin: bottomMargin,
    labelText: labelText,
    buildBorderRadius: buildBorderRadius);
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast != null && isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && !isFirst && isLast != null && !isLast) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst != null && isFirst)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
