import 'package:flutter/widgets.dart';

import '../../gen/assets.gen.dart';
import 'app_lottie_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLottieWidget(
     path: Assets.lottie.loading, 
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    );
  }
}
