import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool hasBackground;
  final double padding;
  const MainButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.hasBackground,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: ColorsData.primaryColor, width: 1.0)),
      color: hasBackground ? ColorsData.primaryColor : ColorsData.whiteColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 2 * padding,
          vertical: padding,
        ),
        child: Text(
          title,
          style: TextStyle(
              fontFamily: StringsData.boldText,
              fontSize: 25,
              color: hasBackground
                  ? ColorsData.whiteColor
                  : ColorsData.primaryColor),
        ),
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
