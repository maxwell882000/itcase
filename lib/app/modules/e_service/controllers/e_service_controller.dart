import 'dart:convert';

import 'package:get/get.dart';
import 'package:html/dom.dart';
import 'package:itcase/app/global_widgets/format.dart';
import 'package:itcase/app/models/comments.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/models/user_model.dart';
import 'package:itcase/app/services/auth_service.dart';
import '../../../models/review_model.dart';

import '../../../../common/ui.dart';
import '../../../models/e_service_model.dart';
import '../../../repositories/e_service_repository.dart';

class EServiceController extends GetxController {
  final userConractor = User().obs;
  final reviews = List<Review>().obs;
  final currentSlide = 0.obs;
  final comments = List<Comments>().obs;
  final tenders = List<Tenders>().obs;
  var comment;
  final isLoaded = false.obs;
  final isLoadingTenders = true.obs;
  final currentUser = Get.find<AuthService>().user;
  EServiceRepository _eServiceRepository;

  EServiceController() {
    _eServiceRepository = new EServiceRepository();
  }
  void newComment(){
    comment = new Comments(for_set: userConractor.value.id, who_set: currentUser.value.name, images: currentUser.value.image_gotten).obs;
  }
  @override
  void onInit() async {
    userConractor.value = Get.arguments as User;
    newComment();
    getOwnedTenders();
    getComments();
    super.onInit();
  }

  @override
  void onReady() async {

    super.onReady();
  }
  Future createComment()async{
    print(comment.value.toJson());
    comment.value.date = Format.inputFormat.format(DateTime.now());
    List<Comments> temp = [comment.value];
    comments.value=  comments.value + temp;
    isLoaded.value = true;
    try{
      final response = await _eServiceRepository.createComments(jsonEncode(comment.value.toJson()));
      Get.showSnackbar(Ui.SuccessSnackBar(message: response['success']));
     newComment();
     }
    catch(e){

      print(e);
      // comments.value.remove(comment.value);
    }
  }
  Future refreshEService({bool showMessage = false}) async {
      await getComments();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: userConractor.value.about_myself + " " + "page refreshed successfully".tr));
    }
  }
  Future getComments()async{
      try{
        comments.value = await _eServiceRepository.getComments(userConractor.value.id);
        print(comments);
        isLoaded.value = true;
      }
      catch(e){
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      }
  }
  Future getOwnedTenders()async{
      try
      {
        tenders.value = await _eServiceRepository.getShortTenderOfUser(id:userConractor.value.id);
      }
      catch(e){
        print(e);
      }
      finally {
        isLoadingTenders.value = false;
      }

  }
  Future inviteContractor({String tenderId})async {
    try
    {
      Map result  = await _eServiceRepository.inviteContractor(contractorId: userConractor.value.id, tenderId: tenderId);
      Get.showSnackbar(Ui.SuccessSnackBar(message: result['success']));
    }
    catch(e){
      print(e);
    }
  }
  Future getEService() async {
    try {
      print(userConractor.value.id);
    userConractor.value = await _eServiceRepository.get(userConractor.value.id);
    print(userConractor);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getReviews() async {
    try {
      // reviews.value = await _eServiceRepository.getReviews(eService.value.id);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}