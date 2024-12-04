import 'package:get/get.dart';

import '../modules/auth/views/login_view.dart' as auth_view;
import '../modules/auth/views/register_view.dart';
import '../modules/jobs/views/job_detail_view.dart';
import '../modules/jobs/views/job_list_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/search/views/search_view.dart';
import '../modules/auth/controllers/auth_controller.dart';
import '../modules/profile/controllers/profile_controller.dart';
import '../modules/jobs/controllers/job_controller.dart';
import '../modules/search/controllers/search_controller.dart';
part 'app_routes.dart';

class AppRoutes {
  static const INITIAL = Routes.LOGIN;
  
  static final routes = [
    GetPage(
      name: '/login',
      page: () => auth_view.LoginView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft
    ),
    GetPage(
      name: '/register',
      page: () => RegisterView(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft
    ),
    GetPage(
      name: '/jobs',
      page: () => JobListView(),
      binding: JobBinding(),
      transition: Transition.fadeIn
    ),
    GetPage(
      name: '/job-detail',
      page: () => JobDetailView(),
      binding: JobBinding(),
      transition: Transition.zoom
    ),
    GetPage(
      name: '/profile',
      page: () => ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.leftToRight
    ),
    GetPage(
      name: '/search',
      page: () => SearchView(),
      binding: SearchBinding(),
      transition: Transition.downToUp
    ),
  ];
}

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}

class JobBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JobController>(() => JobController());
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(() => SearchController());
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Injection des contrôleurs globaux
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => JobController());
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => SearchController());
  }
}