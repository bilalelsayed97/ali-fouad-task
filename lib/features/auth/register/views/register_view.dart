import 'package:ali_fouad_test/features/auth/register/controllers/register_controller.dart';
import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:ali_fouad_test/core/views/loading_indicator.dart';
import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:ali_fouad_test/core/utility/themes.dart';
import 'package:ali_fouad_test/features/core/views/widgets/logo_with_title.dart';
import 'package:ali_fouad_test/features/core/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:special_text_between_marks/special_text_between_marks.dart';
import '../../../core/views/widgets/text_field.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsData.whiteColor,
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
                  LogoWithTitle(width: width, title: StringsData.register),
                  const Spacer(),
                  CustomTextField(
                    controller: controller.nameController,
                    hintName: StringsData.name,
                    inputType: TextInputType.text,
                    labelTxt: StringsData.name,
                    fontSize: 14,
                    color: ColorsData.whiteColor,
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: controller.phoneNoController,
                    hintName: StringsData.phoneNo,
                    inputType: TextInputType.number,
                    labelTxt: StringsData.phoneNo,
                    fontSize: 14,
                    color: ColorsData.whiteColor,
                    prefixShow: true,
                    onChangedCode: (countryCode) {
                      controller.countryCode = countryCode.dialCode!;
                    },
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: controller.emailController,
                    hintName: StringsData.email,
                    inputType: TextInputType.emailAddress,
                    labelTxt: StringsData.email,
                    fontSize: 14,
                    color: ColorsData.whiteColor,
                  ),
                  const Gap(16),
                  CustomTextField(
                    controller: controller.passwordController,
                    hintName: StringsData.pass,
                    labelTxt: StringsData.pass,
                    fontSize: 14,
                    color: ColorsData.whiteColor,
                    isPass: true,
                    passwordVisibility: controller.passVisibility,
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
                  const Gap(32),
                  Obx(() {
                    return controller.isLoading.isTrue
                        ? const LoadingIndicator()
                        : Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: MainButton(
                                padding: 12,
                                hasBackground: true,
                                title: StringsData.register,
                                onPressed: () {
                                  controller.registerUser();
                                },
                              ),
                            ),
                          );
                  }),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.login);
                    },
                    child: const SpecialTextBetweenMarks(
                        text:
                            '${(StringsData.haveAccount)} "${(StringsData.login)}"',
                        openMark: '"',
                        closeMark: '"',
                        normalStyle: Themes.normalFooterTextStyle,
                        specialStyle: Themes.specialFooterBoldStyle),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
