import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:ali_fouad_test/core/utility/themes.dart';
import 'package:ali_fouad_test/features/core/views/widgets/logo_with_title.dart';
import 'package:ali_fouad_test/features/core/views/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:special_text_between_marks/special_text_between_marks.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorsData.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 64,
          ),
          child: Column(
            children: [
              LogoWithTitle(width: width, title: StringsData.welcome),
              const Spacer(),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: MainButton(
                    padding: 12,
                    hasBackground: true,
                    title: StringsData.login,
                    onPressed: () {
                      Get.toNamed(Routes.login);
                    },
                  ),
                ),
              ),
              const Gap(16),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: MainButton(
                    padding: 12,
                    hasBackground: false,
                    title: StringsData.register,
                    onPressed: () {
                      Get.toNamed(Routes.register);
                    },
                  ),
                ),
              ),
              const Spacer(),
              const SpecialTextBetweenMarks(
                  text: 'Designed & Developed by "Ali Fouad"',
                  openMark: '"',
                  closeMark: '"',
                  normalStyle: Themes.normalFooterTextStyle,
                  specialStyle: Themes.specialFooterUnderLineStyle),
            ],
          ),
        ),
      ),
    );
  }
}
