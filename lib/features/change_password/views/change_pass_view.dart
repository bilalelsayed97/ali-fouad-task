import 'package:ali_fouad_test/features/change_password/controllers/change_pass_controller.dart';
import 'package:ali_fouad_test/core/views/loading_indicator.dart';
import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:ali_fouad_test/features/core/views/widgets/main_button.dart';
import 'package:ali_fouad_test/features/core/views/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChangePassView extends StatelessWidget {
  ChangePassView({super.key});

  final controller = Get.find<ChangePassController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsData.whiteColor,
      appBar: AppBar(
        title: const Text(
          StringsData.changePass,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: Column(
              children: [
                const Gap(16),
                CustomTextField(
                  controller: controller.passwordController,
                  hintName: StringsData.currentPass,
                  labelTxt: StringsData.currentPass,
                  fontSize: 14,
                  color: ColorsData.whiteColor,
                  isPass: true,
                  passwordVisibility: controller.passVisibility,
                ),
                const Gap(16),
                CustomTextField(
                  controller: controller.newPasswordController,
                  hintName: StringsData.pass,
                  labelTxt: StringsData.pass,
                  fontSize: 14,
                  color: ColorsData.whiteColor,
                  isPass: true,
                  passwordVisibility: controller.newPassVisibility,
                ),
                const Gap(16),
                CustomTextField(
                  controller: controller.confirmPasswordController,
                  hintName: StringsData.confirmPass,
                  labelTxt: StringsData.confirmPass,
                  fontSize: 14,
                  color: ColorsData.whiteColor,
                  isPass: true,
                  passwordVisibility: controller.confirmPassVisibility,
                ),
                const Gap(24),
                Obx(() {
                  return controller.isLoading.isTrue
                      ? const LoadingIndicator()
                      : Center(
                          child: MainButton(
                              title: StringsData.update,
                              onPressed: () {
                                controller.updatePassword();
                              },
                              hasBackground: true,
                              padding: 13),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
