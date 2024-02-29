import 'dart:convert';
import 'package:ali_fouad_test/core/storage_service.dart';
import 'package:ali_fouad_test/features/core/models/user_model.dart';
import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var user = Rxn<User>();

  @override
  onInit() async {
    super.onInit();
    await getUserData();
  }

  getUserData() async {
    final storage = StorageService().storage;
    var data = await jsonDecode(storage.read('user')!);
    user.value = User.fromJson(data);
  }

  logoutUser() async {
    final storage = StorageService().storage;
    await storage.remove('token');
    await storage.remove('user');
    await storage.erase();
    Get.offAllNamed(Routes.landing);
  }
}
