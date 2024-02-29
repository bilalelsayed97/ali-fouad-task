import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitThreeBounce(
        size: 25,
        color: ColorsData.primaryColor,
      ),
    );
  }
}
