import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSuccess(String msg) {
  Get.snackbar(
    "",
    "",
    titleText: const Text(
      "Success",
      style: TextStyle(
          fontSize: 24,
          fontFamily: StringsData.boldText,
          color: ColorsData.whiteColor),
    ),
    messageText: Text(
      msg,
      style: const TextStyle(
          fontSize: 16,
          fontFamily: StringsData.boldText,
          color: ColorsData.whiteColor),
    ),
    backgroundColor: ColorsData.greenColor,
    colorText: ColorsData.whiteColor,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 2),
  );
}

showError(String msg) {
  Get.snackbar(
    "",
    "",
    titleText: const Text(
      "Error",
      style: TextStyle(
          fontSize: 24,
          fontFamily: StringsData.boldText,
          color: ColorsData.whiteColor),
    ),
    messageText: Text(
      msg,
      style: const TextStyle(
          fontSize: 16,
          fontFamily: StringsData.boldText,
          color: ColorsData.whiteColor),
    ),
    backgroundColor: ColorsData.redColor,
    colorText: ColorsData.whiteColor,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(seconds: 2),
  );
}
