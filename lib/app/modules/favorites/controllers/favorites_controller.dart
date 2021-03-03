// import 'package:get/get.dart';

// import '../../../../common/ui.dart';
// import '../../../models/e_service_model.dart';
// import '../../../repositories/e_service_repository.dart';

// class FavoritesController extends GetxController {
//   final eServices = List<EService>().obs;
//   EServiceRepository _eServiceRepository;

//   FavoritesController() {
//     _eServiceRepository = new EServiceRepository();
//   }

//   @override
//   void onInit() async {
//     await refreshFavorites();
//     super.onInit();
//   }

//   Future refreshFavorites({bool showMessage}) async {
//     await getFavorites();
//     if (showMessage == true) {
//       Get.showSnackbar(Ui.SuccessSnackBar(message: "List of Services refreshed successfully".tr));
//     }
//   }

//   Future getFavorites() async {
//     try {
//       eServices.value = await _eServiceRepository.getFavorites();
//     } catch (e) {
//       Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
//     }
//   }
// }
