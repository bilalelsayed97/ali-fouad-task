import 'dart:convert';
import 'package:ali_fouad_test/core/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:ali_fouad_test/core/views/snakbars.dart';
import 'package:ali_fouad_test/features/core/models/user_model.dart';
import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:ali_fouad_test/core/constants/endpoints.dart';
import 'package:ali_fouad_test/core/utility/helper.dart' as helper;
import 'package:ali_fouad_test/core/utility/strings_data.dart';

class UpdateUserController extends GetxController {
  var user = Rxn<User>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  late String countryCode = '';
  var isLoading = false.obs;

  @override
  onInit() {
    super.onInit();
    getUserData();
  }

  getUserData() async {
    final storage = StorageService().storage;
    var userData = jsonDecode(storage.read('user') ?? '{}');

    user.value = User.fromJson(userData);
    if (user.value != null) {
      nameController.text = user.value!.name ?? '';
      emailController.text = user.value!.email ?? '';
      phoneController.text = user.value!.phone ?? '';
      countryCode = user.value!.countryCode ?? '';
    }
  }

  void updateUser() async {
    final isOnline = await helper.isOnline();
    if (!isOnline) {
      showError(StringsData.noInternet);
      return;
    }

    isLoading.value = true;

    if (_isUserDataValid()) {
      try {
        final response = await _makeUpdateRequest();
        _handleUpdateResponse(response);
      } catch (exception) {
        isLoading.value = false;
        showError(exception.toString());
      }
    } else {
      isLoading.value = false;
      showError(StringsData.warningMsj);
    }
  }

  bool _isUserDataValid() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  Future<http.Response> _makeUpdateRequest() async {
    final url = Uri.parse(EndPoints.baseUrl + EndPoints.updateUser);
    final storage = StorageService().storage;
    final token = storage.read('token') ?? '';
    final header = {'Authorization': 'Bearer $token'};
    final body = {
      'name': nameController.text.trim(),
      'email': emailController.text.trim(),
      'phone': phoneController.text.trim(),
      'country_code': countryCode
    };
    return await http.post(url, body: body, headers: header);
  }

  void _handleUpdateResponse(http.Response response) {
    isLoading.value = false;

    if (response.statusCode == 201 || response.statusCode == 200) {
      final Map<String, dynamic> userData = jsonDecode(response.body);
      if (userData['success'] == true) {
        final storage = StorageService().storage;
        final token = storage.read('token') ?? '';
        final data = jsonDecode(storage.read('user') ?? '{}');
        final user = UserModel.fromJson({
          'success': userData['success'],
          'message': userData['message'],
          'data': {
            'id': userData['data']['id'],
            'name': userData['data']['name'],
            'country_code': userData['data']['country_code'],
            'phone': userData['data']['phone'],
            'email': userData['data']['email'],
            'token': token,
            'tokenExpiry': data['tokenExpiry'],
          }
        });

        storage.remove('user');
        storage.write('user', jsonEncode(user.data));
        emailController.clear();
        nameController.clear();
        phoneController.clear();
        Get.offAllNamed(Routes.home);
      } else {
        showError(userData['message'] ?? 'Unknown Error Occurred');
      }
    } else {
      showError(
          jsonDecode(response.body)['message'] ?? 'Unknown Error Occurred');
    }
  }
}
