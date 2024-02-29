import 'package:ali_fouad_test/features/update_user/controllers/update_user_controller.dart';
import 'package:ali_fouad_test/core/views/loading_indicator.dart';
import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:ali_fouad_test/features/core/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../core/views/widgets/text_field.dart';

class UpdateInfoView extends StatelessWidget {
  UpdateInfoView({super.key});

  final controller = Get.find<UpdateUserController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorsData.whiteColor,
      appBar: AppBar(
        title: const Text(
          StringsData.updateInfo,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: SizedBox(
            height: height -
                MediaQuery.of(context).viewPadding.top -
                MediaQuery.of(context).viewPadding.bottom,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64),
              child: Column(
                children: [
                  const Gap(24),
                  CustomTextField(
                    controller: controller.nameController,
                    hintName: StringsData.name,
                    inputType: TextInputType.text,
                    labelTxt: StringsData.name,
                    fontSize: 14,
                    color: ColorsData.whiteColor,
                  ),
                  const Gap(24),
                  CustomTextField(
                    controller: controller.phoneController,
                    hintName: StringsData.phoneNo,
                    inputType: TextInputType.text,
                    labelTxt: StringsData.phoneNo,
                    fontSize: 14,
                    color: ColorsData.whiteColor,
                    prefixShow: true,
                    onChangedCode: (countryCode) {
                      controller.countryCode = countryCode.dialCode!;
                    },
                  ),
                  const Gap(24),
                  CustomTextField(
                    controller: controller.emailController,
                    hintName: StringsData.email,
                    inputType: TextInputType.emailAddress,
                    labelTxt: StringsData.email,
                    fontSize: 14,
                    color: ColorsData.whiteColor,
                  ),
                  const Gap(24),
                  Obx(() {
                    return controller.isLoading.isTrue
                        ? const LoadingIndicator()
                        : Center(
                            child: SizedBox(
                            width: double.infinity,
                            child: MainButton(
                                title: StringsData.save,
                                onPressed: () {
                                  controller.updateUser();
                                },
                                hasBackground: true,
                                padding: 13),
                          ));
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
