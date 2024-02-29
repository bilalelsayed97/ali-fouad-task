import 'package:ali_fouad_test/core/storage_service.dart';
import 'package:dio/dio.dart' as dio_package;
import 'package:get/get.dart';

import 'package:ali_fouad_test/core/views/snakbars.dart';
import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:ali_fouad_test/core/constants/endpoints.dart';
import 'package:ali_fouad_test/core/utility/helper.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';

class DeleteUserController extends GetxController {
  final isLoading = false.obs;
  final dio_package.Dio dio;

  DeleteUserController({required this.dio});

  Future<void> deleteUser() async {
    try {
      await performDeleteUser();
    } catch (exception) {
      handleException(exception);
    }
  }

  Future<void> performDeleteUser() async {
    if (await isOnline()) {
      isLoading.value = true;
      final storage = StorageService().storage;

      try {
        var url = EndPoints.baseUrl + EndPoints.deleteUser;
        String? token = storage.read('token');
        dio.options.headers['Authorization'] = 'Bearer $token';

        dio_package.Response response = await dio.delete(url);

        handleResponse(response);
      } catch (exception) {
        handleException(exception);
      }
    } else {
      isLoading.value = false;
      showError(StringsData.noInternet);
    }
  }

  void handleResponse(dio_package.Response response) {
    isLoading.value = false;

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> userData = response.data;
      if (userData['success'] == true) {
        handleSuccess();
      } else {
        showError(response.data["message"] ?? "Unknown Error Occurred");
      }
    } else {
      showError(response.data["message"] ?? "Unknown Error Occurred");
    }
  }

  void handleSuccess() async {
    final storage = StorageService().storage;
    await storage.remove('user');
    await storage.remove('token');
    await storage.erase();
    showSuccess(StringsData.userDeleted);
    Get.offAllNamed(Routes.landing);
  }

  void handleException(dynamic exception) {
    isLoading.value = false;
    showError(exception.toString());
  }
}
