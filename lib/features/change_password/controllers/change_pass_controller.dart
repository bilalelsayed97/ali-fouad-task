import 'dart:convert';
import 'package:ali_fouad_test/core/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:ali_fouad_test/core/views/snakbars.dart';
import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:ali_fouad_test/core/constants/endpoints.dart';
import 'package:ali_fouad_test/core/utility/helper.dart' as helper;
import 'package:ali_fouad_test/core/utility/strings_data.dart';

class ChangePassController extends GetxController {
  var isLoading = false.obs;
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final bool passVisibility = false;
  final bool newPassVisibility = false;
  final bool confirmPassVisibility = false;

  void updatePassword() async {
    await _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    final isOnline = await helper.isOnline();
    if (isOnline) {
      await _performPasswordUpdate();
    } else {
      isLoading.value = false;
      showError(StringsData.noInternet);
    }
  }

  Future<void> _performPasswordUpdate() async {
    isLoading.value = true;
    final storage = StorageService().storage;

    if (_isPasswordUpdateDataValid()) {
      try {
        final response = await _makePasswordUpdateRequest(storage);
        _handlePasswordUpdateResponse(response);
      } catch (exception) {
        isLoading.value = false;
        showError(exception.toString());
      }
    } else {
      isLoading.value = false;
      showError(StringsData.warningMsj);
    }
  }

  bool _isPasswordUpdateDataValid() {
    return passwordController.text.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        newPasswordController.text == confirmPasswordController.text;
  }

  Future<http.Response> _makePasswordUpdateRequest(GetStorage storage) async {
    final url = Uri.parse(EndPoints.baseUrl + EndPoints.changePass);
    final token = storage.read('token');
    final headers = {'Authorization': 'Bearer $token'};
    final body = {
      'current_password': passwordController.text.trim(),
      'password': newPasswordController.text.trim(),
      'password_confirm': confirmPasswordController.text.trim()
    };
    return await http.post(url, body: body, headers: headers);
  }

  void _handlePasswordUpdateResponse(http.Response response) {
    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(response.body);
      if (userData['success'] == true) {
        _clearTextFields();
        isLoading.value = false;
        showSuccess(StringsData.passwordChange);
        Get.offAllNamed(Routes.home);
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

  void _clearTextFields() {
    passwordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }
}
