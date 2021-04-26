import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaginationWidget extends StatelessWidget {
  final Function onSubmitForward;
  final Function onSubmitBackward;
  final Function controller;

  PaginationWidget(
      {this.controller, this.onSubmitBackward, this.onSubmitForward});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Visibility(
              visible: !controller().isFirst.value,
              maintainState: true,
              maintainSize: true,
              maintainAnimation: true,
              child: TextButton(
                  onPressed: () => onSubmitForward(),
                  child: Text('Forward'.tr))),
        ),
        Obx(() =>
            Text('Page'.tr + " " + controller().currentPage.value.toString())),
        Obx(
          () => Visibility(
              visible: !controller().isLast.value,
              maintainState: true,
              maintainSize: true,
              maintainAnimation: true,
              child: TextButton(
                  onPressed: () => onSubmitBackward(),
                  child: Text('Backward'.tr))),
        ),
      ],
    );
  }
}
