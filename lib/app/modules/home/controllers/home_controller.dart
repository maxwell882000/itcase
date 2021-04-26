import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:itcase/app/models/chat_model.dart';
import 'package:itcase/app/models/tenders.dart';
import 'package:itcase/app/repositories/chat_repository.dart';
import 'package:itcase/app/repositories/task_repository.dart';
import 'package:itcase/app/routes/app_pages.dart';
import '../../../models/category_model.dart';
import '../../../models/e_service_model.dart';
import '../../../models/slide_model.dart';
import '../../../repositories/category_repository.dart';
import '../../../repositories/e_service_repository.dart';
import '../../../repositories/slider_repository.dart';
import '../../../services/auth_service.dart';

import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../repositories/user_repository.dart';

class HomeController extends GetxController {
  UserRepository _userRepo;
  SliderRepository _sliderRepo;
  CategoryRepository _categoryRepository;
  EServiceRepository _eServiceRepository;
  ChatRepository _chatRepository;
  TaskRepository _taskRepository;
  final addresses = List<Address>(0).obs;
  final slider = List<Slide>(0).obs;
  final currentSlide = 0.obs;
  final tenders = List<Tenders>().obs;
  final eServices = List<EService>(0).obs;
  final categories = List<Category>(0).obs;
  final featured = List<Category>(0).obs;
  final currentPage = 0.obs;
  final lastPage = 0.obs;
  final getMessages = [].obs;
  var timer;
  HomeController() {
    _userRepo = new UserRepository();
    _sliderRepo = new SliderRepository();
    _categoryRepository = new CategoryRepository();
    _eServiceRepository = new EServiceRepository();
    _chatRepository = new ChatRepository();
    _taskRepository = new TaskRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshHome();
    periodicTask();
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    timer.value.cancel();
    super.onClose();
  }
  void periodicTask() {
     timer = Timer.periodic(Duration(seconds: 5), (timer) async {
      
      try {
        List<Chat> message = await _chatRepository.notificationChats();
        message.forEach((Chat element) {
          if (getMessages.value.every((el) => el != element.lastMessage.id)) {
            Get.snackbar(
              element.user.name,
              element.lastMessage.text,
              onTap: (_) => Get.toNamed(Routes.CHAT, arguments: element),
              duration: Duration(seconds: 3),
              animationDuration: Duration(milliseconds: 800),
              snackPosition: SnackPosition.TOP,
            );
          }
        });

        List<String> ids = message.map((e) => e.lastMessage.id).toList();
        if (ids.isNotEmpty) {
          final response = await _chatRepository
              .readSomeMessages(jsonEncode({"messages_id": ids}));
          if (response) {
            getMessages.value = [];
          } else {
            getMessages.value = getMessages.value + ids;
          }
        }
      }
      catch(e){

      }
    }).obs;
  }

  Future refreshHome({bool showMessage = false}) async {
     getTenders();
     getCategories();
    if (showMessage) {
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Home page refreshed successfully".tr));
    }
  }

  Address get currentAddress {
    return Get.find<AuthService>().address.value;
  }

  Future getAddresses() async {
    try {
      addresses.value = await _userRepo.getAddresses();
      if (addresses.isNotEmpty && !currentAddress.hasData) {
        Get.find<AuthService>().address.value = addresses.first;
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getSlider() async {
    try {
      slider.value = await _sliderRepo.getHomeSlider();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getTenders() async {
    try {
      List data = await _taskRepository.getTenders();
      tenders.value = data[0];
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getCategories() async {
    try {
      categories.value = await _categoryRepository.getAll();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getFeatured() async {
    try {
      featured.value = await _categoryRepository.getFeatured();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getRecommendedEServices() async {
    try {
      eServices.value = await _eServiceRepository.getRecommended();
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
