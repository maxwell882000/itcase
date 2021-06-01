import 'package:get/get.dart' show GetPage, Transition;
import 'package:itcase/app/modules/account/bindings/account_binding.dart';
import 'package:itcase/app/modules/account/bindings/account_tender_bindings.dart';
import 'package:itcase/app/modules/account/bindings/become_contractor_binding.dart';
import 'package:itcase/app/modules/account/views/account_view.dart';
import 'package:itcase/app/modules/account/views/become_constractor.dart';
import 'package:itcase/app/modules/account/views/setttings_view.dart';
import 'package:itcase/app/modules/auth/bindings/fill_account_bindings.dart';
import 'package:itcase/app/modules/auth/bindings/verify_bindings.dart';
import 'package:itcase/app/modules/auth/controllers/auth_controller.dart';
import 'package:itcase/app/modules/auth/views/register/become_consumer.dart';
import 'package:itcase/app/modules/auth/views/register/after_registartion.dart';
import 'package:itcase/app/modules/auth/views/register/fill_account.dart';
import 'package:itcase/app/modules/category/bindings/category_binding_single.dart';
import 'package:itcase/app/modules/messages/bindings/message_bindings.dart';
import 'package:itcase/app/modules/messages/views/messages_view.dart';
import 'package:itcase/app/modules/profile/bindings/change_password_bindings.dart';
import 'package:itcase/app/modules/profile/views/change_password.dart';
import 'package:itcase/app/modules/search/bindings/search_binding.dart';
import 'package:itcase/app/modules/search/views/search_view_contractors.dart';
import 'package:itcase/app/modules/search/views/search_view_map.dart';
import 'package:itcase/app/modules/search/views/search_view_tenders.dart';
import 'package:itcase/app/modules/tasks/bindings/create_task_binding.dart';
import 'package:itcase/app/modules/tasks/bindings/map_binding.dart';
import 'package:itcase/app/modules/tasks/bindings/modify_bindings.dart';
import 'package:itcase/app/modules/tasks/bindings/task_binding.dart';
import 'package:itcase/app/modules/tasks/views/guest_requested_tasks.dart';
import 'package:itcase/app/modules/tasks/views/guest_tasks.dart';
import 'package:itcase/app/modules/tasks/views/map.dart';
import 'package:itcase/app/modules/tasks/views/my_task.dart';
import 'package:itcase/app/modules/tasks/views/requested_tasks.dart';
import 'package:itcase/app/modules/tasks/views/take_offer.dart';
import 'package:itcase/app/modules/tasks/views/task_create.dart';
import 'package:itcase/app/modules/tasks/views/tasks_view.dart';
import 'package:itcase/app/modules/tasks/views/tender_modification.dart';
import 'package:itcase/app/modules/tasks/views/tender_view.dart';
import 'package:itcase/common/notification_test.dart';
import '../modules/account/views/image_upload.dart';

import '../modules/help_privacy/bindings/help_privacy_binding.dart';
import '../modules/help_privacy/views/help_view.dart';
import '../modules/help_privacy/views/privacy_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';

