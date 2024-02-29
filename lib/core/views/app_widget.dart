import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:ali_fouad_test/core/utility/themes.dart';
import 'package:ali_fouad_test/core/views/routes/routes.dart';
import 'package:ali_fouad_test/features/binding/app_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AliFouad extends StatelessWidget {
  const AliFouad({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: StringsData.appName,
      theme: ThemeData(appBarTheme: Themes.appBarTheme),
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.appRoutes(),
      initialRoute: Routes.initial,
      initialBinding: AppBinding(),
    );
  }
}
