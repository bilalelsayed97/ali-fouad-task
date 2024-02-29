import 'package:ali_fouad_test/features/auth/login/controllers/login_controller.dart';
import 'package:ali_fouad_test/features/auth/register/controllers/register_controller.dart';
import 'package:ali_fouad_test/features/change_password/controllers/change_pass_controller.dart';
import 'package:ali_fouad_test/features/home/controllers/delete_user_controller.dart';
import 'package:ali_fouad_test/features/home/controllers/home_controller.dart';
import 'package:ali_fouad_test/features/update_user/controllers/update_user_controller.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

//Dependency injection
class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Dio());
    Get.put<RegisterController>(RegisterController());
    Get.put<LoginController>(LoginController());
    Get.put<HomeController>(HomeController());
    Get.put<DeleteUserController>(DeleteUserController(dio: Get.find<Dio>()));
    Get.put<UpdateUserController>(UpdateUserController());
    Get.put<ChangePassController>(ChangePassController());
  }
}
