part of 'app_pages.dart';

abstract class Routes {
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const FORGOT_PASSWORD = '/forgot_password';
  static const PHONE_VERIFICATION = '/phone_verification';

  static const ROOT = '/root';
  static const RATING = '/rating';
  static const CHAT = '/chat';

  static const SETTINGS_PROFILE = '/settings/profile';
  static const SETTINGS = '/settings';
  static const SETTINGS_THEME_MODE = '/settings/theme_mode';
  static const SETTINGS_LANGUAGE = '/settings/language';
  static const GUEST = "/account/guest";
  static const ACCOUNT = "/account";
  static const PROFILE = '/profile';
  static const CATEGORY = '/category';
  static const CATEGORIES = '/categories';
  static const E_SERVICE = '/e-service';
  static const BOOK_E_SERVICE = '/book-e-service';
  static const CHECKOUT = '/checkout';
  static const CONFIRMATION = '/confirmation';
  static const SEARCH = '/search';
  static const NOTIFICATIONS = '/notifications';
  static const FAVORITES = '/favorites';
  static const HELP = '/help';
  static const PRIVACY = '/privacy';
  static const UPLOAD = '/upload';
  static const TASKS = '/tasks';
  static const CREATE_TASK = '/create-task';
  static const TINDERS_VIEW = '/tinders-view';
  static const BECOME_CONSUMER = "/become-consumer";
  static const BECOME_CONSTRUCTOR = "/become-constructor";
  static const MY_TASKS = "/my-task";
  static const GUEST_TASKS = '/guest-task';
  static const GUEST_REQUESTED_TASKS = "/guest-requested-tasks";
  static const AFTER_REGISTRATION = "/created-account";
  static const MAP = "/map";
  static const TENDER_VIEW = '/tinder-view';
  static const TAKE_OFFER = '/take-offer';
  static const TENDER_SEARCH = '/tinder/search';
  static const TENDER_SEARCH_MAP = '/tinder/search/map';
  static const CHATS_ALL = '/chats/all';
  static const FILL_ACCOUNT = '/fill_account';
  static const DYNAMIC_URL = '/dynamic_url';

  static const REQUESTED_TASKS = '/requested_tasks';
  static const TASK_MODIFY = '/task/modify';
  static const CHANGE_PASSWORD = '/account/change/password';
  static const CONTRACTOR_SEARCH = 'contractor/search';
}
