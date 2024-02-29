//
import 'package:ali_fouad_test/features/home/controllers/delete_user_controller.dart';
import 'package:ali_fouad_test/features/home/controllers/home_controller.dart';
import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:ali_fouad_test/core/views/loading_indicator.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:ali_fouad_test/features/home/views/widgets/home_item.dart';
import 'package:ali_fouad_test/features/home/views/widgets/info_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.find<HomeController>();

  final deleteController = Get.find<DeleteUserController>();

  @override
  void initState() {
    controller.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringsData.home,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Gap(32),
            Obx(() {
              return controller.user.value != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InfoItem(
                              title: controller.user.value!.name!,
                              icon: Icons.person_2_outlined),
                          const Gap(16),
                          InfoItem(
                              title:
                                  '${controller.user.value!.countryCode!}${controller.user.value!.phone!}',
                              icon: Icons.phone_android_rounded),
                          const Gap(16),
                          InfoItem(
                              title: controller.user.value!.email!,
                              icon: Icons.email_outlined),
                          const Gap(32),
                        ],
                      ),
                    )
                  : Container();
            }),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              child: Column(
                children: [
                  HomeItem(
                    title: StringsData.updateInfo,
                    onPressed: () {
                      Get.toNamed(Routes.update);
                    },
                  ),
                  HomeItem(
                    title: StringsData.changePass,
                    onPressed: () {
                      Get.toNamed(Routes.changePass);
                    },
                  ),
                  Obx(() {
                    return deleteController.isLoading.isTrue
                        ? const LoadingIndicator()
                        : HomeItem(
                            title: StringsData.deleteAccount,
                            onPressed: () {
                              deleteController.deleteUser();
                            },
                          );
                  }),
                  HomeItem(
                    title: StringsData.logout,
                    onPressed: () {
                      controller.logoutUser();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
