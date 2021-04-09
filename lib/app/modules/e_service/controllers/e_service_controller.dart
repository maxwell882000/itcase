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

  var json = {
    "id": "5fb973cb9e1c95fbd35bcb18",
    "title": "Ludak Service",
    "description":
        "Nisi laborum commodo excepteur pariatur et dolore sunt. Occaecat adipisicing ad eu id velit magna tempor. Eu nostrud non velit in. Laboris non ut labore sit ullamco deserunt reprehenderit velit amet enim cupidatat commodo fugiat. Mollit consequat incididunt incididunt nostrud. Non laboris nostrud minim consectetur sint eiusmod sint laboris in esse.\r\n",
    "min_price": 8.81,
    "max_price": 110.95,
    "pricing": "fixed",
    "rate": 3.53,
    "total_reviews": 55,
    "duration": 160.09,
    "categories": [
      {
        "id": "5fb973cb2d31fd7aba3f14df",
        "name": "Medical Services",
        "image":
            "http://handyman.smartersvision.com/mock/categories/media/nurse.svg",
        "color": "#0abde3"
      },
      {
        "id": "5fb973cb67bad0d611ad5f48",
        "name": "Medical Services",
        "image":
            "http://handyman.smartersvision.com/mock/categories/media/nurse.svg",
        "color": "#0abde3"
      },
      {
        "id": "5fb973cb92e6bbb291c184ed",
        "name": "Car Services",
        "image":
            "http://handyman.smartersvision.com/mock/categories/media/nurse.svg",
        "color": "#0abde3"
      }
    ],
    "sub_categories": [
      {
        "id": "5fb973cb9659908cac5c2729",
        "name": "Car Services",
        "image":
            "http://handyman.smartersvision.com/mock/categories/media/nurse.svg",
        "color": "#0abde3"
      },
      {
        "id": "5fb973cb115441df84487f1d",
        "name": "Medical Services",
        "image":
            "http://handyman.smartersvision.com/mock/categories/media/nurse.svg",
        "color": "#0abde3"
      }
    ],
    "media": [
      {
        "id": "5fb973cb5b8966fafcf32cd4",
        "url": "http://lorempixel.com/400/400/business/4/",
        "thumb": "http://lorempixel.com/200/200/business/2/",
        "icon": "http://lorempixel.com/100/100/business/5/"
      },
      {
        "id": "5fb973cb89d73bc2a2b30e0d",
        "url": "http://lorempixel.com/400/400/business/5/",
        "thumb": "http://lorempixel.com/200/200/business/2/",
        "icon": "http://lorempixel.com/100/100/business/2/"
      },
      {
        "id": "5fb973cba798817e5b828d8d",
        "url": "http://lorempixel.com/400/400/business/2/",
        "thumb": "http://lorempixel.com/200/200/business/5/",
        "icon": "http://lorempixel.com/100/100/business/3/"
      },
      {
        "id": "5fb973cbb5e9ecd0ac6ae238",
        "url": "http://lorempixel.com/400/400/business/4/",
        "thumb": "http://lorempixel.com/200/200/business/5/",
        "icon": "http://lorempixel.com/100/100/business/3/"
      },
      {
        "id": "5fb973cbd1811c413e82f851",
        "url": "http://lorempixel.com/400/400/business/2/",
        "thumb": "http://lorempixel.com/200/200/business/2/",
        "icon": "http://lorempixel.com/100/100/business/2/"
      }
    ],
    "e_provider": {
      "id": "5fb973cb479d7c815ace4c5c",
      "about":
          "Culpa ex qui qui ipsum elit laborum aliqua eu ea veniam laborum ut. Consequat dolore in ad reprehenderit est incididunt minim voluptate tempor. Excepteur velit ipsum magna ipsum adipisicing minim duis. Quis nostrud elit irure commodo est dolor velit. Pariatur elit culpa enim ea dolore deserunt quis laborum duis occaecat nisi ullamco duis. Nulla qui ex anim mollit exercitation duis adipisicing.\r\n",
      "available": false,
      "experience":
          "Aute occaecat sint tempor mollit mollit excepteur nostrud et. Anim Lorem Lorem eiusmod dolore elit eiusmod tempor consequat aliquip laboris dolor minim. Veniam reprehenderit esse enim eiusmod. Ex amet do ipsum irure dolor velit occaecat consequat labore culpa excepteur occaecat non.\r\n",
      "media": [
        {
          "id": "5fb973cb42203b029e6a79eb",
          "url": "http://lorempixel.com/400/400/business/3/",
          "thumb": "http://lorempixel.com/200/200/business/1/",
          "icon": "http://lorempixel.com/100/100/business/3/"
        },
        {
          "id": "5fb973cb271f917d4c418f05",
          "url": "http://lorempixel.com/400/400/business/4/",
          "thumb": "http://lorempixel.com/200/200/business/5/",
          "icon": "http://lorempixel.com/100/100/business/1/"
        },
        {
          "id": "5fb973cbccfff8e48bca6211",
          "url": "http://lorempixel.com/400/400/business/5/",
          "thumb": "http://lorempixel.com/200/200/business/3/",
          "icon": "http://lorempixel.com/100/100/business/5/"
        }
      ],
      "name": "Erika Grimes",
      "phone": "+1 (889) 409-2726",
      "address": "355 Monument Walk, Valle, Vermont, 8192",
      "rate": 4.54,
      "reviews": [
        {
          "id": "5fb973cb215352e540f96dd4",
          "rate": 2.49,
          "review":
              "Non magna ipsum duis qui sunt pariatur do reprehenderit proident ipsum ipsum qui labore ut. Pariatur ad ea nulla ea nulla ea proident duis voluptate occaecat sunt consectetur velit consequat. Exercitation fugiat aliqua laborum eiusmod sint elit nulla. Sint officia reprehenderit aute in deserunt irure ullamco enim sint esse reprehenderit Lorem. Dolore dolor consequat sit magna mollit minim magna labore quis nisi culpa Lorem cillum exercitation. Labore do et incididunt adipisicing esse elit anim laborum in aliqua.\r\n",
          "datetime": "2020-05-29T04:16:18 -01:00"
        },
        {
          "id": "5fb973cbe9b93f5d400cc803",
          "rate": 2.6,
          "review":
              "Enim enim mollit sit magna eu aute do ex incididunt amet aliquip sit officia aliquip. Occaecat commodo ea fugiat excepteur incididunt id qui irure dolore labore labore sint ullamco. Incididunt eu labore sunt minim. Ea cupidatat consectetur ad culpa eiusmod excepteur incididunt voluptate ea sint ea amet ad.\r\n",
          "datetime": "2019-10-10T02:41:46 -01:00"
        },
        {
          "id": "5fb973cbb5168e3fe9dce4f2",
          "rate": 3.82,
          "review":
              "Aute sunt nisi laborum pariatur amet tempor consectetur elit reprehenderit laborum Lorem consectetur consequat nostrud. Elit ea anim mollit sint est. Elit mollit id deserunt sint. In velit laborum tempor ex nisi reprehenderit est. Aute adipisicing qui est deserunt veniam sit aute sit aliqua tempor voluptate.\r\n",
          "datetime": "2020-01-01T09:55:03 -01:00"
        },
        {
          "id": "5fb973cb6396e2d0bf403269",
          "rate": 4.48,
          "review":
              "Adipisicing sint sit id eiusmod aute proident Lorem occaecat excepteur duis. Duis aute duis aute velit quis ut labore irure. Nulla officia veniam esse elit do labore enim. Voluptate labore dolor officia culpa eu. Qui commodo eiusmod mollit sit reprehenderit ipsum. Enim deserunt laboris consectetur id. Adipisicing ex sit duis veniam dolor ea ipsum pariatur culpa sit.\r\n",
          "datetime": "2020-05-08T01:43:40 -01:00"
        }
      ],
      "total_reviews": 1112,
      "verified": true,
      "tasks_in_progress": 3
    },
    "e_company": {
      "id": "5fb973cb0e4a1efc4c2b086e",
      "about":
          "Excepteur eu consequat officia aliqua consequat laboris velit consectetur duis esse consectetur veniam et amet. Labore elit nostrud esse ullamco laborum consectetur. Consectetur voluptate officia ullamco quis elit voluptate.\r\n",
      "available": true,
      "experience":
          "Non ipsum ea labore ut Lorem nulla elit eu ullamco esse officia. Eiusmod nisi sunt proident sunt ad deserunt tempor culpa sint aute ex. Sit consectetur consectetur anim quis commodo aute.\r\n",
      "media": [
        {
          "url": "http://lorempixel.com/400/400/business/2/",
          "thumb": "http://lorempixel.com/200/200/business/3/",
          "icon": "http://lorempixel.com/100/100/business/5/"
        },
        {
          "url": "http://lorempixel.com/400/400/business/4/",
          "thumb": "http://lorempixel.com/200/200/business/2/",
          "icon": "http://lorempixel.com/100/100/business/2/"
        },
        {
          "url": "http://lorempixel.com/400/400/business/4/",
          "thumb": "http://lorempixel.com/200/200/business/1/",
          "icon": "http://lorempixel.com/100/100/business/3/"
        },
        {
          "url": "http://lorempixel.com/400/400/business/3/",
          "thumb": "http://lorempixel.com/200/200/business/1/",
          "icon": "http://lorempixel.com/100/100/business/5/"
        }
      ],
      "name": "Norsul",
      "phone": "+1 (841) 600-3975",
      "address": "435 Bokee Court, Teasdale, Pennsylvania, 3674",
      "rate": 1.01,
      "reviews": [
        {
          "id": "5fb973cb5e58ea0045964b53",
          "rate": 2.37,
          "review":
              "Lorem incididunt officia non mollit officia. In cupidatat do culpa irure nostrud exercitation voluptate laborum enim nostrud dolore Lorem. Do eu do dolor esse. Enim sint nulla aute laboris commodo pariatur est sunt.\r\n",
          "datetime": "2019-11-28T12:14:59 -01:00"
        },
        {
          "id": "5fb973cbcbd9cdb44889320d",
          "rate": 3.24,
          "review":
              "Proident anim incididunt ut magna. Eu esse ullamco sunt qui dolor labore in labore aliqua pariatur consequat velit labore. Cillum est eu quis mollit. Enim laborum aliquip occaecat minim minim do ad elit eu ad.\r\n",
          "datetime": "2020-02-18T09:26:16 -01:00"
        },
        {
          "id": "5fb973cb6e658342f99f95bb",
          "rate": 2.64,
          "review":
              "Nostrud ut aliquip nisi eiusmod qui deserunt ut aliqua ipsum do esse id. Elit exercitation do et ex sint culpa ullamco officia ex occaecat. Ex reprehenderit laborum do excepteur mollit minim id Lorem nisi velit exercitation consectetur. Velit enim id ut aliquip velit labore ex incididunt voluptate.\r\n",
          "datetime": "2020-10-18T11:48:36 -01:00"
        },
        {
          "id": "5fb973cbdfb6f68f74d03ed5",
          "rate": 3.2,
          "review":
              "Occaecat magna adipisicing elit irure ipsum incididunt laboris do. Minim aliqua minim culpa eiusmod exercitation. Tempor veniam commodo pariatur exercitation sint veniam eiusmod reprehenderit consectetur eu velit pariatur excepteur. Exercitation aliqua esse ad cupidatat adipisicing irure veniam. Eiusmod et aute in ipsum esse.\r\n",
          "datetime": "2019-09-09T09:17:02 -01:00"
        }
      ],
      "total_reviews": 236,
      "verified": true,
      "tasks_in_progress": 1
    }
  };

  EServiceController() {
    _eServiceRepository = new EServiceRepository();
  }
  @override
  void onInit() async {
    // eService.value = Get.arguments as EService;
    // eService.value = eService.value.fromJson(json);

    super.onInit();
  }

  @override
  void onReady() async {
    await refreshEService();
    super.onReady();
  }

  Future refreshEService({bool showMessage = false}) async {
    await getEService();
    await getReviews();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(
          message:
              eService.value.title + " " + "page refreshed successfully".tr));
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
      reviews.value = await _eServiceRepository.getReviews(eService.value.id);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
