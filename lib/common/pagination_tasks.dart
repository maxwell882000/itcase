import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/common/pagination_helper.dart';

class PaginationTasks extends PaginationHelper {
 List<Tenders>  getTasks({bool refresh = true, final task, List data , }){
   lastPage.value = data[1];
   currentPage.value = data[2] + 1;
   this.check();
    if (refresh || lastPage.value ==1) {
      task.value = data[0];
      if (task.value.length < 4){
        this.isLast.value = true;
      }
    }
    else {
      data[0].forEach((e) => task.add(e));
    }

    return  task.value;
  }

}