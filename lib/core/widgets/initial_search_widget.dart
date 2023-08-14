import 'package:flutter/widgets.dart';

import '../../gen/assets.gen.dart';
import 'app_lottie_widget.dart';

// initial_search_widget
class InitialSearchWidget extends StatelessWidget {
  const InitialSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLottieWidget(
      path: Assets.lottie.initSearch,
      width: 150,
      height: 150,
      fit: BoxFit.cover,
    );
  }
}