import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/forgot_password_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/phone_verification_view.dart';
import '../modules/auth/views/register/register_view.dart';
import '../modules/book_e_service/bindings/book_e_service_binding.dart';
import '../modules/book_e_service/views/book_e_service_view.dart';
import '../modules/category/bindings/category_binding.dart';
import '../modules/category/views/categories_view.dart';
import '../modules/category/views/category_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/checkout/views/confirmation_view.dart';
import '../modules/e_service/bindings/e_service_binding.dart';
import '../modules/e_service/views/e_service_view.dart';
import '../modules/messages/views/chats_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/rating/bindings/rating_binding.dart';
import '../modules/rating/views/rating_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/search/views/search_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/language_view.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/settings/views/theme_mode_view.dart';
import '../modules/tasks/views/task_intro.dart';
import '../modules/account/views/guest_view.dart';
import 'package:itcase/common/dynamic_link.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(name: Routes.DYNAMIC_URL, page: () => NotificationTest()),
    GetPage(name: Routes.ROOT, page: () => RootView(), binding: RootBinding()),
    GetPage(
        name: Routes.TASK_MODIFY,
        page: () => TaskModification(),
        binding: ModifyTaskBindings()),
    GetPage(
        name: Routes.CHANGE_PASSWORD,
        page: () => ChangePassword(),
        binding: ChangePasswordBindings()),
    GetPage(
      name: Routes.AFTER_REGISTRATION,
      binding: AuthBinding(),
      page: () => AfterRegistration(),
    ),
    GetPage(
      name: Routes.GUEST,
      page: () => GuestView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: Routes.ACCOUNT,
      binding: AccountBinding(),
      page: () => AccountView(),
    ),
    GetPage(
      name: Routes.MAP,
      binding: MapBindings(),
      page: () => Map(),
    ),
    GetPage(
        name: Routes.TINDERS_VIEW,
        page: () => TasksView(),
        binding: TaskBindings()),
    GetPage(name: Routes.MY_TASKS, page: () => MyTasks(),binding: AccountTenderBindings()),
    GetPage(name: Routes.REQUESTED_TASKS, page: () => RequestedTasks(),binding: AccountTenderBindings()),
    GetPage(
        name: Routes.RATING,
        page: () => RatingView(),
        binding: RatingBinding()),
    GetPage(
        name: Routes.CHAT, page: () => ChatsView(), binding: MessageBindings()),
    GetPage(
        name: Routes.CHATS_ALL,
        page: () => MessagesView(),
        binding: MessageBindings()),
    GetPage(
        name: Routes.SETTINGS,
        page: () => SettingsView(),
        binding: SettingsBinding()),
    GetPage(
        name: Routes.SETTINGS_THEME_MODE,
        page: () => ThemeModeView(),
        binding: SettingsBinding()),
    GetPage(
        name: Routes.SETTINGS_LANGUAGE,
        page: () => LanguageView(),
        binding: SettingsBinding()),
    GetPage(
        name: Routes.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding()),
    GetPage(
        name: Routes.CONTRACTOR_SEARCH,
        page: () => SearchViewContractors(),
        binding: SearchBinding()),
    GetPage(
        name: Routes.CATEGORY,
        page: () => CategoryView(),
        binding: CategoryBindingSingle()),
    GetPage(
        name: Routes.CATEGORIES,
        page: () => CategoriesView(),
        binding: CategoryBinding()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginView(), binding: AuthBinding()),
    GetPage(
        name: Routes.BECOME_CONSUMER,
        page: () => BecomeConsumer(),
        binding: FillAccountBindings()),
    GetPage(
        name: Routes.BECOME_CONSTRUCTOR,
        page: () => BecomeConstructor(),
        binding: BecomeContractorBinding()),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterView(),
        binding: VerifyBindings()),
    GetPage(
        name: Routes.FILL_ACCOUNT,
        page: () => FillAccount(),
        binding: FillAccountBindings()),
    GetPage(
        name: Routes.FORGOT_PASSWORD,
        page: () => ForgotPasswordView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.PHONE_VERIFICATION,
        page: () => PhoneVerificationView(),
        binding: VerifyBindings()),
    GetPage(
        name: Routes.E_SERVICE,
        page: () => EServiceView(),
        binding: EServiceBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.BOOK_E_SERVICE,
        page: () => BookEServiceView(),
        binding: BookEServiceBinding()),
    GetPage(
        name: Routes.CHECKOUT,
        page: () => CheckoutView(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.CONFIRMATION,
        page: () => ConfirmationView(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.SEARCH,
        page: () => SearchView(),
        binding: RootBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.NOTIFICATIONS,
        page: () => NotificationsView(),
        binding: NotificationsBinding()),
    // GetPage(
    //     name: Routes.FAVORITES,
    //     page: () => FavoritesView(),
    //     binding: FavoritesBinding()),
    GetPage(name: Routes.GUEST_TASKS, page: () => GuestTasks()),
    GetPage(name: Routes.GUEST_REQUESTED_TASKS, page: () => GuestRequestedTasks()),
    GetPage(
        name: Routes.PRIVACY,
        page: () => PrivacyView(),
        binding: HelpPrivacyBinding()),

    GetPage(
        name: Routes.HELP,
        page: () => HelpView(),
        binding: HelpPrivacyBinding()),
    GetPage(name: Routes.SETTINGS_PROFILE, page: () => SettingsProfileView()),
    GetPage(name: Routes.UPLOAD, page: () => ImageUpload()),
    GetPage(name: Routes.TASKS, page: () => TaskIntro()),
    GetPage(
        name: Routes.TENDER_VIEW,
        page: () => TenderView(),
        binding: TaskBindings()),
    GetPage(
        name: Routes.TAKE_OFFER,
        page: () => TakeOffer(),
        binding: TaskBindings()),
    GetPage(
        name: Routes.TENDER_SEARCH,
        page: () => SearchViewTenders(),
        binding: RootBinding()),
    GetPage(
        name: Routes.TENDER_SEARCH_MAP,
        page: () => SearchMapFilter(),
        binding: SearchBinding()),
    GetPage(
        name: Routes.CREATE_TASK,
        page: () => TaskCreate(),
        binding: CreateTaskBindings()),
  ];
}
