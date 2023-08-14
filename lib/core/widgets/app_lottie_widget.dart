import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLottieWidget extends StatelessWidget {
  final String path;
  final double height, width;
  final BoxFit fit;
  const AppLottieWidget({
    super.key,
    required this.path,
    this.height = 200,
    this.width = 200,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(
      path, // Replace with your JSON file path
      width: width,
      height:height,
      fit: fit,
    );
  }
}
