import 'package:itcase/app/models/message_model.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/common/pagination_helper.dart';

class PaginationMessages extends PaginationHelper {
  List<Message>  getMessages({bool refresh = true, final message, List data , }){
    if(!this.isLast.value) {
      lastPage.value = data[1];
      currentPage.value = data[2];
      this.check();
      currentPage.value++;
      if (refresh || lastPage.value == 1) {
        List<Message> tempMessage = data[0] as List<Message>;
        message.value = message.value + tempMessage;
        if (message.value.length < 30 && lastPage.value == 1) {
          this.isLast.value = true;
        }
      }
      else {
        List<Message> tempMessage = data[0] as List<Message>;
        message.value = tempMessage + message.value;
      }
    }
      return message.value;

  }


}