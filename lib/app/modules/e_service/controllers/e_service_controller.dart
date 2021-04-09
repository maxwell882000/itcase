import 'package:get/get.dart';
import '../../../models/review_model.dart';

import '../../../../common/ui.dart';
import '../../../models/e_service_model.dart';
import '../../../repositories/e_service_repository.dart';

class EServiceController extends GetxController {
  final eService = EService().obs;
  final reviews = List<Review>().obs;
  final currentSlide = 0.obs;
  EServiceRepository _eServiceRepository;

  EServiceController() {
    _eServiceRepository = new EServiceRepository();
  }
  @override
  void onInit() async {
    eService.value = Get.arguments as EService;
    print("SSSSSSSSSSS");
    print(eService.value.category);
    super.onInit();
  }

  @override
  void onReady() async {
    // await refreshEService();
    super.onReady();
  }

  Future refreshEService({bool showMessage = false}) async {
    await getEService();
    // await getReviews();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: eService.value.title + " " + "page refreshed successfully".tr));
    }
  }

  Future getEService() async {
    try {
    eService.value = await _eServiceRepository.get(eService.value.id);
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
