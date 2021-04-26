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
    scrollController.value.addListener((){
      if (scrollController.value.position.pixels ==
          scrollController.value.position.maxScrollExtent){
          if(!isLast.value) {
            print("START SEARCHing");
            controller.showMore(refresh: false);
          }
      }
    });
  }
}