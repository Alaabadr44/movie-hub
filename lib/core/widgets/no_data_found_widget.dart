import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import 'app_lottie_widget.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLottieWidget(
  path:    Assets.lottie.noData, 
      width: 250,
      height: 250,
      fit: BoxFit.cover,
    );
  }
}
