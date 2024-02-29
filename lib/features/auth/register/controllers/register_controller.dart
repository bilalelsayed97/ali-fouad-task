import 'dart:convert';
import 'package:ali_fouad_test/core/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:ali_fouad_test/core/views/snakbars.dart';
import 'package:ali_fouad_test/features/core/models/user_model.dart';
import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:ali_fouad_test/core/constants/endpoints.dart';
import 'package:ali_fouad_test/core/utility/helper.dart' as helper;
import 'package:ali_fouad_test/core/utility/strings_data.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNoController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bool passVisibility = false;
  final bool confirmPassVisibility = false;
  late String countryCode = '';
  var isLoading = false.obs;

  void registerUser() async {
    await _checkInternetConnectionandRegister();
  }

  Future<void> _checkInternetConnectionandRegister() async {
    final isOnline = await helper.isOnline();
    if (isOnline) {
      await _performRegistration();
    } else {
      isLoading.value = false;
      showError(StringsData.noInternet);
    }
  }

  Future<void> _performRegistration() async {
    isLoading.value = true;
    final storage = StorageService().storage;

    if (_isRegistrationDataValid()) {
      try {
        final response = await _makeRegistrationRequest();
        _handleRegistrationResponse(response, storage);
      } catch (exception) {
        isLoading.value = false;
        showError(exception.toString());
      }
    } else {
      isLoading.value = false;
      showError(StringsData.warningMsj);
    }
  }

  bool _isRegistrationDataValid() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneNoController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  Future<http.Response> _makeRegistrationRequest() async {
    final url = Uri.parse(EndPoints.baseUrl + EndPoints.register);
    final body = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'country_code': countryCode,
      'phone': phoneNoController.text.trim(),
      'password': passwordController.text.trim(),
      'password_confirm': confirmPasswordController.text.trim()
    };
    return await http.post(url, body: body);
  }

  void _handleRegistrationResponse(http.Response response, GetStorage storage) {
    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(response.body);
      if (userData['success'] == true) {
        final user = UserModel.fromJson(userData);
        _saveUserData(storage, user);
        _clearTextFields();
        isLoading.value = false;
        Get.offNamed(Routes.home);
      } else {
        isLoading.value = false;
        showError(userData["message"] ?? "Unknown Error Occurred");
      }
    } else {
      isLoading.value = false;
      showError(
          jsonDecode(response.body)["message"] ?? "Unknown Error Occurred");
    }
  }

  void _saveUserData(GetStorage storage, UserModel user) async {
    await storage.write('token', user.data!.token!);
    await storage.write('user', jsonEncode(user.data));
  }

  void _clearTextFields() {
    nameController.clear();
    emailController.clear();
    phoneNoController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
