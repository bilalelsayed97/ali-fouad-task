import 'dart:convert';

import 'package:ali_fouad_test/core/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:ali_fouad_test/core/constants/endpoints.dart';
import 'package:ali_fouad_test/core/utility/helper.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:ali_fouad_test/core/views/snakbars.dart';
import 'package:ali_fouad_test/features/core/models/user_model.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final bool passVisibility = false;
  final RxBool isLoading = false.obs;

  Future<void> loginUser() async {
    if (!(await isOnline())) {
      isLoading.value = false;
      showError(StringsData.noInternet);
      return;
    }

    isLoading.value = true;

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      isLoading.value = false;
      showError(StringsData.warningMsj);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(EndPoints.baseUrl + EndPoints.login),
        body: {
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        },
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseData['success'] == true) {
          final UserModel user = UserModel.fromJson(responseData);

          final storage = StorageService().storage;
          await storage.write('token', user.data!.token!);
          await storage.write('user', jsonEncode(user.data));

          emailController.clear();
          passwordController.clear();
          isLoading.value = false;

          Get.offNamed(Routes.home);
        } else {
          isLoading.value = false;
          showError(responseData["message"] ?? "Unknown Error Occurred");
        }
      } else {
        isLoading.value = false;
        showError(responseData["message"] ?? "Unknown Error Occurred");
      }
    } catch (exception) {
      isLoading.value = false;
      showError(exception.toString());
    }
  }
}
