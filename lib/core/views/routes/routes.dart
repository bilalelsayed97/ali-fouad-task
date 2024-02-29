import 'package:ali_fouad_test/features/change_password/views/change_pass_view.dart';
import 'package:ali_fouad_test/features/home/views/home_view.dart';
import 'package:ali_fouad_test/features/auth/landing/views/landing_view.dart';
import 'package:ali_fouad_test/features/auth/login/views/login_view.dart';
import 'package:ali_fouad_test/features/auth/register/views/register_view.dart';
import 'package:ali_fouad_test/features/splash/views/splash_view.dart';
import 'package:ali_fouad_test/features/update_user/views/update_view.dart';
import 'package:get/get.dart';

class Routes {
  static const initial = '/';
  static const landing = '/landing';
  static const register = '/register';
  static const login = '/login';
  static const home = '/home';
  static const update = '/update';
  static const changePass = '/changePass';
}

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: Routes.initial,
          page: () => const SplashView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: Routes.landing,
          page: () => const LandingView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: Routes.register,
          page: () => RegisterView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: Routes.login,
          page: () => LoginView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.leftToRightWithFade,
        ),
        GetPage(
          name: Routes.home,
          page: () => HomeView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.zoom,
        ),
        GetPage(
          name: Routes.update,
          page: () => UpdateInfoView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: Routes.changePass,
          page: () => ChangePassView(),
          transitionDuration: const Duration(milliseconds: 250),
          transition: Transition.rightToLeftWithFade,
        ),
      ];
}
