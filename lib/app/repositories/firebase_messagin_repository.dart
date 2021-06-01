import 'package:itcase/app/providers/api.dart';

class FirebaseMessagingRepository {

  Future<bool> sendMessageToken(String token) async{
    final result = await API().post(token, 'account/token_message/save');
    print(result.body);
    if (result.statusCode == 200){
      return true;
    }
    return false;
  }
}