import 'package:get/get.dart';
import '../../../models/faq_category_model.dart';
import '../../../repositories/faq_repository.dart';
import '../../../../common/ui.dart';

class HelpController extends GetxController {
  FaqRepository _faqRepository;
  final faqs = List<FaqCategory>().obs;

  HelpController() {
    _faqRepository = new FaqRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshFaqs();
    super.onInit();
  }

  Future refreshFaqs({bool showMessage}) async {
    await getFaqs();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "List of faqs refreshed successfully".tr));
    }
  }

  Future getFaqs() async {
    try {
      faqs.value = await _faqRepository.getCategoriesWithFaqs();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
