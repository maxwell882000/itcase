import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/common/pagination_helper.dart';
import 'package:get/get.dart';
class PaginationTenders extends PaginationHelper {
 List  processData({bool refresh = true, final tenders, List data , }){
   if(!this.isLast.value) {
     lastPage.value = data[1];
     currentPage.value = data[2];
     this.check();
     currentPage.value++;

     if (refresh || lastPage.value == 1) {
       tenders.value = <Tenders>[];
       tenders.value = data[0];
       if (tenders.value.length <= 5  && lastPage.value == 1) {
         this.isLast.value = true;
       }
     }
     else {
       data[0].forEach((e) => tenders.add(e));
     }
   }
    return  tenders.value;
  }

}