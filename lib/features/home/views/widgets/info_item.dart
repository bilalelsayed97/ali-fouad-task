import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class InfoItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const InfoItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: ColorsData.primaryColor),
        const Gap(16),
        Text(
          title,
          style: const TextStyle(
              fontFamily: StringsData.boldText,
              fontSize: 20,
              color: Colors.black45),
        ),
      ],
    );
  }
}
