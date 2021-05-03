
import 'package:itcase/app/models/user_model.dart';

import 'package:itcase/common/pagination_helper.dart';

class PaginationContractors extends PaginationHelper {
  List  processData({bool refresh = true, final contractors, List data , }){
    if (!this.isLast.value) {
      lastPage.value = data[1];
      currentPage.value = data[2];
      this.check();
      currentPage.value++;

      if (refresh || lastPage.value == 1) {
        contractors.value = data[0];
        if (contractors.value.length <= 5  && lastPage.value == 1) {
          this.isLast.value = true;
        }
      }
      else {
        data[0].forEach((e) => contractors.add(e));
      }
      print("LATTTT IS ${isLast.value}");
    }
    return  contractors.value;
  }

}