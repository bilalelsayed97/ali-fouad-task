import 'package:ali_fouad_test/core/utility/assets_data.dart';
import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LogoWithTitle extends StatelessWidget {
  const LogoWithTitle({super.key, required this.width, required this.title});
  final double width;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(16),
        Center(
            child: Image.asset(
          AssetsData.logo,
          height: width * 0.3,
        )),
        const Gap(16),
        Center(
            child: Text(
          title,
          style: const TextStyle(
              fontSize: 30,
              fontFamily: StringsData.boldText,
              color: ColorsData.primaryColor),
        )),
      ],
    );
  }
}
