import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
class PaginationHelper{
  final currentPage = 1.obs;
  final lastPage = 1.obs;
  final isLast = false.obs;
  final scrollController = new ScrollController().obs;
  final endOfTheList = false.obs;

  void check(){
    print("CHECKING ${currentPage.value} == ${lastPage.value} \n");
    if (currentPage.value > lastPage.value){
      isLast.value = true;
    }
  }
  void update(){
    currentPage.value = 1;
    isLast.value = false;
  }

  void addingListener({controller}){
    print("CONTROLLER IS ADDDED");
    scrollController.value.addListener((){
      print(scrollController.value.position.pixels);
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent){
        print("IS MOVING ${isLast.value.toString()}");
          if(!isLast.value) {
            controller.showMore(refresh: false);
          }
        }
    });
  }
  void removeListener(){
    scrollController.value.removeListener(() { });
  }
}